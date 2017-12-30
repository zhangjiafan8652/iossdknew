//
//  DgamePayViewController.h
//  ddgamedemo
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 doudouyule. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "DgameUtils.h"
#import "StringConstants.h"

#import "AFNetworking.h"
#import "DgameSdk.h"
#import "PayWebViewViewController.h"
@interface DgamePayViewController : UIViewController


@property  UIView *muiview;
@property  UIButton *preview;

@property  UITextField *accountnumber;
@property  UITextField *password;
@property  UITextField *repassword;

@property  UIButton *okbutton;
@end
