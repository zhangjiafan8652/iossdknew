//
//  DgameSdk.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <Foundation/Foundation.h>



#import <UIKit/UIKit.h>

@interface DgameAppDelegae : NSObject







+ (DgameAppDelegae *) Instance;


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)source Applicationannotation:(id)annotation;

-(void)applicationDidEnterBackground:(UIApplication *)application;

- (void)applicationWillEnterForeground:(UIApplication *)application;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo;

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window;

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;
@end
