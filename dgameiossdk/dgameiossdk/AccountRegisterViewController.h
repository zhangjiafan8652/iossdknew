//
//  AccountRegisterViewController.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/12/17.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DgameUtils.h"
#import "AFNetworking.h"
#import "NSDictionary+XHLogHelper.h"
#import "StringConstants.h"
#import "DgameSdk.h"

@interface AccountRegisterViewController : UIViewController<UITextFieldDelegate>


@property  UIView *muiview;
@property  UIButton *preview;

@property  UITextField *accountnumber;
@property  UITextField *password;
@property  UITextField *repassword;

@property  UIButton *okbutton;

@end
