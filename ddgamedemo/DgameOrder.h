//
//  DgameOrder.h
//  ddgamedemo
//
//  Created by Apple on 2017/12/26.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DgameOrder : NSObject


@property int32_t *price;
@property NSString *goodname;
@property NSString *cpetc;
@property NSString *orderid;

- (NSString *)description;
@end
