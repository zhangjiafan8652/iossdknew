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
}

-(void) onLoginFailed:(NSString *) why andreason:(NSString *) remain{
}

-(void) onLoginOut:(NSString *) remain{
    
}

- (IBAction)loginViewClick:(id)sender {
    NSLog(@"点击登录了");
    [[DgameSdk Instance] login:@"测试"];
    
}
@end