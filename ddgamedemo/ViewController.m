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
   
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) onResponse:(NSString *) tag andResponsewhy:(NSString *) value{
    
}

-(void) onLoginSuccess:(DgameUser *) user andreason:(NSString *) remain{
    NSString *str=@"登录成功";
    NSLog(@"我在viewcontroller中登录成功%@",[str stringByAppendingString:user.userid]);
    NSDictionary *parametersDemo = @{@"roleId":@"123",@"roleName":@"jiafan",@"roleLevel":@"12",@"zoneId":@"1",@"zoneName":@"jiafan"};
    NSString *string=[DgameUtils dictionaryToJson:parametersDemo];
    
    [[DgameSdk Instance] DgameOnlineHelpersetRoleData:string];
}


-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain{
    
}

-(void) onLoginOut:(NSString *) remain{
    
    
}

- (IBAction)loginViewClick:(id)sender {
    NSLog(@"点击登录了");
    [[DgameSdk Instance] login:@"测试"];
    
}
- (IBAction)PayViewClick:(id)sender {
    NSLog(@"点击支付了");
   // [[DgameSdk Instance] login:@"测试"];
    [[DgameSdk Instance] pay:100 andName:@"冰霜之剑" andExtinfo:@"透传参数" andOrderid:@"321123321"withPayListener:self];

}



-(void) onSuccess : (NSString*) msg{
    NSLog(@"支付成功");
}//支付成功回调

-(void) onFailed : (NSString*) msg{
     NSLog(@"支付失败");
}//支付失败回调

-(void) onOderNo:(NSString*) msg{
    NSLog(@"onoderno");
    
}//订单号


@end
