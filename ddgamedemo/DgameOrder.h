//
//  DgameOrder.h
//  ddgamedemo
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DgameOrder : NSObject


@property NSString *price;
@property NSString *goodname;
@property NSString *cpetc;
@property NSString *cporderid;
@property NSString *payurl;
@property NSString *dgameorderid;

- (NSString *)description;
@end
