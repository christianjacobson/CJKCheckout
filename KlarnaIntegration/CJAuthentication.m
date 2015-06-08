//
//  CJAuthentication.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2013-07-24.
//  Copyright (c) 2013 Christian Jacobson. All rights reserved.
//

#import "CJAuthentication.h"
#import <CommonCrypto/CommonHMAC.h>
#import "NSData+Base64.h"
#import "NSString+NSHash.h"

@implementation CJAuthentication

+ (NSString*)signRequest:(NSString*)payload {
    NSString *key = @"rtpukRTiiIuGTAx";
    
    NSString *hashString = [NSString stringWithFormat:@"%@%@",payload,key];
    NSData *hashed = [hashString SHA256Raw];
    NSString *signature = [hashed base64EncodedString];
    
    return signature;
}

+ (NSMutableURLRequest*)prepareRequestTo:(NSString*)url withPayload:(NSString*)payload {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    [request setValue:@"application/vnd.klarna.checkout.aggregated-order-v2+json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/vnd.klarna.checkout.aggregated-order-v2+json" forHTTPHeaderField:@"Accept"];
    
    NSString *signature = [CJAuthentication signRequest:payload];
    [request setValue:[NSString stringWithFormat:@"Klarna %@", signature] forHTTPHeaderField:@"Authorization"];
    
    [request setHTTPBody:[payload dataUsingEncoding:NSUTF8StringEncoding]];
    
    return request;
}

@end
