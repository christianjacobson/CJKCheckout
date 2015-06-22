//
//  NSDictionary+Order.m
//  CJKCheckoutIntegration
//
//  Created by Christian Jacobson on 2015-05-19.
//  Copyright (c) 2015 Christian Jacobson. All rights reserved.
//

#import "NSDictionary+Order.h"

@implementation NSDictionary (order)

NSString *const kPurchaseCountry = @"purchase_country";
NSString *const kPurchaseCountryValue = @"SE";
NSString *const kPurchaseCurrency = @"purchase_currency";
NSString *const kPurchaseCurrencyValue = @"SEK";
NSString *const kLocale = @"locale";
NSString *const kLocaleValue = @"sv-se";
NSString *const kGui = @"gui";
NSString *const kLayout = @"layout";
NSString *const kLayoutValue = @"mobile";
NSString *const kMerchant = @"merchant";
NSString *const kId = @"id";
NSString *const kIdValue = @"0";
NSString *const kTermsUri = @"terms_uri";
NSString *const kTermsUriValue = @"http://www.yourdomain.se";
NSString *const kCheckoutUri = @"checkout_uri";
NSString *const kCheckoutUriValue = @"http://yourdomain.se/klarna-dev/success.php";
NSString *const kConfirmationUri = @"confirmation_uri";
NSString *const kConfirmationUriValue = @"http://youdomain.se/klarna-dev/confirmation.php?klarna_order={checkout.order.uri}";
NSString *const kPushUri = @"push_uri";
NSString *const kPushUriValue = @"http://youtdomain.se/klarna-dev/push.php?klarna_order={checkout.order.uri}";
NSString *const kCart = @"cart";
NSString *const kItems = @"items";
NSString *const kReference = @"reference";
NSString *const kType = @"type";
NSString *const kTypeShippingFee = @"shipping_fee";
NSString *const kShippingFeeReference = @"SHIPPING";
NSString *const kName = @"name";
NSString *const kShippingFeeName = @"shipping fee";
NSString *const kQuantity = @"quantity";
NSString *const kUnitPrice = @"unit_price";
NSString *const kDiscountRate = @"discount_rate";
NSString *const kTaxRate = @"tax_rate";
NSString *const kKey = @"rtpukRTiiIuGTAx";
static int kTaxRateValue = 2500;


+ (NSDictionary *)newOrder:(NSString *)name andQuantity:(NSNumber *)quantity andReference:(NSString *)reference andPrice:(NSNumber *)price {
    NSDictionary *order = @{kName:name,kQuantity:quantity,kReference:reference,kUnitPrice:[NSNumber numberWithInt:[price intValue] *100]};
    return [NSDictionary dictionaryWithOrder:order];
}

+ (NSDictionary *)dictionaryWithOrder:(NSDictionary *)orders {
    NSDictionary *orderDict = @{
                            kPurchaseCountry:kPurchaseCountryValue,
                            kPurchaseCurrency:kPurchaseCurrencyValue,
                            kLocale:kLocaleValue,
                            kGui:@{
                                    kLayout:kLayoutValue},
                            kMerchant:@{
                                    kId:kIdValue,
                                    kTermsUri:kTermsUriValue,
                                    kCheckoutUri:kCheckoutUriValue,
                                    kConfirmationUri:kConfirmationUriValue,
                                    kPushUri:kPushUriValue},
                            kCart:@{
                                    kItems:@[@{
                                                 kReference:orders[kReference],
                                                 kName:orders[kName],
                                                 kQuantity:orders[kQuantity],
                                                 kUnitPrice:orders[kUnitPrice],
                                                 kDiscountRate:@0,
                                                 kTaxRate:[NSNumber numberWithInt:kTaxRateValue]},@{
                                                 kType:kTypeShippingFee,
                                                 kReference:kShippingFeeReference,
                                                 kName:kShippingFeeName,
                                                 kQuantity:@1,
                                                 kUnitPrice:@0,
                                                 kTaxRate:[NSNumber numberWithInt:kTaxRateValue]}]}};
    
    return orderDict;
}

@end
