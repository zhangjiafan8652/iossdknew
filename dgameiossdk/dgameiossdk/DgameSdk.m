//
//  DgameSdk.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "DgameSdk.h"
#import "StringConstants.h"

@interface DgameSdk ()



@end


@implementation DgameSdk


static BOOL isShowcenter=NO;

static DgameSdk *mdgamesdk=nil;

+ (DgameSdk *)Instance{

    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mdgamesdk=[[self alloc] init];
    });
    return mdgamesdk;
    
    


}

- (void) DgameOnlineHelperinitSDKWithListener:(id) delegate{
    _mInitdelegate=delegate;
  
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *APPID=[NSBundle mainBundle].infoDictionary[@"ddappid"];
    NSString *app_Version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:APPID forKey:@"app_id"];
    [defaults setObject:app_Version forKey:@"app_version"];
    
    [defaults synchronize];//用synchronize方法把数据持久化到
    
    [DgameUtils setNSUserDefaultskey:@"app_id" andValue:APPID];
    [DgameUtils setNSUserDefaultskey:@"idfa" andValue:IDFA];
    
    
    // NSMutableDictionary *parameters = @{@"idfa":IDFA,@"app_id":APPID};
    //  NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:IDFA,@"idfa",APPID,@"app_id",nil];
    NSLog(@"idfa%@",[DgameUtils getNSUserDefaultsBykey:@"idfa"]
);
    NSLog(@"appid%@",APPID);
    NSLog(@"appid%@",active);
    NSDictionary *parametersDemo = @{@"idfa":IDFA,@"app_id":APPID};
    [manager POST:active parameters:parametersDemo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"初始化成功返回%@",responseObject);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"登录成功状态%@",str);
        if ([str isEqualToString:@"success"]) {
            
            NSDictionary *data=[KJSON objectForKey:@"data"];
            NSString *center_status=[data objectForKey:@"center_status"];
            NSInteger center_statusint = [center_status integerValue];
            //是否显示小手
            if (center_statusint >1) {
                isShowcenter=YES;
                //[self startDouDouPay];
            }else{
                isShowcenter=NO;
                //[ self startApplePay];
            }
            
        }
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];
  
    NSLog(@"调用初始化后");
    
    
}

-(void)ceshi{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *APPID=[NSBundle mainBundle].infoDictionary[@"ddappid"];
    NSString *app_Version = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:APPID forKey:@"app_id"];
    
    [defaults setObject:app_Version forKey:@"app_version"];
    [defaults synchronize];//用synchronize方法把数据持久化到
    
    [DgameUtils setNSUserDefaultskey:@"app_id" andValue:APPID];
    
    
    // NSMutableDictionary *parameters = @{@"idfa":IDFA,@"app_id":APPID};
    //  NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:IDFA,@"idfa",APPID,@"app_id",nil];
    NSLog(@"idfa%@",IDFA);
    NSLog(@"appid%@",APPID);
    NSLog(@"appid%@",active);
    NSDictionary *parametersDemo = @{@"idfa":IDFA,@"app_id":APPID};
    [manager POST:active parameters:parametersDemo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"初始化成功返回%@",responseObject);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"登录成功状态%@",str);
        if ([str isEqualToString:@"success"]) {
           
            NSDictionary *data=[KJSON objectForKey:@"data"];
            NSString *center_status=[data objectForKey:@"center_status"];
            NSInteger center_statusint = [center_status integerValue];
            //是否显示小手
            if (center_statusint >1) {
                
                //[self startDouDouPay];
            }else{
                
                //[ self startApplePay];
            }
            
        }
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];
    
}

//登陆账号
- (void) login:(NSString *) remain withLoginListener:(id)logindelegate{
    _mLogindelegate=logindelegate;
   
    LoginViewController *loginView = [[LoginViewController alloc]init];
    _vc = [UIApplication sharedApplication].windows[0].rootViewController;
    
    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //controller背景透明
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        loginView.providesPresentationContextTransitionStyle = YES;
        loginView.definesPresentationContext = YES;
        loginView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
               NSLog(@"8+");
    } else {
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [_vc presentViewController:loginView animated:NO completion:nil];
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        NSLog(@"8-");
    }
    
    [_vc presentViewController:loginView animated:YES completion:nil];

    
}

//支付方法
-(void) pay:(NSString *) unitPrice andName:(NSString *) goodName andExtinfo:(NSString *) extinfo andOrderid:(NSString *) orderid withPayListener:(id) paydelegate{
    
    
    _mPaydelegate=paydelegate;
    
    _morder=[[DgameOrder alloc] init];
    
    _morder.price=unitPrice;
    _morder.goodname=goodName;
    _morder.cporderid=orderid;
    _morder.cpetc=extinfo;
    _mPaydelegate=paydelegate;
    
    NSLog(@"订单信息：%@",_morder);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    
    NSString *appid=[DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    NSString *uid=[DgameUtils getNSUserDefaultsBykey:@"uid"];
    NSString *token=[DgameUtils getNSUserDefaultsBykey:@"token"];
    
    NSString *app_ver=[DgameUtils getNSUserDefaultsBykey:@"app_version"];
    NSString *role_level=[DgameSdk Instance].mRole.roleLevel;
    
    
    
    
    // NSMutableDictionary *parameters = @{@"idfa":IDFA,@"app_id":APPID};
    //  NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:IDFA,@"idfa",APPID,@"app_id",nil];
    NSLog(@"uid%@",uid);
    NSLog(@"appid%@",appid);
    NSLog(@"app_ver%@",app_ver);
    NSLog(@"role_level%@",role_level);
    NSLog(@"token%@",token);

    NSLog(@"url%@",payinfourl);

    NSDictionary *parametersDemo = @{@"uid":uid,@"app_id":appid,@"app_ver":app_ver,@"role_level":role_level,@"token":token};
    [manager POST:payinfourl parameters:parametersDemo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"获取支付信息返回%@",responseObject);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"获取支付信息返回%@",str);
        if ([str isEqualToString:@"success"]) {
            
            NSDictionary *data=[KJSON objectForKey:@"data"];
            NSString *toggle=[data objectForKey:@"toggle"];
            NSInteger toggleint = [toggle integerValue];
            //判断支付方式
            if (toggleint==0) {
                 [ self startApplePay];
                
            }else{
                [self startDouDouPay];
            }
            
        }
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];

    
}

//开始苹果支付
-(void)startApplePay{
    NSLog(@"开始苹果支付");
    
   
    
    ApplePayViewController *loginView = [[ApplePayViewController alloc]init];
    _vc = [UIApplication sharedApplication].windows[0].rootViewController;
    
    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //controller背景透明
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        loginView.providesPresentationContextTransitionStyle = YES;
        loginView.definesPresentationContext = YES;
        loginView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        NSLog(@"8+");
    } else {
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [_vc presentViewController:loginView animated:NO completion:nil];
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        NSLog(@"8-");
    }
    
    [_vc presentViewController:loginView animated:YES completion:nil];

    
}
//开始平台支付
-(void)startDouDouPay{
    NSLog(@"开始自有平台支付");
    
    DgamePayViewController *loginView = [[DgamePayViewController alloc]init];
    _vc = [UIApplication sharedApplication].windows[0].rootViewController;
    
    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //controller背景透明
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        loginView.providesPresentationContextTransitionStyle = YES;
        loginView.definesPresentationContext = YES;
        loginView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        NSLog(@"8+");
    } else {
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [_vc presentViewController:loginView animated:NO completion:nil];
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        NSLog(@"8-");
    }
    
    [_vc presentViewController:loginView animated:YES completion:nil];
    
}


- (void) acountManager{
    
   
    AcountManagerViewController *loginView = [[AcountManagerViewController alloc]init];
    _vc = [UIApplication sharedApplication].windows[0].rootViewController;
    
    loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    //controller背景透明
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        loginView.providesPresentationContextTransitionStyle = YES;
        loginView.definesPresentationContext = YES;
        loginView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        NSLog(@"8+");
    } else {
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
        [_vc presentViewController:loginView animated:NO completion:nil];
        _vc.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
        NSLog(@"8-");
    }
    
    [_vc presentViewController:loginView animated:YES completion:nil];
    
    
}

- (void) DgameOnlineHelpersetRoleData:(NSString *) roleData{
    NSDictionary *dic =[DgameUtils dictionaryWithJsonString:roleData];
    NSString *roleId = [dic objectForKey:@"roleId"];
    NSString *roleName = [dic objectForKey:@"roleName"];
    NSString *roleLevel = [dic objectForKey:@"roleLevel"];
    NSString *zoneId = [dic objectForKey:@"zoneId"];
    NSString *zoneName = [dic objectForKey:@"zoneName"];
    
    _mRole=[DgameRole new];
    _mRole.roleid=roleId;
    _mRole.rolename=roleName;
    _mRole.roleLevel=roleLevel;
    _mRole.zoneid=zoneId;
    _mRole.zonename=zoneName;
    
    NSLog(@"登录成功传入的role%@",_mRole.roleLevel);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送二进制form数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制form数据
    manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    
    
    //NSDictionary *param = @{@"phoneNumber":account, @"password":@"f379eaf3c831b04de153469d1bec345e"};
    
   // [manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        //success(task,responseObject);
  //      NSDictionary *rootDic =(NSDictionary)responseObject;
        
   // } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        //failure(task,error);
  //  }];
    
}




//显示悬浮窗
- (void)showFloatWindow{
    
    
    _floatWindow = [[LZFloatWindow alloc]initWithFrame:CGRectMake(0, 100, 40, 40) mainImageName:[UIImage imageNamed:@"dgameassets/z.png"]];
    [_floatWindow show];
    _floatWindow.clickViewBlock = ^(LZFloatWindow *view){
        
        NSLog(@"点击我了");
        [[DgameSdk Instance] acountManager];
        
    };
    
}

//登录成功
-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain{
    
    [_vc dismissViewControllerAnimated:YES completion:nil];
    
   
    [DgameUtils showMessage:@"玩家登录成功"];
    
    [_mLogindelegate onLoginSuccess:user andreason:remain];
    
    //显示悬浮窗
    if (isShowcenter) {
        [self showFloatWindow];
    }
    
   
}

//登录失败
-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain{
    [_vc dismissViewControllerAnimated:YES completion:nil];
    
    
    [DgameUtils showMessage:@"登录失败"];
    
   // [_mLogindelegate onLoginSuccess:user andreason:remain];
     [_mLogindelegate onLoginFailed:why andreason:remain];
}

//登出
-(void) onLoginOut:(NSString *) remain{
    [_vc dismissViewControllerAnimated:YES completion:nil];
    [DgameUtils showMessage:@"登出"];
    [_mLogindelegate onLoginOut:remain];

}

//关闭viewcontroller
-(void) dismissViewcontroller{
    [_vc dismissViewControllerAnimated:YES completion:nil];
    
    
}

//支付成功回调
-(void) onPaySuccess : (NSString*) msg{
    
    NSDictionary *kmsg = @{@"msg":msg,@"price":_morder.price,@"cporderid":_morder.cporderid};
    [_mPaydelegate onSuccess:[DgameUtils dictionaryToJson:kmsg]];
    [_vc dismissViewControllerAnimated:YES completion:nil];
}
//支付失败回调
-(void) onPayFailed : (NSString*) msg{
    [_mPaydelegate onFailed:msg];
    [_vc dismissViewControllerAnimated:YES completion:nil];
}


@end
