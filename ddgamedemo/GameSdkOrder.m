//
//  DgameOrder.m
//  ddgamedemo
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "GameSdkOrder.h"

@implementation GameSdkOrder

//@property int32_t *price;
//@property NSString *goodname;
//@property NSString *cpetc;
//@property NSString *orderid;
- (NSString *)description {
    //stringWithFormat 格式化字符串函数
    return [NSString stringWithFormat:@"price=%@,goodname=%@,cpetc=%@,cporderid=%@,dgameorderid=%@",_price, _goodname,_cpetc,_cporderid,_dgameorderid];
}

@end
