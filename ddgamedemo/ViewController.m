//
//  ViewController.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[DgameSdk Instance] DgameOnlineHelperinitSDKWithListener:self];
    NSLog(@"VIEWDIDLOAD初始化后");
    self.view.backgroundColor=[UIColor blackColor];
   
   // [self startLoading:self.view andMessage:@"正在加载..."];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)loginViewClick:(id)sender {
    NSLog(@"点击登录了");
    [[DgameSdk Instance] login:@"传奇世界" withLoginListener:self];
    //[[DgameSdk Instance] login:@"测试"];
    
}
- (IBAction)PayViewClick:(id)sender {
    NSLog(@"点击支付了");
   // [[DgameSdk Instance] login:@"测试"];
    [[DgameSdk Instance] pay:@"3000" andName:@"冰霜之剑" andExtinfo:@"透传参数" andOrderid:@"321123321"withPayListener:self];
//[self stopLoading:self.view ];
}



-(void) onResponse:(NSString *) tag andResponsewhy:(NSString *) value{
     NSLog(@"初始化回掉代理。占时无作用，只是作为sdk的通知%@",tag);
}

-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain{
    NSString *str=@"登录成功";
    NSLog(@"我在viewcontroller中登录成功%@",[str stringByAppendingString:user.userid]);
    NSDictionary *parametersDemo = @{@"roleId":@"123",@"roleName":@"jiafan",@"roleLevel":@"12",@"zoneId":@"1",@"zoneName":@"jiafan"};
    NSString *string=[DgameUtils dictionaryToJson:parametersDemo];
    
    [[DgameSdk Instance] DgameOnlineHelpersetRoleData:string];
}


-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain{
    NSLog(@"登录失败%@",why);

}

-(void) onLoginOut:(NSString *) remain{
    //sdk里的切换账号。游戏收到此代理，应该退出游戏到登录页面
    NSLog(@"登出%@",remain);
    
}


-(void) onSuccess : (NSString*) msg{
    NSLog(@"支付成功%@",msg);
    [DgameUtils showMessage:msg];
}//支付成功回调

-(void) onFailed : (NSString*) msg{
     NSLog(@"支付失败");
    [DgameUtils showMessage:@"游戏支付失败"];
}//支付失败回调




@end
