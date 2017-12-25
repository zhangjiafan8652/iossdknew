//
//  LoginViewController.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/24.
//  Copyright © 2017年 doudouyule. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "DgameUtils.h"
#import "PhoneRegisterViewController.h"
#import "AFNetworking.h"
#import "DgameSdk.h"

@interface LoginViewController : UIViewController<UITextFieldDelegate>


@property  UIView *muiview;
@property  UIImageView *titleimage;

@property  UIButton *registerbutton;
@property  UIButton *loginbutton;
@property  UITextField *usernametextview;
@property  UITextField *passwordtextview;
@property(nonatomic,assign) BOOL keyBoardlsVisible; 
- (void)buttonClick:(UIButton *)button;
@end
