//
//  CJMainView.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2015-06-07.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import "CJMainView.h"

const CGFloat kDistanceBetweenTextFields = 40;
const CGFloat kTextFieldHeight = 44;
const CGFloat kTextFieldWidth = 300;

const CGFloat kComponents[8] = { 0.0f, 0.0f, 0.0f, 0.1f, 0.0f, 0.0f, 0.0f, 0.7f };
const CGFloat kLocations[2] = { 0.0f, 1.0f };

NSString * const kProductString = @"Product";
NSString * const kQuantityString = @"Quantity";
NSString * const kReferenceString = @"Reference";
NSString * const kPriceString = @"Price";
NSString * const kMerchantId = @"Merchant ID";

@implementation CJMainView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(space, kComponents, kLocations, 2);
    CGColorSpaceRelease(space);
    
    CGFloat x = CGRectGetMidX(self.bounds);
    CGFloat y = CGRectGetMidY(self.bounds);
    CGPoint point = CGPointMake(x, y);
    CGFloat radius = MAX(x, y);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawRadialGradient(context, gradient, point, 0, point, radius, kCGGradientDrawsAfterEndLocation);
    
    CGGradientRelease(gradient);
}

- (void)dealloc;
{
    NSLog(@"I %@ deallocked",self);
}

- (void)initViews;
{
    [self setBackgroundColor:[UIColor grayColor]];
    
    self.productTextField = [[CJTextField alloc] initWithFrame:CGRectMake(0, 0, kTextFieldHeight, kTextFieldHeight) andPlaceholder:kProductString];
    self.quantityTextField = [[CJTextField alloc] initWithFrame:CGRectMake(0, 200, kTextFieldHeight, kTextFieldHeight) andPlaceholder:kQuantityString];
    self.referenceTextField = [[CJTextField alloc] initWithFrame:CGRectMake(0, 100, kTextFieldHeight, kTextFieldHeight) andPlaceholder:kReferenceString];
    self.priceTextField = [[CJTextField alloc] initWithFrame:CGRectMake(200, 200, kTextFieldHeight, kTextFieldHeight) andPlaceholder:kPriceString];
    self.goButton = [[CJGoButton alloc] initWithFrame:CGRectMake(0, 0, kTextFieldWidth, kTextFieldHeight)];
    
    [self.productTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.quantityTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.referenceTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.priceTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.goButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self addSubview:self.goButton];
    [self addSubview:self.productTextField];
    [self addSubview:self.quantityTextField];
    [self addSubview:self.referenceTextField];
    [self addSubview:self.priceTextField];
}

- (void)addConstrainsToView;
{
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_priceTextField, _productTextField, _referenceTextField, _quantityTextField, _goButton);
    
    NSArray *viewNames = [views allKeys];
    
    NSString *verticalConstraintFormat = [NSString stringWithFormat:@"V:|->=150-[%@(%f)]-10-[%@(%f)]-10-[%@(%f)]-10-[%@(%f)]-10-[%@(%f)]->=150-|", viewNames[0], kTextFieldHeight, viewNames[1], kTextFieldHeight, viewNames[2], kTextFieldHeight, viewNames[3], kTextFieldHeight, viewNames[4], kTextFieldHeight];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalConstraintFormat options:0 metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.productTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.referenceTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.quantityTextField attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.goButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.priceTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:kTextFieldWidth]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.productTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:kTextFieldWidth]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.referenceTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:kTextFieldWidth]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.quantityTextField attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:kTextFieldWidth]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.goButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:kTextFieldWidth]];
    
    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:0.5
          initialSpringVelocity:0.5
                        options:0
                     animations:^{
                         [self layoutIfNeeded];
                     } completion:nil];
}

@end
