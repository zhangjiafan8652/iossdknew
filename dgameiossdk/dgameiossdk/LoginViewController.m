//
//  LoginViewController.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/24.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end





@implementation LoginViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0];
    
    
    //创建中间窗口
    [self createUiview];
    
    
    //创建头部图片
    [self createImview];
    
    
    //中间布局
    [self createUsernameAndPasswordView];
    
    
    
 
    //NSLog(@"%f",([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:550])/2);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    //  给 _keyBoardlsVisible 赋初值
    _keyBoardlsVisible = NO;
    [center addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardWillHideNotification object:nil];


    //给用户名和密码赋值
    
    NSString *nsuserdefusername=[DgameUtils getNSUserDefaultsBykey:@"username"];
    NSString *nspassworddefusername=[DgameUtils getNSUserDefaultsBykey:@"password"];
    NSLog(@"username===========%@",nsuserdefusername);

    if (nsuserdefusername!=nil) {
        [_usernametextview setText:nsuserdefusername];
    }else{
        [self startAcountRegister];
    }
    if (nspassworddefusername!=nil) {
        [_passwordtextview setText:nspassworddefusername];
    }
}


//  键盘弹出触发该方法
- (void)keyboardDidShow
{
    NSLog(@"键盘弹出");
    _keyBoardlsVisible =YES;
}
//  键盘隐藏触发该方法
- (void)keyboardDidHide
{
    NSLog(@"键盘隐藏");
    _keyBoardlsVisible =NO;
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    
    
    
    
    //手势点击识别，如果键盘未弹出，玩家取消登录
    if(_keyBoardlsVisible==YES){
        [_usernametextview resignFirstResponder];
        [_passwordtextview resignFirstResponder];
    }else{
        
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
            [[DgameSdk Instance] onLoginFailed:@"玩家取消登录" andreason:@""];
        }
       
        
    }
    
    
    //[_code_textfiled resignFirstResponder];
}

-(void)keyboardHide{
    [_usernametextview resignFirstResponder];
    [_passwordtextview resignFirstResponder];
}

-(void)createUiview{
    
    _muiview= [[UIView alloc] init];
    
    _muiview.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:640])/2,
                              ([UIScreen mainScreen].bounds.size.height-[DgameUtils RealSizeheight:640])/2
                                , [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:640]);
    _muiview.backgroundColor=[UIColor whiteColor ];
    [self.view addSubview:_muiview];

}
-(void)createImview{
    
    _titleimage= [[UIImageView alloc] init];
    
    _titleimage.frame=CGRectMake(0,0
                              , [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:140]);
    //_titleimage.backgroundColor=[UIColor greenColor];
    UIImage *muiimage=[UIImage imageNamed:@"dgameassets/yaya_logo_ho1080.png"];
        _titleimage.image=muiimage;
    _titleimage.contentMode=UIViewContentModeScaleAspectFit;
   _titleimage.backgroundColor=[UIColor colorWithRed:228/255.00 green:228/255.00 blue:228/255.00 alpha:1.00 ];
    [_muiview addSubview:_titleimage];
    
}

-(void)createUsernameAndPasswordView{
    
    
    UIView *musernameuiview=[[UIView alloc] init];
    
    musernameuiview.frame=CGRectMake([DgameUtils RealSizeWith:20],[DgameUtils RealSizeheight:160]
                                 , [DgameUtils RealSizeWith:600],[DgameUtils RealSizeheight:90]);
    musernameuiview.layer.borderWidth=1;
    musernameuiview.layer.borderColor=[[UIColor colorWithRed:233/255.00 green:233/255.00 blue:233/255.00 alpha:1.00 ] CGColor];
   
    UIImageView *usernameimage= [[UIImageView alloc] init];
    
    usernameimage.frame=CGRectMake(0,[DgameUtils RealSizeheight:20] , [DgameUtils RealSizeWith:100],[DgameUtils RealSizeheight:50]);
 
    UIImage *muiimage=[UIImage imageNamed:@"dgameassets/yaya_username1080.png"];
    usernameimage.image=muiimage;
    usernameimage.contentMode=UIViewContentModeScaleAspectFit;

    [musernameuiview addSubview:usernameimage];
    
     _usernametextview= [[UITextField alloc
                                    ] init];
    
    _usernametextview.frame=CGRectMake([DgameUtils RealSizeWith:100], [DgameUtils RealSizeheight:10], [DgameUtils RealSizeWith:480], [DgameUtils RealSizeheight:70]);
    
    //usernametextview.center=musernameuiview.center;
    _usernametextview.placeholder=@"用户名";
    
    _usernametextview.textAlignment = NSTextAlignmentLeft;
   // _usernametextview.backgroundColor=[UIColor grayColor];
    _usernametextview.keyboardType=UIKeyboardTypeDefault;//键盘样式
    _usernametextview.tag=102;
    _usernametextview.delegate=self;
    
    [musernameuiview addSubview:_usernametextview];
 
    
    //添加username行
    [_muiview addSubview:musernameuiview];
    
    
    UIView *mupassworduiview=[[UIView alloc] init];
    
    mupassworduiview.frame=CGRectMake([DgameUtils RealSizeWith:20],[DgameUtils RealSizeheight:270]
                                     , [DgameUtils RealSizeWith:600],[DgameUtils RealSizeheight:90]);
    mupassworduiview.layer.borderWidth=1;
    mupassworduiview.layer.borderColor=[[UIColor colorWithRed:233/255.00 green:233/255.00 blue:233/255.00 alpha:1.00 ] CGColor];
    
    UIImageView *passwordimage= [[UIImageView alloc] init];
    
    passwordimage.frame=CGRectMake(0,[DgameUtils RealSizeheight:20] , [DgameUtils RealSizeWith:100],[DgameUtils RealSizeheight:50]);
    
    UIImage *mpasswordimage=[UIImage imageNamed:@"dgameassets/yaya_username1080.png"];
    passwordimage.image=mpasswordimage;
    passwordimage.contentMode=UIViewContentModeScaleAspectFit;
    
    [mupassworduiview addSubview:passwordimage];
    
     _passwordtextview= [[UITextField alloc
                                    ] init];
    
    _passwordtextview.frame=CGRectMake([DgameUtils RealSizeWith:100], [DgameUtils RealSizeheight:10], [DgameUtils RealSizeWith:480], [DgameUtils RealSizeheight:70]);
    
    //usernametextview.center=musernameuiview.center;
    _passwordtextview.placeholder=@"密码";
    _passwordtextview.secureTextEntry=YES;
    
    _passwordtextview.keyboardType=UIKeyboardTypeDefault;//键盘样式
    _passwordtextview.returnKeyType =UIReturnKeyDone;//return键变成什么键
    
    _passwordtextview.textAlignment = NSTextAlignmentLeft;//内容对齐方式
   // _passwordtextview.backgroundColor=[UIColor grayColor];
    _passwordtextview.tag=101;
    _passwordtextview.delegate=self;
    
    [mupassworduiview addSubview:_passwordtextview];
    
    
    //添加username行
    [_muiview addSubview:mupassworduiview];
    
    
    //注册按钮
    _registerbutton=[[UIButton alloc] init];
    
    _registerbutton.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:400], [DgameUtils RealSizeWith:280], [DgameUtils RealSizeheight:90]);
    _registerbutton.backgroundColor=[DgameUtils colorWithHexString:@"#019ee8"];
    [_registerbutton setTitle:@"快速注册" forState:UIControlStateNormal];
    [_registerbutton setTitle:@"快速注册" forState:UIControlStateHighlighted];
    [_registerbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     _registerbutton.tag=202;
    [_registerbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听

    [_muiview addSubview:_registerbutton];
    
    
    //登录按钮
    _loginbutton=[[UIButton alloc] init];
    
    _loginbutton.frame=CGRectMake([DgameUtils RealSizeWith:340], [DgameUtils RealSizeheight:400], [DgameUtils RealSizeWith:280], [DgameUtils RealSizeheight:90]);
    _loginbutton.backgroundColor=[DgameUtils colorWithHexString:@"#e78b02"];
    [_loginbutton setTitle:@"立即登录" forState:UIControlStateNormal];
    [_loginbutton setTitle:@"立即登录" forState:UIControlStateHighlighted];
    [_loginbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _loginbutton.tag=201;
    
    [_loginbutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    
    
    [_muiview addSubview:_loginbutton];

    
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag==201) {
        //登录
        
        NSLog(@"登录");
        NSString* username= _usernametextview.text;
        NSString* password=_passwordtextview.text;
        if ([username isEqualToString:@""]) {
            [DgameUtils alertDialog:self withMessage:@"账号为空！！"];
            return;
        }
        if ([password isEqualToString:@""]) {
            [DgameUtils alertDialog:self withMessage:@"密码为空！！"];
            return;
        }
        [self loginUsername:username withPassword:password];
        
    }else if(button.tag==202){
        //注册
        NSLog(@"注册");
        
        [self startAcountRegister];
        
        
    }
}

-(void)startAcountRegister{
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
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    NSLog(@"点击done了");
    [textField resignFirstResponder];
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//登录
- (void)loginUsername:(NSString *)username withPassword:(NSString *) password {
    
    
    
    NSString *app_id = [DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    // NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送二进制form数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    NSDictionary *param = @{@"app_id":app_id, @"username":username, @"password":password};
    
    [manager POST:loginurl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        //todo 统一处理响应数据
        //success(task,responseObject);
        NSDictionary *responsedic =(NSDictionary *)responseObject;
        // NSString *err_msg = [responsedic objectForKey:@"err_msg"];
        NSLog(@"登录成功返回%@",responsedic);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"登录成功状态%@",str);
        if ([str isEqualToString:@"success"]) {
            NSLog(@"登录成功");
            NSDictionary *userinfojson = [KJSON objectForKey:@"data"];
            DgameUser *muser= [DgameUser new];
            muser.userid=[userinfojson objectForKey:@"uid"];
            muser.username=[userinfojson objectForKey:@"username"];
            muser.token=[userinfojson objectForKey:@"token"];
            muser.password=password;
            [DgameUtils setDgameUserNSUserDefaultskey:muser];
            muser.password=nil;
            [[DgameSdk Instance] onLoginSuccess:muser andreason:@"登录成功"];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //todo 统一处理错误
        //failure(task,error);
        [DgameUtils showMessage:@"注册失败,请检查网络环境"];
    }];
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
