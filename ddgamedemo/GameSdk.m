//
//  GameSdk.m
//  dgameiossdk
//
//  Created by Apple on 2018/1/2.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "GameSdk.h"

@implementation GameSdk


static GameSdk *mgamesdk=nil;

+ (GameSdk *)Instance{
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgamesdk=[[self alloc] init];
    });
    return mgamesdk;
    
    
    
    
}

- (void) GameSdkinitSDKWithListener:(id) delegate{
        _mInitdelegate=delegate;
    [[DgameSdk Instance] DgameOnlineHelperinitSDKWithListener:self];
    
    NSString *kkAPPID=[NSBundle mainBundle].infoDictionary[@"kkappid"];
    [DgameUtils setNSUserDefaultskey:@"kkapp_id" andValue:kkAPPID];
}

//设置角色数据
- (void) GameSdksetRoleData:(NSString *) roleData{
    
    [[DgameSdk Instance] DgameOnlineHelpersetRoleData:roleData];

}

- (void) GameSdklogin:(NSString *) remain withLoginListener:(id) logindelegate{
    _mLogindelegate=logindelegate;
    
    
        
    [[DgameSdk Instance] login:remain withLoginListener:self];
}

-(void) GameSdkpay:(NSString *) unitPrice andName:(NSString *) goodName andExtinfo:(NSString *) extinfo andOrderid:(NSString *) orderid withPayListener:(id) paydelegate{
    _mPaydelegate =paydelegate;
    
   // [[DgameSdk Instance] pay:unitPrice andName:goodName andExtinfo:extinfo andOrderid:orderid withPayListener:self];
    
    [self GameSdkCreateOrderMoney:unitPrice andName:goodName withCpOrderId:orderid withCpExt:extinfo];
    
}

-(void) GameSdkCreateOrderMoney:(NSString *) money andName:(NSString *) goodName withCpOrderId:(NSString *) morderid withCpExt:(NSString *)cpext{
    
    
    NSString *kkapp_id = [DgameUtils getNSUserDefaultsBykey:@"kkapp_id"];
    //NSString *idfa = [DgameUtils getNSUserDefaultsBykey:@"idfa"];
    NSString *uid = _mUser.userid;
    
    
    // NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送二进制form数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    NSLog(@"app_id=%@",kkapp_id);
    NSLog(@"username=%@",_mUser.username);
    NSLog(@"uid=%@",uid);
     NSLog(@"amount=%@",money);
     NSLog(@"remark=%@",cpext);
     NSLog(@"transid=%@",morderid);
    NSLog(@"url=%@",kgameunionmakeorder);

    NSDictionary *param = @{@"app_id":kkapp_id, @"username":_mUser.username, @"uid":uid,@"amount":money,@"remark":cpext,@"transid":morderid};
    
    [manager POST:kgameunionmakeorder parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        //success(task,responseObject);
        NSDictionary *responsedic =(NSDictionary *)responseObject;
        // NSString *err_msg = [responsedic objectForKey:@"err_msg"];
        NSLog(@"kgme创建订单%@",responsedic);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"kgame创建订单%@",str);
        if ([str isEqualToString:@"success"]) {
            NSLog(@"创建订单");
            NSDictionary *userinfojson = [KJSON objectForKey:@"data"];
            NSString* kgameorderid=[userinfojson objectForKey:@"id"];
          //  GameSdkUser *muser=[GameSdkUser new];
           // muser.userid=[userinfojson objectForKey:@"uid"];
          //  muser.username=[userinfojson objectForKey:@"username"];
           // muser.token=[userinfojson objectForKey:@"token"];
           // [[GameSdk Instance] setMUser:muser];
            
            //[_mLogindelegate onLoginSuccess:muser andreason:@"登录成功" ];
            [self DgameGotoPay:money andName:goodName andExtinfo:cpext andOrderid:kgameorderid];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        //failure(task,error);
        [_mLogindelegate onLoginFailed:@"登录失败,请检查网络环境" andreason:@"登录失败,请检查网络环境"];
        //[DgameUtils showMessage:@"注册失败,请检查网络环境"];
    }];

    
}

-(void)DgameGotoPay:(NSString *) unitPrice andName:(NSString *) goodName andExtinfo:(NSString *) extinfo andOrderid:(NSString *) orderid {
    //_mPaydelegate =paydelegate;
    
    [[DgameSdk Instance] pay:unitPrice andName:goodName andExtinfo:extinfo andOrderid:orderid withPayListener:self];
    
    //[self GameSdkCreateOrderMoney:unitPrice withCpOrderId:orderid withCpExt:extinfo];
    
}


-(void) onResponse:(NSString *) tag andResponsewhy:(NSString *) value{
    NSLog(@"初始化回掉代理。占时无作用，只是作为sdk的通知%@",tag);
    [_mInitdelegate onResponse:tag andResponsewhy:value];
}

-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain{
    
    
    
     NSString *kkapp_id = [DgameUtils getNSUserDefaultsBykey:@"kkapp_id"];
     NSString *idfa = [DgameUtils getNSUserDefaultsBykey:@"idfa"];
     NSString *uid = user.userid;
    
    // NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送二进制form数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    NSLog(@"kkapp_id=%@",kkapp_id);
    NSLog(@"idfa=%@",idfa);
    NSLog(@"uid=%@",uid);
    NSDictionary *param = @{@"app_id":kkapp_id, @"imei":idfa, @"uid":uid};
    
    [manager POST:unionloginurl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        //success(task,responseObject);
        NSDictionary *responsedic =(NSDictionary *)responseObject;
        // NSString *err_msg = [responsedic objectForKey:@"err_msg"];
        NSLog(@"kgme登录成功返回%@",responsedic);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"kgame登录成功状态%@",str);
        if ([str isEqualToString:@"success"]) {
            NSLog(@"登录成功");
            NSDictionary *userinfojson = [KJSON objectForKey:@"data"];
            GameSdkUser *muser=[GameSdkUser new];
             muser.userid=[userinfojson objectForKey:@"uid"];
             muser.username=[userinfojson objectForKey:@"username"];
            muser.token=[userinfojson objectForKey:@"token"];
            [[GameSdk Instance] setMUser:muser];
           
            [_mLogindelegate onLoginSuccess:muser andreason:@"登录成功" ];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        //failure(task,error);
        [_mLogindelegate onLoginFailed:@"登录失败,请检查网络环境" andreason:@"登录失败,请检查网络环境"];
        //[DgameUtils showMessage:@"注册失败,请检查网络环境"];
    }];


    
    
    
    
    NSString *str=@"登录成功";
    NSLog(@"我在viewcontroller中登录成功%@",[str stringByAppendingString:user.userid]);
   // NSDictionary *parametersDemo = @{@"roleId":@"123",@"roleName":@"jiafan",@"roleLevel":@"12",@"zoneId":@"1",@"zoneName":@"jiafan"};
   // NSString *string=[DgameUtils dictionaryToJson:parametersDemo];
    
    //[[DgameSdk Instance] DgameOnlineHelpersetRoleData:string];
}


-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain{
    NSLog(@"登录失败%@",why);
     [_mLogindelegate onLoginFailed:why andreason:remain];
    
}

-(void) onLoginOut:(NSString *) remain{
    //sdk里的切换账号。游戏收到此代理，应该退出游戏到登录页面
    NSLog(@"登出%@",remain);
    [_mLogindelegate onLoginOut:remain];
    
}


-(void) onSuccess : (NSString*) msg{
    NSLog(@"支付成功%@",msg);
    [_mPaydelegate onSuccess:msg];
    [DgameUtils showMessage:@"游戏支付成功"];
}//支付成功回调

-(void) onFailed : (NSString*) msg{
    NSLog(@"支付失败");
    [_mPaydelegate onFailed:msg];
    [DgameUtils showMessage:@"游戏支付失败"];
}//支付失败回调
@end
