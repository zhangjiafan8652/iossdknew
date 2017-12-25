//
//  DgameSdk.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DgameUser.h"
#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "AcountManagerViewController.h"
#import "StringConstants.h"
#import "AFNetworking.h"
#import <AdSupport/AdSupport.h>
#import "NSDictionary+XHLogHelper.h"
#import "LZFloatWindow.h"


//协议开始

@protocol DgameOnlineInitDelegate <NSObject>

@required
-(void) onResponse:(NSString *) tag andResponsewhy:(NSString *) value;

@end

@protocol DgameOnlineLoginDelegate <NSObject>
//登录成功

@required
-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain;
@required
-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain;
@required
-(void) onLoginOut:(NSString *) remain;
@end


//上面定义协议

@interface DgameSdk : NSObject

@property (nonatomic,weak) id<DgameOnlineInitDelegate> mInitdelegate;

@property (nonatomic,weak) id<DgameOnlineLoginDelegate> mLogindelegate;
@property(nonatomic,strong) LZFloatWindow *floatWindow;

@property (nonatomic,strong) UIViewController *vc;


+ (DgameSdk *) Instance;


- (void) DgameOnlineHelperinitSDKWithListener:(id) delegate;

- (void) login:(NSString *) remain;

-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain;

-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain;

-(void) onLoginOut:(NSString *) remain;
//初始化返回
-(void) onResponse:(NSString *) tag andResponsewhy:(NSString *) value;
//关闭viewcotroller
-(void) dismissViewcontroller;
@end
