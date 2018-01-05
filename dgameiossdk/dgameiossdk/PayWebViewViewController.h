//
//  PayWebViewViewController.h
//  ddgamedemo
//
//  Created by Apple on 2017/12/28.
//  Copyright © 2017年 doudouyule. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DgameUtils.h"

#import "DgameSdk.h"


@interface PayWebViewViewController : UIViewController<UIWebViewDelegate>

@property  UIView *muiview;
@property  UIWebView *mwebview;

@property  UIButton *preview;
@end
