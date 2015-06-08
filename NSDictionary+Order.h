//
//  NSDictionary+Order.h
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2015-05-19.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (order)

extern NSString *const kReference;
extern NSString *const kName;
extern NSString *const kQuantity;
extern NSString *const kUnitPrice;

+ (NSDictionary *)newOrder:(NSString *)name andQuantity:(NSNumber *)quantity andReference:(NSString *)reference andPrice:(NSNumber *)price;

@end
