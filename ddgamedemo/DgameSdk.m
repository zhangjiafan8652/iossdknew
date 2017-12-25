//
//  DgameSdk.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "DgameSdk.h"
#import "StringConstants.h"




@implementation DgameSdk

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
    _mLogindelegate=delegate;
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *APPID=[NSBundle mainBundle].infoDictionary[@"ddappid"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:APPID forKey:@"app_id"];
    
    
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
            [self showFloatWindow];
            
        }
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];
  
    
    
    
}

-(void)ceshi{

    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *APPID=[NSBundle mainBundle].infoDictionary[@"ddappid"];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:APPID forKey:@"app_id"];
    
    
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
            [self showFloatWindow];
            
        }
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];
    
}
- (void) login:(NSString *) remain{
    
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
    
    
    _floatWindow = [[LZFloatWindow alloc]initWithFrame:CGRectMake(0, 0, 40, 40) mainImageName:[UIImage imageNamed:@"dgameassets/z.png"]];
    [_floatWindow show];
    _floatWindow.clickViewBlock = ^(LZFloatWindow *view){
        
        NSLog(@"点击我了");
        [[DgameSdk Instance] acountManager];
        
    };
    
}

-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain{
    
    [_vc dismissViewControllerAnimated:YES completion:nil];
    
    
    [DgameUtils showMessage:@"玩家登录成功"];
    
    [_mLogindelegate onLoginSuccess:user andreason:remain];
    
   
}


-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain{
    [_vc dismissViewControllerAnimated:YES completion:nil];
    
    
    [DgameUtils showMessage:@"登录失败"];
    
   // [_mLogindelegate onLoginSuccess:user andreason:remain];
     [_mLogindelegate onLoginFailed:why andreason:remain];
}

-(void) onLoginOut:(NSString *) remain{
    [_vc dismissViewControllerAnimated:YES completion:nil];
    [DgameUtils showMessage:@"登出"];
    [_mLogindelegate onLoginOut:remain];

}

//关闭viewcontroller
-(void) dismissViewcontroller{
    [_vc dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
