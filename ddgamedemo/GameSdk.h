//
//  GameSdk.h
//  dgameiossdk
//
//  Created by Apple on 2018/1/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "GameSdkRole.h"
#import "GameSdkUser.h"
#import "GameSdkOrder.h"
#import "KgameStringConstants.h"
#import <dgameiossdk/DgameSdk.h>
#import <dgameiossdk/DgameUtils.h>
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
@interface GameSdk : NSObject<DgameOnlineInitDelegate,DgameOnlineLoginDelegate,DgameOnlinePayResultDelegate>

@property (nonatomic,weak) id<GameSdkInitDelegate> mInitdelegate;

@property (nonatomic,weak) id<GameSdkLoginDelegate> mLogindelegate;
@property (nonatomic,weak) id<GameSdkPayResultDelegate> mPaydelegate;



//@property (nonatomic,strong) UIViewController *vc;

@property (nonatomic,strong)  GameSdkOrder *morder;

@property (nonatomic,strong)  GameSdkRole *mRole;






+ (GameSdk *) Instance;


- (void) GameSdkinitSDKWithListener:(id) delegate;

- (void) GameSdksetRoleData:(NSString *) roleData;

- (void) GameSdklogin:(NSString *) remain withLoginListener:(id) logindelegate;

-(void) GameSdkpay:(NSString *) unitPrice andName:(NSString *) goodName andExtinfo:(NSString *) extinfo andOrderid:(NSString *) orderid withPayListener:(id) paydelegate;








@end
