//
//  CJViewController.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2015-05-29.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import "CJViewController.h"
#import "CJKCheckoutViewController.h"
#import "NSDictionary+Order.h"
#import "CJGoButton.h"
#import "CJMainView.h"

@interface CJViewController ()

@property (nonatomic, strong) CJMainView *mainView;

@end

@implementation CJViewController

- (void)viewDidLoad;
{
    [super viewDidLoad];
    [self initViews];
}

- (void)viewDidLayoutSubviews;
{
    [super viewDidLayoutSubviews];
    
}

- (void)didReceiveMemoryWarning;
{
    [super didReceiveMemoryWarning];
}

- (void)showCJKCheckoutViewController;
{
    if ([self sanityCheck]) {
        NSDictionary *orderDictionary = [NSDictionary newOrder:self.mainView.productTextField.text
                                            andQuantity:[NSNumber numberWithInteger:[self.mainView.quantityTextField.text integerValue]]
                                            andReference:self.mainView.referenceTextField.text
                                            andPrice:[NSNumber numberWithInteger:[self.mainView.priceTextField.text integerValue]]];
            
        CJKCheckoutViewController *cjkCheckoutViewController = [[CJKCheckoutViewController alloc] initWithOrder:orderDictionary];
    
        [cjkCheckoutViewController presentInParentViewController:self];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Missing" message:@"Please check that all fields are properly filled in" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)initViews;
{
    self.mainView = [[CJMainView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.mainView];
    [self.mainView initViews];
    [self.mainView addConstrainsToView];
    [self.mainView.goButton addTarget:self action:@selector(showCJKCheckoutViewController) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)sanityCheck;
{
    return ((self.mainView.productTextField.text.length > 0 &&
             self.mainView.quantityTextField.text.length > 0 &&
             self.mainView.referenceTextField.text.length > 0 &&
             self.mainView.priceTextField.text.length > 0) &&
            ([self.mainView.priceTextField.text integerValue] &&
             [self.mainView.quantityTextField.text integerValue]));
}

@end
