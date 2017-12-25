//
//  AccountRegisterViewController.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/12/17.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "AccountRegisterViewController.h"

@interface AccountRegisterViewController ()

@end

@implementation AccountRegisterViewController

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
    //手势关闭键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    
    
}
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_accountnumber resignFirstResponder];
    [_password resignFirstResponder];
    [_repassword resignFirstResponder];
}

-(void)keyboardHide{
    [_accountnumber resignFirstResponder];
    [_password resignFirstResponder];
    [_repassword resignFirstResponder];
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
    uititlelabe.text=@"账号注册";
    uititlelabe.textColor=[UIColor whiteColor];
    [_muiview addSubview:uititlelabe];
    
    
    //账号
    _accountnumber= [[UITextField alloc
                    ] init];
    
    _accountnumber.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:120], [DgameUtils RealSizeWith:680], [DgameUtils RealSizeheight:100]);
    
    //usernametextview.center=musernameuiview.center;
    _accountnumber.placeholder=@"账号";
    //_phonenumber.secureTextEntry=YES;
    
    _accountnumber.layer.borderWidth=1;
    _accountnumber.layer.borderColor=[[UIColor colorWithRed:233/255.00 green:233/255.00 blue:233/255.00 alpha:1.00 ] CGColor];
    
    _accountnumber.keyboardType=UIKeyboardTypeDefault;//键盘样式
    _accountnumber.returnKeyType =UIReturnKeyDone;//return键变成什么键
    
    _accountnumber.textAlignment = NSTextAlignmentLeft;//内容对齐方式
    //_phonenumber.borderStyle = UITextBorderStyleBezel;//边框样式
    //设置左边视图的宽度
    
    _accountnumber.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 0)];
    
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    
    _accountnumber.leftViewMode = UITextFieldViewModeAlways;
    
    // _passwordtextview.backgroundColor=[UIColor grayColor];
    _accountnumber.tag=PHONENUMBERTAG;
    _accountnumber.delegate=self;
    
    [_muiview addSubview:_accountnumber];
    
  
    
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
    _repassword= [[UITextField alloc
                   ] init];
    
    _repassword.frame=CGRectMake([DgameUtils RealSizeWith:20], [DgameUtils RealSizeheight:360], [DgameUtils RealSizeWith:680], [DgameUtils RealSizeheight:100]);
    
    //usernametextview.center=musernameuiview.center;
    _repassword.placeholder=@"重复密码";
    _repassword.secureTextEntry=YES;
    
    _repassword.layer.borderWidth=1;
    _repassword.layer.borderColor=[[UIColor colorWithRed:233/255.00 green:233/255.00 blue:233/255.00 alpha:1.00 ] CGColor];
    
    _repassword.keyboardType=UIKeyboardTypeDefault;//键盘样式
    _repassword.returnKeyType =UIReturnKeyDone;//return键变成什么键
    
    _repassword.textAlignment = NSTextAlignmentLeft;//内容对齐方式
    
    //设置左边视图的宽度
    
    _repassword.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 0)];
    
    //设置显示模式为永远显示(默认不显示 必须设置 否则没有效果)
    
    _repassword.leftViewMode = UITextFieldViewModeAlways;
    // _passwordtextview.backgroundColor=[UIColor grayColor];
    _repassword.tag=REPASSWORDTAG;
    _repassword.delegate=self;
    
    [_muiview addSubview:_repassword];
    
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
    
    
}


- (void)buttonClick:(UIButton *)button{
    if (button.tag==PRETAG) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if(button.tag==SENDCODETAG){
        
        
        
    }else if(button.tag==OKTAG){
        
        //关闭键盘
        [self keyboardHide];
        
        NSString *acountnumber=_accountnumber.text;
        NSString *npassword=_password.text;
        NSString *rpassword=_repassword.text;

        NSLog(@"%@",acountnumber);
        NSLog(@"%@",npassword);
        if ([acountnumber isEqualToString:@""]) {
           [DgameUtils alertDialog:self withMessage:@"账号为空！！"];
            return;
        }
        if ([npassword isEqualToString:@""]) {
            [DgameUtils alertDialog:self withMessage:@"密码为空！！"];
            return;
        }
        if ([rpassword isEqualToString:@""]) {
            [DgameUtils alertDialog:self withMessage:@"密码为空！！"];
            return;
        }
            
        if ([npassword isEqualToString:rpassword]) {
            
            [self registerAccount:acountnumber withPassword:npassword];
        }else{
            
            [DgameUtils alertDialog:self withMessage:@"两次密码输入不一致！！"];
        }
        
        
    }else if(button.tag==REGISTERACOUNTTAG){
        
        
        
    }
}

- (void)registerAccount:(NSString *)acountnumber withPassword:(NSString *) password{
    
    
    
    NSString *app_id = [DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
   // NSString *IDFA=[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 发送二进制form数据
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    NSDictionary *param = @{@"app_id":app_id, @"idfa":[DgameUtils getIDFA], @"username":acountnumber, @"password":password};
    
    [manager POST:registerurl parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
