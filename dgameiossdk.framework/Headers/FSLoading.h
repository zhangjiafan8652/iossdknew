//
//  FSLoading.h
//  DreamWorks
//
//  Created by lifution on 15/11/25.
//  Copyright © 2015年 lifution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FSLoading : UIView

@property (nonatomic, assign) CGFloat  diameter;        // 圆直径
@property (nonatomic, assign) BOOL     noShadow;        // 不含光晕效果
@property (nonatomic, assign) BOOL     isHide;

@property (nonatomic, retain) UIColor *topDotColor;     // 顶部圆点颜色
@property (nonatomic, retain) UIColor *leftDotColor;    // 左边圆点颜色
@property (nonatomic, retain) UIColor *rightDotColor;   // 右边圆点颜色

- (instancetype)initWithView:(UIView *)view;

- (void)show;
- (void)hide;

@end
