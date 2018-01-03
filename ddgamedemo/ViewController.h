//
//  ViewController.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "GameSdk.h"


@interface ViewController : UIViewController<GameSdkLoginDelegate,GameSdkInitDelegate,GameSdkPayResultDelegate>


@end

