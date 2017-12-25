//
//  UIView+FSLoading.m
//  DreamWorks
//
//  Created by lifution on 15/11/25.
//  Copyright © 2015年 lifution. All rights reserved.
//

#import "UIView+FSLoading.h"
#import "FSLoading.h"
#import <objc/runtime.h>

static const void *FSLoadingKey = &FSLoadingKey;

@implementation UIView (FSLoading)

- (FSLoading *)loading{
    return objc_getAssociatedObject(self, FSLoadingKey);
}

- (void)setLoading:(FSLoading *)loading{
    objc_setAssociatedObject(self, FSLoadingKey, loading, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showLoading
{
    if (![self loading].isHide && [self loading]) {
        return;
    }
    
    FSLoading *loading;
    if ([self loading]) {
        loading = [self loading];
    } else {
        loading = [[FSLoading alloc] initWithView:self];
        [self setLoading:loading];
    }
    
#ifdef DEBUG
    NSLog(@"------%p------", loading);
#endif
    
    #warning 三个圆点的颜色
//    loading.topDotColor   = [UIColor orangeColor];
//    loading.leftDotColor  = [UIColor orangeColor];
//    loading.rightDotColor = [UIColor orangeColor];
    
    #warning 圆点是否带光晕效果
//    loading.noShadow      = YES;
    
    #warning 圆点直径
//    loading.diameter      = 20;
    
    [self addSubview:loading];
    [self bringSubviewToFront:loading];
    
    [loading show];
}

- (void)hideLoading
{
    [self loading].isHide = YES;
}

@end
