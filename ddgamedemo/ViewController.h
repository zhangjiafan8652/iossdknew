//
//  ViewController.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <dgameiossdk/DgameUtils.h>
#import <dgameiossdk/DgameSdk.h>
#import <dgameiossdk/MF_Base64Additions.h>


@interface ViewController : UIViewController<DgameOnlineInitDelegate,DgameOnlineLoginDelegate,DgameOnlinePayResultDelegate>


@end

