//
//  CJGoButton.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2015-05-29.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import "CJGoButton.h"

@implementation CJGoButton

- (id)initWithFrame:(CGRect)frame {
    if  (self = [super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor greenColor]];
        [self.layer setCornerRadius:10];
        [self setTitle:@"GO!" forState:UIControlStateNormal];
    }
    
    return self;
}

@end
