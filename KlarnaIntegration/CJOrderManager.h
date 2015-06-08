//
//  CJOrderManager.h
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2013-07-24.
//  Copyright (c) 2013 Christian Jacobson. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(NSString *htmlData);
typedef void (^FailureBlock)(NSError *error);


@interface CJOrderManager : NSObject

+ (void)createOrder:(NSDictionary *)dataset completionBlockWithSuccess:(SuccessBlock)success failure:(FailureBlock)failure;

@end
