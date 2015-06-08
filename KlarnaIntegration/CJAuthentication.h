//
//  CJAuthentication.h
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2013-07-24.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CJAuthentication : NSObject

+ (NSString*)signRequest:(NSString*)payload;
+ (NSMutableURLRequest*)prepareRequestTo:(NSString*)url withPayload:(NSString*)payload;

@end
