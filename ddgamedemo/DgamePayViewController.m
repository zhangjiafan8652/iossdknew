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

static const NSInteger WEIXINPAY =402;

static const NSInteger ZHIFUPAY =403;


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
    uititlelabe.frame=CGRectMake([DgameUtils RealSizeWith:290],0
                                 , [DgameUtils RealSizeWith:160],[DgameUtils RealSizeheight:100]);
    uititlelabe.text=@"支付方式";
    uititlelabe.textColor=[UIColor whiteColor];
    [_muiview addSubview:uititlelabe];
    
    
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
