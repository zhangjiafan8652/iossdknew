//
//  PhoneRegisterViewController.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/29.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "PhoneRegisterViewController.h"
#import "AccountRegisterViewController.h"
@interface PhoneRegisterViewController ()



@end

@implementation PhoneRegisterViewController

static const NSInteger PRETAG =301;
static const NSInteger SENDCODETAG =307;
static const NSInteger PHONENUMBERTAG =302;

static const NSInteger PASSWORDTAG =303;

static const NSInteger REPASSWORDTAG =304;

static const NSInteger OKTAG =305;
static const NSInteger REGISTERACOUNTTAG =306;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //创建中间窗口
    [self createUiview];

    //添加头布局
    [ self createTitleView];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
}


-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_phonenumber resignFirstResponder];
    [_password resignFirstResponder];
    [_code_textfiled resignFirstResponder];
}

-(void)keyboardHide{
    [_phonenumber resignFirstResponder];
    [_password resignFirstResponder];
    [_code_textfiled resignFirstResponder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createUiview{
    
    _muiview= [[UIView alloc] init];
    
    _muiview.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:720])/2,
                              ([UIScreen mainScreen].bounds.size.height-[DgameUtils RealSizeheight:640])/2
                              , [DgameUtils RealSizeWith:720],[DgameUtils RealSizeheight:640]);
    _muiview.backgroundColor=[UIColor whiteColor ];
    [self.view addSubview:_muiview];
    
}

-(void)createTitleView{
    
    UIView *titleuiview=[[UIView alloc]init];
    
    titleuiview.frame=CGRectMake(0,0
                                 , [DgameUtils RealSizeWith:720],[DgameUtils RealSizeheight:100]);
    
    titleuiview.backgroundColor=[DgameUtils colorWithHexString:@"#959595" ];
    
    [_muiview addSubview:titleuiview];
    
    
    _preview= [[UIButton alloc] init];
    
    _preview.frame=CGRectMake(0,0
                                 , [DgameUtils RealSizeWith:100],[DgameUtils RealSizeheight:100]);
    //_titleimage.backgroundColor=[UIColor greenColor];
    UIImage *muiimage=[UIImage imageNamed:@"dgameassets/yaya_pre1080.png"];

    _preview.imageEdgeInsets = UIEdgeInsetsMake([DgameUtils RealSizeWith:30],[DgameUtils RealSizeheight:30]
                                                , [DgameUtils RealSizeWith:30],[DgameUtils RealSizeWith:30]);

    [_preview setImage:muiimage forState:UIControlStateNormal];

    NSLog(@"%f",_preview.imageView.frame.size.height);
    
    _preview.backgroundColor=[DgameUtils colorWithHexString:@"#959595" ];
    
    _preview.tag=PRETAG;
    [_preview addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    
    
    [_muiview addSubview:_preview];
    
    //标题头
    UILabel *uititlelabe= [[UILabel alloc]init];
    uititlelabe.frame=CGRectMake([DgameUtils RealSizeWith:290],0
                                 , [DgameUtils RealSizeWith:160],[DgameUtils RealSizeheight:100]);
    uititlelabe.text=@"手机注册";
    uititlelabe.textColor=[UIColor whiteColor];
    [_muiview addSubview:uititlelabe];
    
    
    //手机号码
    _phonenumber= [[UITextField alloc
                         ] init];
    
    _phonenumber.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:120], [DgameUtils RealSizeWith:400], [DgameUtils RealSizeheight:100]);
    
    //usernametextview.center=musernameuiview.center;
    _phonenumber.placeholder=@"手机号码";
    //_phonenumber.secureTextEntry=YES;
    
    _phonenumber.layer.borderWidth=1;
    _phonenumber.layer.borderColor=[[UIColor colorWithRed:233/255.00 green:233/255.00 blue:233/255.00 alpha:1.00 ] CGColor];
    
    _phonenumber.keyboardType=UIKeyboardTypePhonePad;//键盘样式
    _phonenumber.returnKeyType =UIReturnKeyDone;//return键变成什么键
    
    _phonenumber.textAlignment = NSTextAlignmentLeft;//内容对齐方式
    //_phonenumber.borderStyle = UITextBorderStyleBezel;//边框样式
    //设置左边视图的宽度
    
    _phonenumber.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 0)];
    
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    
    _phonenumber.leftViewMode = UITextFieldViewModeAlways;
    
    // _passwordtextview.backgroundColor=[UIColor grayColor];
    _phonenumber.tag=PHONENUMBERTAG;
    _phonenumber.delegate=self;

    [_muiview addSubview:_phonenumber];
    
    //发送验证码按钮
    _sendcodebutton=[[UIButton alloc] init];
    
    _sendcodebutton.frame=CGRectMake([DgameUtils RealSizeWith:460], [DgameUtils RealSizeheight:120], [DgameUtils RealSizeWith:240], [DgameUtils RealSizeheight:100]);
    _sendcodebutton.backgroundColor=[DgameUtils colorWithHexString:@"#019ee8"];
    [_sendcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_sendcodebutton setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [_sendcodebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendcodebutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _sendcodebutton.tag=SENDCODETAG;
    [_sendcodebutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    
    [_muiview addSubview:_sendcodebutton];
    
    //密码
    _password= [[UITextField alloc
                    ] init];
    
    _password.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:240], [DgameUtils RealSizeWith:680], [DgameUtils RealSizeheight:100]);
    
    //usernametextview.center=musernameuiview.center;
    _password.placeholder=@"密码";
    _password.secureTextEntry=YES;
    
    _password.layer.borderWidth=1;
    _password.layer.borderColor=[[UIColor colorWithRed:233/255.00 green:233/255.00 blue:233/255.00 alpha:1.00 ] CGColor];
    
    _password.keyboardType=UIKeyboardTypeDefault;//键盘样式
    _password.returnKeyType =UIReturnKeyDone;//return键变成什么键
    
    _password.textAlignment = NSTextAlignmentLeft;//内容对齐方式
    
    //设置左边视图的宽度
    
    _password.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 0)];
    
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    
    _password.leftViewMode = UITextFieldViewModeAlways;

    // _passwordtextview.backgroundColor=[UIColor grayColor];
    _password.tag=PASSWORDTAG;
    _password.delegate=self;
    
    [_muiview addSubview:_password];
    
    //重复密码
    _code_textfiled= [[UITextField alloc
                 ] init];
    
    _code_textfiled.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:360], [DgameUtils RealSizeWith:680], [DgameUtils RealSizeheight:100]);
    
    //usernametextview.center=musernameuiview.center;
    _code_textfiled.placeholder=@"验证码";
    _code_textfiled.secureTextEntry=YES;
    
    _code_textfiled.layer.borderWidth=1;
    _code_textfiled.layer.borderColor=[[UIColor colorWithRed:233/255.00 green:233/255.00 blue:233/255.00 alpha:1.00 ] CGColor];
    
    _code_textfiled.keyboardType=UIKeyboardTypeDefault;//键盘样式
    _code_textfiled.returnKeyType =UIReturnKeyDone;//return键变成什么键
    
    _code_textfiled.textAlignment = NSTextAlignmentLeft;//内容对齐方式
    
    //设置左边视图的宽度
    
    _code_textfiled.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 0)];
    
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    
    _code_textfiled.leftViewMode = UITextFieldViewModeAlways;
    // _passwordtextview.backgroundColor=[UIColor grayColor];
    _code_textfiled.tag=REPASSWORDTAG;
    _code_textfiled.delegate=self;
    
    [_muiview addSubview:_code_textfiled];
    
    //登录按钮
    _okbutton=[[UIButton alloc] init];
    
    _okbutton.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:480], [DgameUtils RealSizeWith:680], [DgameUtils RealSizeheight:100]);
    _okbutton.backgroundColor=[DgameUtils colorWithHexString:@"#e78b02"];
    [_okbutton setTitle:@"确认" forState:UIControlStateNormal];
    [_okbutton setTitle:@"确认" forState:UIControlStateHighlighted];
    [_okbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_okbutton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    _okbutton.tag=OKTAG;
    
    [_okbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    
    [_muiview addSubview:_okbutton];
    
    
    //账号注册按钮
    _acountregister=[[UIButton alloc] init];
    
    _acountregister.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:600], [DgameUtils RealSizeWith:600], [DgameUtils RealSizeheight:20]);
    _acountregister.backgroundColor=[UIColor clearColor];
    [_acountregister setTitle:@"未收到验证码，点击此处账号注册" forState:UIControlStateNormal];
    [_acountregister setTitle:@"未收到验证码，点击此处账号注册" forState:UIControlStateHighlighted];
    [_acountregister setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_acountregister setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    _acountregister.titleLabel.font    = [UIFont systemFontOfSize: 14];
    //文字靠左
    _acountregister.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _acountregister.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    _acountregister.tag=REGISTERACOUNTTAG;
    [_acountregister addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    
    [_muiview addSubview:_acountregister];
    
    
}


- (void)buttonClick:(UIButton *)button{
    if (button.tag==PRETAG) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if(button.tag==SENDCODETAG){
       
        if (_mtimertime<2) {
            
            NSString *tphonenumber=_phonenumber.text;
            if([DgameUtils checkisPhone:tphonenumber]){
                [self startTimer];
                NSString *s = [NSString stringWithFormat:@"%d",2];
                [self sendCode:_phonenumber.text withType:s];
            }else{
                [DgameUtils showMessage:@"请输入正确手机号"];
            }
            
        }else{
            [DgameUtils showMessage:@"请耐心等待"];
        }
    }else if(button.tag==OKTAG){
        
         NSLog(@"确认");
        NSString *nphonenumber=_phonenumber.text;
        NSString *npassword=_password.text;
        NSString *code=_code_textfiled.text;
        
        NSLog(@"%@",nphonenumber);
        NSLog(@"%@",npassword);
        if ([nphonenumber isEqualToString:@""]) {
            [DgameUtils alertDialog:self withMessage:@"账号为空！！"];
            return;
        }
        if ([npassword isEqualToString:@""]) {
            [DgameUtils alertDialog:self withMessage:@"密码为空！！"];
            return;
        }
        if ([code isEqualToString:@""]) {
            [DgameUtils alertDialog:self withMessage:@"密码为空！！"];
            return;
        }
        
        
    }else if(button.tag==REGISTERACOUNTTAG){
        
        NSLog(@"注册");
        
        AccountRegisterViewController *loginView = [[AccountRegisterViewController alloc]init];
        
        loginView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        //controller背景透明
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
            loginView.providesPresentationContextTransitionStyle = YES;
            loginView.definesPresentationContext = YES;
            loginView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
            NSLog(@"8+");
        } else {
            self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
            [self presentViewController:loginView animated:NO completion:nil];
            self.view.window.rootViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            NSLog(@"8-");
        }
        
        [self presentViewController:loginView animated:YES completion:nil];
        
    }
}


//注册发送验证码
- (void)sendCode:(NSString *)mphonenumber withType:(NSString *) type{
    
    
    
    //NSString *app_id = [DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    // NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送二进制form数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    NSDictionary *param = @{@"mobile":mphonenumber, @"type":type};
    
    [manager POST:sendcodeurl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        //success(task,responseObject);
        NSDictionary *responsedic =(NSDictionary *)responseObject;
        // NSString *err_msg = [responsedic objectForKey:@"err_msg"];
        NSLog(@"注册成功返回%@",responsedic);
        // if ([err_msg isEqualToString:@"success"])
        //{
        
        // }
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"c、初始化%@",str);
        if ([str isEqualToString:@"success"]) {
            NSLog(@"发送成功");
            
            [DgameUtils showMessage:@"发送验证成功！请耐心等待"];
             
             }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        //failure(task,error);
        [DgameUtils showMessage:@"注册失败,请检查网络环境"];
    }];
}



-(void)startTimer{
    _mtimertime=59;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerSelector) userInfo:nil repeats:YES];
    
    
    
    // 停止定时器
    
   // [timer invalidate];
}
-(void)timerSelector{
    
    if (_mtimertime<2) {
        // 停止定时器
        //_mtimertime=_mtimertime-1;
        [_timer invalidate];
         [_sendcodebutton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        _mtimertime=_mtimertime-1;
        NSString *s = [NSString stringWithFormat:@"%d",_mtimertime];
        NSLog(@"%@",s);
        [_sendcodebutton setTitle:s forState:UIControlStateNormal];
    }
    
    
    
}
- (void)registerAccount:(NSString *)mphonen withPassword:(NSString *) password withCode:(NSString *) code{
    
    
    
    NSString *app_id = [DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    // NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送二进制form数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    NSDictionary *param = @{@"app_id":app_id, @"idfa":[DgameUtils getIDFA], @"mobile":mphonen, @"password":password, @"code":code};
    
    [manager POST:registerurl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        //success(task,responseObject);
        NSDictionary *responsedic =(NSDictionary *)responseObject;
        // NSString *err_msg = [responsedic objectForKey:@"err_msg"];
        NSLog(@"注册成功返回%@",responsedic);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"c、初始化%@",str);
        if ([str isEqualToString:@"success"]) {
            NSLog(@"注册成功");
            NSDictionary *userinfojson = [KJSON objectForKey:@"data"];
            DgameUser *muser= [DgameUser new];
            muser.userid=[userinfojson objectForKey:@"uid"];
            muser.username=[userinfojson objectForKey:@"username"];
            muser.token=[userinfojson objectForKey:@"token"];
            
            [DgameUtils setDgameUserNSUserDefaultskey:muser];
            [[DgameSdk Instance] onLoginSuccess:muser andreason:@"登录成功"];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        //failure(task,error);
        [DgameUtils showMessage:@"注册失败,请检查网络环境"];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"点击done了");
    [textField resignFirstResponder];
    return YES;
}

@end
