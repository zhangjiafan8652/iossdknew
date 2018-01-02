//
//  DgameUtils.h
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/25.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>
#import "WToast.h"
#import "DgameUser.h"


#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]
@interface DgameUtils : NSObject




+(int ) RealSizeWith:(int ) with;
+(int ) RealSizeheight:(int ) height;
+(BOOL) IsLandscape;

+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+ (void)alertDialog:(UIViewController *) mViewController withMessage:(NSString *) message;
+ (NSString *)getIDFA;
+(void)showMessage:(NSString *)message;
+(void)setNSUserDefaultskey:(NSString *)key andValue:(NSString *)value;
+(NSString *)getNSUserDefaultsBykey:(NSString *)key;
+(void)setDgameUserNSUserDefaultskey:(DgameUser *)muser;
+ (BOOL)checkPassword:(NSString*) password;
+ (BOOL)checkisPhone:(NSString*) phonenumber;
+(NSString *)getTime;
+(void)startLoading:(UIView *)mView andMessage:(NSString *)msg;
+(void)stopLoading:(UIView *)mView ;
@end
