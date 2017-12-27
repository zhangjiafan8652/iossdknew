//
//  DgamePayViewController.m
//  ddgamedemo
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "DgamePayViewController.h"

@interface DgamePayViewController ()

@end

@implementation DgamePayViewController

static const NSInteger PRETAG =401;

static const NSInteger WEIXINPAY =4;

static const NSInteger ZHIFUPAY =5;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建中间窗口
    [self createUiview];
    
    //添加头布局
    [ self createTitleView];
    
}

-(void)createUiview{
    
    _muiview= [[UIView alloc] init];
    
    _muiview.frame=CGRectMake(([UIScreen mainScreen].bounds.size.width-[DgameUtils RealSizeWith:640])/2,
                              ([UIScreen mainScreen].bounds.size.height-[DgameUtils RealSizeheight:640])/2
                              , [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:640]);
    _muiview.backgroundColor=[UIColor whiteColor ];
    [self.view addSubview:_muiview];
    
}


-(void)createTitleView{
    
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
    
    NSLog(@"%f",_preview.imageView.frame.size.height);
    
    _preview.backgroundColor=[DgameUtils colorWithHexString:@"#0081EF" ];
    
    _preview.tag=PRETAG;
    [_preview addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    
    
    [_muiview addSubview:_preview];
    
    //标题头
    UILabel *uititlelabe= [[UILabel alloc]init];
    uititlelabe.frame=CGRectMake([DgameUtils RealSizeWith:220],0
                                 , [DgameUtils RealSizeWith:200],[DgameUtils RealSizeheight:100]);
    uititlelabe.text=@"选择支付方式";
    uititlelabe.textColor=[UIColor whiteColor];
    uititlelabe.textAlignment = NSTextAlignmentCenter;
    [_muiview addSubview:uititlelabe];
    
    //物品名称
    UILabel *goodnamelabe= [[UILabel alloc]init];
    goodnamelabe.frame=CGRectMake([DgameUtils RealSizeWith:220],[DgameUtils RealSizeheight:120]
                                 , [DgameUtils RealSizeWith:200],[DgameUtils RealSizeheight:40]);
    goodnamelabe.text=@"元宝";
    goodnamelabe.textColor=[UIColor grayColor];
    goodnamelabe.textAlignment = NSTextAlignmentCenter;
    
    [_muiview addSubview:goodnamelabe];
    
    //钱
    UILabel *moneylabe= [[UILabel alloc]init];
    moneylabe.frame=CGRectMake([DgameUtils RealSizeWith:220],[DgameUtils RealSizeheight:160]
                                  , [DgameUtils RealSizeWith:200],[DgameUtils RealSizeheight:70]);
    moneylabe.text=@"￥365.00";
    moneylabe.textColor=[DgameUtils colorWithHexString:@"#0081EF" ];
    
    moneylabe.textAlignment = NSTextAlignmentCenter;
    
    [moneylabe setFont:[UIFont boldSystemFontOfSize:20]];
    
    [_muiview addSubview:moneylabe];
    
    //横线
    UIView *horizontalLine1 = [[UIView alloc]initWithFrame:CGRectMake(0, [DgameUtils RealSizeheight:240], [DgameUtils RealSizeWith:640], 1)];
    horizontalLine1.backgroundColor = [DgameUtils colorWithHexString:@"dddddd"];
    [_muiview addSubview:horizontalLine1];
    
    //微信支付
    UIButton* _weixinpay=[[UIButton alloc] init];
    
    _weixinpay.frame=CGRectMake(0, [DgameUtils RealSizeheight:260], [DgameUtils RealSizeWith:640], [DgameUtils RealSizeheight:80]);
    _weixinpay.backgroundColor=[UIColor whiteColor];
    [_weixinpay setTitle:@"微信支付" forState:UIControlStateNormal];
    [_weixinpay setTitle:@"微信支付" forState:UIControlStateHighlighted];
    [_weixinpay setImage:[UIImage imageNamed:@"dgameassets/dgame_weixinpay.png"] forState:UIControlStateNormal];
    [_weixinpay setTitleColor:[DgameUtils colorWithHexString:@"4B4B4B"] forState:UIControlStateNormal];
     [_weixinpay setTitleColor:[DgameUtils colorWithHexString:@"808080"] forState:UIControlStateHighlighted];
    _weixinpay.tag=WEIXINPAY;
    [_weixinpay addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    _weixinpay.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _weixinpay.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
    //_registerbutton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);//设置文字和图片的距离
   // _registerbutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);//设置图片和左边的距离
    [_muiview addSubview:_weixinpay];
    
    //横线
    UIView *horizontalLine2 = [[UIView alloc]initWithFrame:CGRectMake(0, [DgameUtils RealSizeheight:360], [DgameUtils RealSizeWith:640], 1)];
    horizontalLine2.backgroundColor = [DgameUtils colorWithHexString:@"dddddd"];
    [_muiview addSubview:horizontalLine2];
    
    
    //支付宝支付
    UIButton* _zhifubutton=[[UIButton alloc] init];
    _zhifubutton.frame=CGRectMake(0, [DgameUtils RealSizeheight:380], [DgameUtils RealSizeWith:640], [DgameUtils RealSizeheight:80]);
    _zhifubutton.backgroundColor=[UIColor whiteColor];
    [_zhifubutton setTitle:@"支付宝支付" forState:UIControlStateNormal];
    [_zhifubutton setTitle:@"支付宝支付" forState:UIControlStateHighlighted];
    [_zhifubutton setImage:[UIImage imageNamed:@"dgameassets/dgame_zhifu.png"] forState:UIControlStateNormal];
    [_zhifubutton setTitleColor:[DgameUtils colorWithHexString:@"4B4B4B"] forState:UIControlStateNormal];
     [_zhifubutton setTitleColor:[DgameUtils colorWithHexString:@"808080"] forState:UIControlStateHighlighted];
    _zhifubutton.tag=ZHIFUPAY;
    [_zhifubutton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];//点击监听
    _zhifubutton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    _zhifubutton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
   // _zhifubutton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);//设置文字和图片的距离
   // _zhifubutton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);//设置图片和左边的距离
    [_muiview addSubview:_zhifubutton];
    
    //横线
    UIView *horizontalLine3 = [[UIView alloc]initWithFrame:CGRectMake(0, [DgameUtils RealSizeheight:480], [DgameUtils RealSizeWith:640], 1)];
    horizontalLine3.backgroundColor = [DgameUtils colorWithHexString:@"dddddd"];
    [_muiview addSubview:horizontalLine3];
    
    //提示1
    UILabel *tiplabe1= [[UILabel alloc]init];
    tiplabe1.frame=CGRectMake(0,[DgameUtils RealSizeheight:500]
                               , [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:40]);
    tiplabe1.text=@"充值后，1-10分钟到账，请耐心等待，放心充值";
    tiplabe1.textColor=[DgameUtils colorWithHexString:@"#FF3300" ];
    
    tiplabe1.textAlignment = NSTextAlignmentCenter;
    
    [tiplabe1 setFont:[UIFont boldSystemFontOfSize:10]];
    
    [_muiview addSubview:tiplabe1];
    
    UILabel *tiplabe2= [[UILabel alloc]init];
    tiplabe2.frame=CGRectMake(0,[DgameUtils RealSizeheight:545]
                              , [DgameUtils RealSizeWith:640],[DgameUtils RealSizeheight:40]);
    tiplabe2.text=@"充值唯一官方客服qq:365449552";
    tiplabe2.textColor=[DgameUtils colorWithHexString:@"#FF3300" ];
    
    tiplabe2.textAlignment = NSTextAlignmentCenter;
    
    [tiplabe2 setFont:[UIFont boldSystemFontOfSize:10]];
    
    [_muiview addSubview:tiplabe2];
    
}

- (void)buttonClick:(UIButton *)button{
    if (button.tag==PRETAG) {
      
         [self dismissViewControllerAnimated:YES completion:nil];
        
    }else if(button.tag==WEIXINPAY){
        NSLog(@"微信支付");
        [self startPay:WEIXINPAY];
        
        
    }else if(button.tag==ZHIFUPAY){
        NSLog(@"支付宝支付");
        [self startPay:ZHIFUPAY];

        
        
    }
}


-(void)startPay:(int)type{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
   
    NSString *appid=[DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    NSString *uid=[DgameUtils getNSUserDefaultsBykey:@"uid"];
    NSString *token=[DgameUtils getNSUserDefaultsBykey:@"token"];
    
    //NSString *app_ver=[DgameUtils getNSUserDefaultsBykey:@"app_version"];
   // NSString *role_level=[DgameSdk Instance].mRole.roleLevel;
    
    
    NSString *amount = [[NSString alloc] initWithFormat:@"%i",[DgameSdk Instance].morder.price];
    NSString *pay_type = [[NSString alloc] initWithFormat:@"%d",type];
    // NSMutableDictionary *parameters = @{@"idfa":IDFA,@"app_id":APPID};
    //  NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:IDFA,@"idfa",APPID,@"app_id",nil];
    NSLog(@"uid%@",uid);
    NSLog(@"appid%@",appid);
    //NSLog(@"app_ver%@",app_ver);
    //NSLog(@"role_level%@",role_level);
    NSLog(@"token%@",token);
    NSLog(@"amount%@",amount);
    NSLog(@"pay_type%@",pay_type);
    NSLog(@"ext%@",[DgameSdk Instance].morder.cpetc);
    NSLog(@"orderid%@",[DgameSdk Instance].morder.orderid);

    
    NSLog(@"url%@",payiniturl);
    
    NSDictionary *parametersDemo = @{@"uid":uid,@"app_id":appid,@"amount":amount,@"pay_type":pay_type,@"token":token,@"ext":[DgameSdk Instance].morder.cpetc,@"orderid":[DgameSdk Instance].morder.orderid};
    [manager POST:payiniturl parameters:parametersDemo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"自有平台开始支付返回%@",responseObject);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"获取支付信息返回%@",str);
        if ([str isEqualToString:@"success"]) {
            
            //NSDictionary *data=[KJSON objectForKey:@"data"];
          //  NSString *toggle=[data objectForKey:@"toggle"];
           // NSInteger toggleint = [toggle integerValue];
            
        }
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];
    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
