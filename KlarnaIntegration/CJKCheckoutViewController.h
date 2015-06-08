//
//  CHKCheckoutViewController.h
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2013-07-24.
//  Copyright (c) 2013 Christian Jacobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFJSONRequestOperation.h"

@interface CJKCheckoutViewController : UIViewController
@property (nonatomic, strong) UIWebView *klarnaWebView;

- (UIViewController *)initWithOrder:(NSDictionary *)order;
- (void)presentInParentViewController:(UIViewController *)parentViewController;
- (void)dismissFromParentViewController;

@end
