//
//  CJMainView.h
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2015-06-07.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJGoButton.h"
#import "CJTextField.h"

@interface CJMainView : UIView

@property (nonatomic, strong) CJGoButton *goButton;
@property (nonatomic, copy) NSMutableArray *constraintsArray;
@property (nonatomic, strong) CJTextField *productTextField;
@property (nonatomic, strong) CJTextField *quantityTextField;
@property (nonatomic, strong) CJTextField *referenceTextField;
@property (nonatomic, strong) CJTextField *priceTextField;
@property (nonatomic, copy) NSDictionary *views;

- (void)addConstrainsToView;
- (void)initViews;

@end
