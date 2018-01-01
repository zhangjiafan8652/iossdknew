//
//  ApplePayViewController.m
//  ddgamedemo
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "ApplePayViewController.h"

@interface ApplePayViewController ()

@end

@implementation ApplePayViewController


static const NSInteger PRETAG =601;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self showLoading];
    NSLog(@"-----开始交易 --------");
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
        //创建中间窗口
    [self createUiview];
    
    //创建标题头
    [self createTitleView];
    
    [self showLoading];

    
    //创建平台订单
    [self createOrder];
   
    
    //
    
    //logic
    
    
    
    
}

- (void)hideLoading {
    // 隐藏动画
    [DgameUtils stopLoading:self.view];
}

- (void)showLoading{
    
    
    [DgameUtils startLoading:self.view andMessage:@"正在加载..."];
    
    // 显示动画
    //   [self showLoading]
    
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


- (void)buttonClick:(UIButton *)button{
    if (button.tag==PRETAG) {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

-(void)createOrder{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    NSString *appid=[DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    NSString *uid=[DgameUtils getNSUserDefaultsBykey:@"uid"];
    NSString *token=[DgameUtils getNSUserDefaultsBykey:@"token"];
    
    NSString *muername=[DgameUtils getNSUserDefaultsBykey:@"username"];
    
    
    
    NSString *amount = [DgameSdk Instance].morder.price;
    
    NSLog(@"uid%@",uid);
    NSLog(@"appid%@",appid);
    NSLog(@"username%@",muername);
    //NSLog(@"role_level%@",role_level);
    NSLog(@"token%@",token);
    NSLog(@"amount%@",amount);
    
    NSLog(@"ext%@",[DgameSdk Instance].morder.cpetc);
    NSLog(@"orderid%@",[DgameSdk Instance].morder.cporderid);
    
    
    NSLog(@"url%@",unionpayurl);
    
    NSDictionary *parametersDemo = @{@"uid":uid,@"app_id":appid,@"amount":amount,@"username":muername,@"remark":[DgameSdk Instance].morder.cpetc,@"transid":[DgameSdk Instance].morder.cporderid};
    [manager POST:unionpayurl parameters:parametersDemo progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"自有平台开始appstore支付返回%@",responseObject);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"获取支付信息返回%@",str);
        if ([str isEqualToString:@"success"]) {
            
            NSDictionary *data=[KJSON objectForKey:@"data"];
            NSString *dgameid=[data objectForKey:@"id"];
            NSLog(@"dgameid%@",dgameid);
            [DgameSdk Instance].morder.dgameorderid=dgameid;
            [self startPay];
            
        }else{
            
        }
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];

    
}
-(void)startPay{
    
    NSString *productidpre=@"dgame_good_";
    self.productsId = [productidpre stringByAppendingString:[DgameSdk Instance].morder.price];
    //self.quantity = quantity;
    NSLog(@"producid==%@",_productsId);
    if ([SKPaymentQueue canMakePayments]) {
        //允许程序内付费购买
        [self RequestProductData:@[self.productsId]];
    } else {
        //您的手机没有打开程序内付费购买
        UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"您的手机没有打开程序内付费购买" message:nil delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:nil];
        [alerView show];
    }
}

- (void)RequestProductData:(NSArray *)productsIdArr {
    //请求对应的产品信息
    NSSet *nsset = [NSSet setWithArray:productsIdArr];
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:nsset];
    request.delegate = self;
    [request start];
}
//弹出错误信息
- (void)request:(SKRequest *)request didFailWithError:(NSError *)error{
    NSLog(@"-------弹出错误信息----------");
    UIAlertView *alerView =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Alert",NULL) message:[error localizedDescription]
                                                       delegate:nil cancelButtonTitle:NSLocalizedString(@"Close",nil) otherButtonTitles:nil];
    [alerView show];
    
}

-(void) requestDidFinish:(SKRequest *)request
{
    NSLog(@"----------反馈信息结束--------------");
    
}

-(void) PurchasedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"-----PurchasedTransaction----");
    NSArray *transactions =[[NSArray alloc] initWithObjects:transaction, nil];
    [self paymentQueue:[SKPaymentQueue defaultQueue] updatedTransactions:transactions];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    //收到产品反馈信息
    NSArray *myProduct = response.products;
    NSLog(@"产品Product ID:%@", response.invalidProductIdentifiers);
    NSLog(@"产品付费数量: %d", (int) [myProduct count]);
    // populate UI
    for (SKProduct *product in myProduct) {
       
        [self updateProductPriceWithId:product.productIdentifier andPrice:product.price];
        if ([[product.priceLocale objectForKey:NSLocaleCurrencyCode] isEqualToString:@"CNY"]) {
            self.currencyCode = @"￥";
        } else {
            self.currencyCode = [product.priceLocale objectForKey:NSLocaleCurrencySymbol];
        }
    }
    //发送购买请求
    for (SKProduct *prct in myProduct) {
        if ([self.productsId isEqualToString:prct.productIdentifier]) {
            SKMutablePayment *payment = nil;
            payment = [SKMutablePayment paymentWithProduct:prct];
            payment.quantity = 1;
             NSLog(@"发送购买请求%@",self.productsId );
            [[SKPaymentQueue defaultQueue] addPayment:payment];
        }
    }
    
}

- (void)updateProductPriceWithId:(NSString *)productIdentifier andPrice:(NSDecimalNumber *)price{
    NSLog(@"productIdentifier == %@",productIdentifier);
    NSLog(@"price == %@",price);
}



//----监听购买结果
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    //交易结果
    NSLog(@"-----paymentQueue--------");
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:{//交易完成
                [self completeTransaction:transaction];
                NSLog(@"-----交易完成 --------");
                
                [self notifyServ:transaction];
                
                
                
            } break;
            case SKPaymentTransactionStateFailed://交易失败
            { [self failedTransaction:transaction];
                NSLog(@"-----交易失败 --------");
                [self onPayFail:@"支付失败"];
                UIAlertView *alerView2 =  [[UIAlertView alloc] initWithTitle:@"提示"
                                                                     message:@"购买失败，请重新尝试购买"
                                                                    delegate:nil cancelButtonTitle:NSLocalizedString(@"关闭",nil) otherButtonTitles:nil];
                
                [alerView2 show];
                
            }break;
            case SKPaymentTransactionStateRestored://已经购买过该商品
                [self restoreTransaction:transaction];
                NSLog(@"-----已经购买过该商品 --------");
            case SKPaymentTransactionStatePurchasing:      //商品添加进列表
                NSLog(@"-----商品添加进列表 --------");
                break;
            default:
                break;
        }
    }
    
}
- (void) failedTransaction: (SKPaymentTransaction *)transaction{
    NSLog(@"失败");
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        
    }
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
    
}


-(void)onPayFail:(NSString *)msg{
    [DgameUtils showMessage:msg];
    [[DgameSdk Instance] onPayFailed:msg];
    
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"交易恢复处理");
    //[[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}


- (void) completeTransaction: (SKPaymentTransaction *)transaction

{
    
    [self hideLoading];
    NSLog(@"-----completeTransaction--------");
    // Your application should implement these two methods.
    NSString *product = transaction.payment.productIdentifier;
    if ([product length] > 0) {
        
        NSArray *tt = [product componentsSeparatedByString:@"."];
        NSString *bookid = [tt lastObject];
        if ([bookid length] > 0) {
            [self recordTransaction:bookid];
            [self provideContent:bookid];
        }
        
    }
    
      [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}


//记录交易
-(void)recordTransaction:(NSString *)product{
    NSLog(@"-----记录交易--------");
}

//处理下载内容
-(void)provideContent:(NSString *)product{
    NSLog(@"-----下载--------");
}



-(void)notifyServ:(SKPaymentTransaction *)transaction{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    NSString *appid=[DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    
    
    NSString *amount = [DgameSdk Instance].morder.price;
    
    
    NSData * receiptData = transaction.transactionReceipt;
    NSString *transactionReceiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           [DgameSdk Instance].morder.dgameorderid,@"orderid",
                           amount, @"price",
                           transactionReceiptString,@"receipt",
                           _productsId,@"goods_id",
                           nil];
    
    NSString *url = [[notifyurl stringByAppendingString:appid] stringByAppendingString:@"/"];
    NSLog(@"orderid%@",[DgameSdk Instance].morder.dgameorderid);
    NSLog(@"price%@",amount);
    NSLog(@"receipt%@",transactionReceiptString);
    NSLog(@"goods_id%@",_productsId);
    NSLog(@"url%@",url);
    
    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"自有平台开始appstore支付后 通知返回%@",responseObject);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"msg"];
        NSLog(@"获取支付信息返回%@",str);
        
        if([str isEqualToString:@"充值成功"]){
            [[DgameSdk Instance] onPaySuccess:@"appstore支付成功"];
        }
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
       
        NSDictionary *KJSON=[DgameUtils dictionaryWithJsonString:responseString];
        NSString *str=[KJSON objectForKey:@"msg"];
        NSLog(@"获取支付信息返回%@",str);
        
        if([str isEqualToString:@"充值成功"]){
            [[DgameSdk Instance] onPaySuccess:@"appstore支付成功"];
        }

        //failure(error);
    }];

}

-(void)ceshi{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    ////发送二进制form数据 key=value&key2=value2
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    ////响应二进制form数据
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    
    NSString *appid=[DgameUtils getNSUserDefaultsBykey:@"app_id"];
    
    
    
    NSString *amount = [DgameSdk Instance].morder.price;
    
    
    //NSData * receiptData = transaction.transactionReceipt;
    //NSString *transactionReceiptString = [receiptData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
                           [DgameSdk Instance].morder.dgameorderid,@"orderid",
                           amount, @"price",
                           @"123",@"receipt",
                           _productsId,@"goods_id",
                           nil];
    
    NSString *url = [notifyurl stringByAppendingString:appid];
    NSLog(@"orderid%@",[DgameSdk Instance].morder.dgameorderid);
    NSLog(@"price%@",amount);
   // NSLog(@"receipt%@",transactionReceiptString);
    NSLog(@"goods_id%@",_productsId);
    NSLog(@"url%@",url);

    [manager POST:url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"自有平台开始appstore支付后 通知返回%@",responseObject);
        NSDictionary *KJSON=(NSDictionary*)responseObject;
        NSString *str=[KJSON objectForKey:@"err_msg"];
        NSLog(@"获取支付信息返回%@",str);
        
        
        //success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSString *responseString =  [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSLog(@"失败%@",responseString);
        //failure(error);
    }];
}
-(void)dealloc
{
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];//解除监听
    
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
