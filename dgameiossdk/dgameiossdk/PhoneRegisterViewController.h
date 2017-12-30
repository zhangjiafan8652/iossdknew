//
//  PhoneRegisterViewController.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/29.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DgameUtils.h"
#import "StringConstants.h"
@interface PhoneRegisterViewController : UIViewController<UITextFieldDelegate>

@property  int mtimertime;//倒计时计数器
@property  NSTimer *timer;
@property  UIView *muiview;
@property  UIButton *preview;

@property  UITextField *phonenumber;
@property  UITextField *password;
@property  UITextField *code_textfiled;
@property  UIButton *sendcodebutton;
@property  UIButton *okbutton;
@property  UIButton *acountregister;
@end
