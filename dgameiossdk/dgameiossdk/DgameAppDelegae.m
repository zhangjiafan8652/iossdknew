//
//  DgameSdk.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/21.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "DgameAppDelegae.h"

@implementation DgameAppDelegae

static DgameAppDelegae *mdgamesdk=nil;

+ (DgameAppDelegae *)Instance{

    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mdgamesdk=[[self alloc] init];
    });
    return mdgamesdk;

}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)source Applicationannotation:(id)annotation{
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application{

}

- (void)applicationWillEnterForeground:(UIApplication *)application{

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
	return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{

}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{

}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return  1;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
	return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
	return YES;
}
@end
