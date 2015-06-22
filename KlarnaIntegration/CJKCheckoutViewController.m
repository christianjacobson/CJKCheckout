//
//  CJKCheckoutViewController.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2013-07-24.
//  Copyright (c) 2013 Christian Jacobson. All rights reserved.
//

#import "CJKCheckoutViewController.h"
#import "CJOrderManager.h"

@interface CJKCheckoutViewController ()

@property (nonatomic, copy) NSDictionary *dataSetDictionary;

@end

@implementation CJKCheckoutViewController

- (UIViewController *)initWithOrder:(NSDictionary *)order;
{
    self = [super init];
    if  (self) {
        self.dataSetDictionary = order;
    }
    return self;
}

- (void)viewDidLoad;
{
    [super viewDidLoad];
    [self addWebView];
    [self order];
}

- (void)addWebView;
{
    self.klarnaWebView = [UIWebView new];
    
    [self.klarnaWebView setFrame:self.view.frame];
    
    [self.view addSubview:self.klarnaWebView];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.klarnaWebView
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1.f
                                                           constant:0.f]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.klarnaWebView
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1.f
                                                           constant:0.f]];
}

- (void)order;
{
    [CJOrderManager createOrder:self.dataSetDictionary completionBlockWithSuccess:^(NSString *htmlData) {
        [self.klarnaWebView loadHTMLString:htmlData baseURL:nil];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)dismissFromParentViewController;
{
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)presentInParentViewController:(UIViewController *)parentViewController;
{
    self.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:self.view];
    [parentViewController addChildViewController:self];
    
    self.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:self.view];
    [parentViewController addChildViewController:self];
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    bounceAnimation.duration = 0.4;
    bounceAnimation.delegate = self;
    bounceAnimation.values = @[ @0.6, @1.4, @0.85, @1.0 ];
    bounceAnimation.keyTimes = @[ @0.0, @0.334, @0.666, @1.0 ];
    bounceAnimation.timingFunctions = @[
                                        [CAMediaTimingFunction
                                         functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction
                                         functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                        [CAMediaTimingFunction
                                         functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.view.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    [self didMoveToParentViewController:parentViewController];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self didMoveToParentViewController:self.parentViewController];
}

@end
