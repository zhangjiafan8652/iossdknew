//
//  AcountManagerViewController.m
//  demo
//
//  Created by Apple on 2017/12/25.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "AcountManagerViewController.h"

@interface AcountManagerViewController ()

@end

@implementation AcountManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    
    
    
    //创建中间窗口
    [self createUiview];
    
    //创建中间窗口
    [self createWebview];
    
   [self showLoading];
    
    //logic
    
    [self loadUrl];
    

    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
   }

- (void)hideLoading {
    // 隐藏动画
    [_mwebview hideLoading];
}

- (void)showLoading{
    
    // 显示动画
    [_mwebview showLoading];
    
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    
        CGPoint point = [tap locationInView:self.view];
        NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
        
        // (([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:640])/2,
        // ([UIScreen mainScreen].bounds.size.height-[DgameUtils RealSizeheight:640])/2
        //, [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:640])
        float left=([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:640])/2;
        float top=([UIScreen mainScreen].bounds.size.height-[DgameUtils RealSizeheight:640])/2;
        float right=([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:640])/2+[DgameUtils RealSizeWith:640];
        float buttom=([UIScreen mainScreen].bounds.size.height-[DgameUtils RealSizeheight:640])/2+[DgameUtils RealSizeheight:640];
        float locationx=point.x;
        float locationy=point.y;
        
        if (locationx<left||locationx>right||locationy<top||locationy>buttom) {
            [[DgameSdk Instance] dismissViewcontroller];
        }
      //[_code_textfiled resignFirstResponder];
}

//创建中间窗口
-(void)createUiview{
    
    _muiview= [[UIView alloc] init];
    
    _muiview.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:640])/2,
                              ([UIScreen mainScreen].bounds.size.height-[DgameUtils RealSizeheight:640])/2
                              , [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:640]);
    _muiview.backgroundColor=[UIColor whiteColor ];
    [self.view addSubview:_muiview];
    
}

//创建webview
-(void)createWebview{
    
    _mwebview= [[UIWebView alloc] init];
    
    _mwebview.frame=CGRectMake(0,0, [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:640]);
    _mwebview.backgroundColor=[UIColor whiteColor ];
    [_muiview addSubview:_mwebview];
    _mwebview.delegate = self;
    
}

-(void)loadUrl{
    //1. 创建url
    NSURL *url;
    
    NSString *acountmanagerurl=@"https://api.jf-q.com/web/profile";
    NSString *allurl=[NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                      acountmanagerurl,
                      @"?uid=",
                      [DgameUtils getNSUserDefaultsBykey:@"uid"],
                      @"&token=",
                      [DgameUtils getNSUserDefaultsBykey:@"token"],
                      @"&appid=",
                      [DgameUtils getNSUserDefaultsBykey:@"app_id"]];
    NSLog(@"加载的url%@",allurl);
    url=[NSURL URLWithString:allurl];
    //2. 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //3. **加载请求页面**
    [_mwebview loadRequest:request];
   
}


// 开始加载
-(void)webViewDidStartLoad:(UIWebView *)webView{
    //显示网络请求加载图标
    //[UIApplication sharedApplication].networkActivityIndicatorVisible=true;
}
//加载完毕
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"加载完毕");
    [self hideLoading];
}

// 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
