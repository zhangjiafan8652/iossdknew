//
//  PayWebViewViewController.m
//  ddgamedemo
//
//  Created by Apple on 2017/12/28.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "PayWebViewViewController.h"

@interface PayWebViewViewController ()

@end

@implementation PayWebViewViewController

static const NSInteger PRETAG =501;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    
    
    
    //创建中间窗口
    [self createUiview];
    
    //创建标题头
    [self createTitleView];

    
    //创建中间窗口
    [self createWebview];
    
   // [self showLoading];
    
    //logic
    
    [self loadUrl:[DgameSdk Instance].morder.payurl];
    
    
   
}

- (void)hideLoading {
    // 隐藏动画
   // [self.view hideLoading];
}

- (void)showLoading{
    
    // 显示动画
 //   [self.view showLoading];
    
    
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
//创建标题窗口
-(void) createTitleView{
    

    UIView *titleuiview=[[UIView alloc]init];
    
    titleuiview.frame=CGRectMake(0,0
                                 , [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:100]);
    
    titleuiview.backgroundColor=[DgameUtils colorWithHexString:@"#0081EF" ];
    
    [_muiview addSubview:titleuiview];
    
    
    _preview= [[UIButton alloc] init];
    
    _preview.frame=CGRectMake(0,0
                              , [DgameUtils RealSizeWith:100],[DgameUtils RealSizeheight:100]);
    //_titleimage.backgroundColor=[UIColor greenColor];
    UIImage *muiimage=[UIImage imageNamed:@"dgameassets/yaya_pre1080.png"];
    
    _preview.imageEdgeInsets = UIEdgeInsetsMake([DgameUtils RealSizeWith:30],[DgameUtils RealSizeheight:30]
                                                , [DgameUtils RealSizeWith:30],[DgameUtils RealSizeWith:30]);
    
    [_preview setImage:muiimage forState:UIControlStateNormal];
    
    //NSLog(@"%f",_preview.imageView.frame.size.height);
    
    _preview.backgroundColor=[DgameUtils colorWithHexString:@"#0081EF" ];
    
    _preview.tag=PRETAG;
    [_preview addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    
    
    [_muiview addSubview:_preview];
    
    //标题头
    UILabel *uititlelabe= [[UILabel alloc]init];
    uititlelabe.frame=CGRectMake([DgameUtils RealSizeWith:220],0
                                 , [DgameUtils RealSizeWith:200],[DgameUtils RealSizeheight:100]);
    uititlelabe.text=@"正在支付";
    uititlelabe.textColor=[UIColor whiteColor];
    uititlelabe.textAlignment = NSTextAlignmentCenter;
    [_muiview addSubview:uititlelabe];
}

//创建webview
-(void)createWebview{
    
    _mwebview= [[UIWebView alloc] init];
    
    _mwebview.frame=CGRectMake(0,[DgameUtils RealSizeheight:100], [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:540]);
    _mwebview.backgroundColor=[UIColor whiteColor ];
    [_muiview addSubview:_mwebview];
    _mwebview.delegate = self;
    
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag==PRETAG) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}


-(void)loadUrl:(NSString *)loadurl{
    //1. 创建url
    NSURL *url;
    
        url=[NSURL URLWithString:loadurl];
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
    //[self hideLoading];
}

// 加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString* reqUrl = request.URL.absoluteString;
    NSLog(@"当前加载的url：%@",reqUrl);
    //YWxpcGF5Oi8v
    NSString *zhifubaostart1=[NSString stringFromBase64String:@"YWxpcGF5czovLw=="];//生成支付解密字符串
     NSString *zhifubaostart2=[NSString stringFromBase64String:@"YWxpcGF5Oi8v"];//生成支付解密字符串
    //
    NSString *zhifubaosuccess=[NSString stringFromBase64String:@"Ly9wYXlzdWNjZXNz"];//生成支付解密字符串
     NSString *weixinstart=[NSString stringFromBase64String:@"d2VpeGluOi8v"];//生产支付微信解密字符串
    //weixin://
    if ([reqUrl hasPrefix:zhifubaostart1] || [reqUrl hasPrefix:zhifubaostart2]) {
        BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
        //bSucc是否成功调起支付宝
    }else if([reqUrl containsString:zhifubaosuccess]){
        [[DgameSdk Instance] onPaySuccess:@"支付成功"];
    
    }else if([reqUrl containsString:weixinstart]){
       BOOL bSucc = [[UIApplication sharedApplication]openURL:request.URL];
        
    }
    return YES;
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
