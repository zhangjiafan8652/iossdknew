//
//  ApplePayViewController.h
//  ddgamedemo
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DgameUtils.h"
#import "StringConstants.h"
#import "UIView+FSLoading.h"
#import <StoreKit/StoreKit.h>
#import "DgameSdk.h"
@interface ApplePayViewController : UIViewController<SKProductsRequestDelegate,SKPaymentTransactionObserver>

@property (atomic,strong) NSString *productsId;
@property (atomic,strong) NSString *currencyCode;
@property  UIView *muiview;
@property  UIWebView *mwebview;

@property  UIButton *preview;
@end
