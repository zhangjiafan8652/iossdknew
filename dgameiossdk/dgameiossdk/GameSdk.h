//
//  GameSdk.h
//  dgameiossdk
//
//  Created by Apple on 2018/1/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>



//协议开始

@protocol GameSdkInitDelegate <NSObject>

@required
-(void) onResponse:(NSString *) tag andResponsewhy:(NSString *) value;

@end

@protocol GameSdkLoginDelegate <NSObject>
//登录成功

@required
-(void) onLoginSuccess:(GameSdkUser *) user andreason:(NSString *) remain;
@required
-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain;
@required
-(void) onLoginOut:(NSString *) remain;
@end

//支付协议
@protocol GameSdkPayResultDelegate <NSObject>

@required
-(void) onSuccess : (NSString*) msg ;//支付成功回调
@required
-(void) onFailed : (NSString*) msg;//支付失败回调

@end
@interface GameSdk : NSObject

@property (nonatomic,weak) id<GameSdkInitDelegate> mInitdelegate;

@property (nonatomic,weak) id<GameSdkLoginDelegate> mLogindelegate;
@property (nonatomic,weak) id<GameSdkPayResultDelegate> mPaydelegate;



@property (nonatomic,strong) UIViewController *vc;

@property (nonatomic,strong)  GameSdkOrder *morder;

@property (nonatomic,strong)  GameSdkRole *mRole;






+ (DgameSdk *) Instance;


- (void) DgameOnlineHelperinitSDKWithListener:(id) delegate;

- (void) DgameOnlineHelpersetRoleData:(NSString *) roleData;

- (void) login:(NSString *) remain withLoginListener:(id) logindelegate;

-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain;

-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain;

-(void) onLoginOut:(NSString *) remain;
//初始化返回
-(void) onResponse:(NSString *) tag andResponsewhy:(NSString *) value;
//关闭viewcotroller
-(void) dismissViewcontroller;
-(void) pay:(NSString *) unitPrice andName:(NSString *) goodName andExtinfo:(NSString *) extinfo andOrderid:(NSString *) orderid withPayListener:(id) paydelegate;

//支付成功回调
-(void) onPaySuccess : (NSString*) msg;
//支付失败回调
-(void) onPayFailed : (NSString*) msg;
//订单号
-(void) onPayOderNo:(NSString*) msg;






@end
