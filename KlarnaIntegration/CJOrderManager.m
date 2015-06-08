//
//  CJOrderManager.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2013-07-24.
//  Copyright (c) 2013 Christian Jacobson. All rights reserved.
//

#import "CJOrderManager.h"
#import "CJAuthentication.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "NSDictionary+Order.h"

@interface CJOrderManager()

@property (nonatomic, copy) NSString *orderData;

@end

@implementation CJOrderManager
    
+ (void)getOrder:(NSString *)uri completionBlockWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    NSMutableURLRequest *request = [CJAuthentication prepareRequestTo:uri withPayload:@""];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[request URL]];
    
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operationResponse, id responseObject) {
        
        NSError *error;
        NSString *responseString = [operationResponse responseString];
        NSData *jsonData = [responseString dataUsingEncoding:NSASCIIStringEncoding];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                 options:kNilOptions
                                                                   error:&error];
        
        success([[jsonDict objectForKey:@"gui"] objectForKey:@"snippet"]);
                
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *err = [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
        
        failure(error);
        NSLog(@"\n\nerror %@ - %@",[error localizedDescription], err);
    }];
    
    [operation start];
}

+ (void)createOrder:(NSDictionary *)dataset completionBlockWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure {
    NSMutableURLRequest *request = [CJAuthentication prepareRequestTo:@"https://checkout.testdrive.klarna.com/checkout/orders" withPayload:[CJOrderManager constructOrder:dataset]];
    
    [request setHTTPMethod:@"POST"];
    
    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[request URL]];
    
    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *orderdict = [[operation response] allHeaderFields];
        NSString *orderurl = [orderdict objectForKey:@"Location"];
        
        [CJOrderManager getOrder:orderurl completionBlockWithSuccess:^(NSString *htmlData) {
            success(htmlData);
        } failure:^(NSError *error) {
            failure(error);
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSString *err = [[NSString alloc] initWithData:[operation responseData] encoding:NSUTF8StringEncoding];
        NSLog(@"\n\nerror %@ - %@",[error localizedDescription], err);
    }];
    
    [operation start];

}

+ (NSString *)constructOrder:(NSDictionary *)order {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:order options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
}

@end
