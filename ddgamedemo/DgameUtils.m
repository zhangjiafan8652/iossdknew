//
//  DgameUtils.m
//  ddgamedemo
//
//  Created by TANGWEIZHONG on 2017/11/25.
//  Copyright © 2017年 doudouyule. All rights reserved.
//

#import "DgameUtils.h"

#import <UIKit/UIKit.h>

@implementation DgameUtils


static int s6with=375;
static int s6height=667;

static int s6with_lanscape=667;
static int s6height_lanscape=375;


//适配宽
+(int ) RealSizeWith:(int) with{
    if ([DgameUtils IsLandscape]) {
        int mrealsizewith=(int)([UIScreen mainScreen].bounds.size.width*with/(s6with_lanscape*2));
        return mrealsizewith;
    }else{
        int mrealsizewith=(int)([UIScreen mainScreen].bounds.size.width*with/(s6with*2));
        return mrealsizewith;
    }
    
}
//获取宽
+(int ) getWith{
    if ([DgameUtils IsLandscape]) {
        
        return s6with_lanscape;
    }else{
       
        return s6with;
    }
    
}
//获取宽
+(int ) getHeight{
    if ([DgameUtils IsLandscape]) {
        
        return s6height_lanscape;
    }else{
        
        return s6height;
    }
    
}

//适配高
+(int ) RealSizeheight:(int)height{
    
    if ([DgameUtils IsLandscape]) {
        int mrealsizeheight=(int)([UIScreen mainScreen].bounds.size.height*height/(s6height_lanscape*2));
        return mrealsizeheight;
    }else{
        int mrealsizeheight=(int)([UIScreen mainScreen].bounds.size.height*height/(s6height*2));
        return mrealsizeheight;
    }
    
   
}

+(BOOL) IsLandscape{
    
//    if ([UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height) {
//        <#statements#>
//    }
    return  [UIScreen mainScreen].bounds.size.width>[UIScreen mainScreen].bounds.size.height;
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

//字符串转成字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        
        return nil;
        
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    
    if(err) {
        
        NSLog(@"json解析失败：%@",err);
        
        return nil;
        
    }
    
    return dic;
    
}
//字典转成字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

//弹框
+ (void)alertDialog:(UIViewController *) mViewController withMessage:(NSString *) message

{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *resetAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
    [alertController addAction:resetAction];
    [mViewController presentViewController:alertController animated:YES completion:nil];
    
}

+ (NSString *)getIDFA

{
    
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
}

//弹吐司
+(void)showMessage:(NSString *)message
{
    
    [WToast showWithText:message];

}

//setuserkey值
+(void)setNSUserDefaultskey:(NSString *)key andValue:(NSString *)value
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:key];
    
    
    [defaults synchronize];//用synchronize方法把数据持久化到
    
}

//getuserkey值
+(NSString *)getNSUserDefaultsBykey:(NSString *)key
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *mstring=[defaults objectForKey:key];
    NSLog(@"这里去除的值%@",mstring);
    return mstring;//根据键值取出name
    
}

//setuser所有key值
+(void)setDgameUserNSUserDefaultskey:(DgameUser *)muser
{
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
   
    [defaults setObject:muser.username forKey:@"username"];
        [defaults setObject:muser.userid forKey:@"uid"];
    [defaults setObject:muser.token forKey:@"token"];
    [defaults setObject:muser.password forKey:@"password"];
    
    NSLog(@"保存数据%@",muser.password);
    
    
    [defaults synchronize];//用synchronize方法把数据持久化到
    
}

// 正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString*) password

{
    
    NSString *pattern =@"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    
    BOOL isMatch = [pred evaluateWithObject:password];
    
    return isMatch;
    
}
+ (BOOL)checkisPhone:(NSString*) phonenumber{
    //手机号
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    return [phoneTest evaluateWithObject:phonenumber];
    
}
@end
