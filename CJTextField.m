//
//  CJTextField.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2015-06-07.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import "CJTextField.h"

@implementation CJTextField

- (id)initWithFrame:(CGRect)frame andPlaceholder:(NSString *)placeholderString;
{
    if (self = [super initWithFrame:frame]) {
        [self setPlaceholder:placeholderString];
        [self.layer setCornerRadius:10.0];
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds;
{
    return CGRectInset(bounds , 10 , 10 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds;
{
    return CGRectInset( bounds , 10 , 10 );
}

@end
