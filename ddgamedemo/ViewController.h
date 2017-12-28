//
//  ViewController.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DgameSdk.h"
#import "DgameUtils.h"
#import "MF_Base64Additions.h"

@interface ViewController : UIViewController<DgameOnlineInitDelegate,DgameOnlineLoginDelegate,DgameOnlinePayResultDelegate>


@end

