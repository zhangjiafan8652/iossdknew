//
//  FSLoading.m
//  DreamWorks
//
//  Created by lifution on 15/11/25.
//  Copyright © 2015年 lifution. All rights reserved.
//

#import "FSLoading.h"

@interface FSLoading () {
    CALayer *_topDot;
    CALayer *_leftDot;
    CALayer *_rightDot;
}

@end

CGFloat const duration = .5;
CGFloat const waitTime = .6;

@implementation FSLoading

- (instancetype)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) return nil;
    
    self.backgroundColor = UIColor.clearColor;
    self.isHide          = NO;
    
    return self;
}

- (instancetype)initWithView:(UIView *)view
{
    NSAssert(view, @"view must not be nil.");
    return [self initWithFrame:view.bounds];
}


#pragma mark -- getter

- (CGFloat)diameter
{
    if (_diameter) return _diameter;
    
    return 20;
}

- (UIColor *)topDotColor
{
    if (_topDotColor) return _topDotColor;
    
    return UIColor.redColor;
}

- (UIColor *)leftDotColor
{
    if (_leftDotColor) return _leftDotColor;
    
    return UIColor.greenColor;
}

- (UIColor *)rightDotColor
{
    if (_rightDotColor) return _rightDotColor;
    
    return UIColor.blueColor;
}

#pragma mark -- public

- (void)show
{
    self.isHide = NO;
    
    // 开始时三圆点中心位置
    CGPoint topPosition   = CGPointMake(self.center.x, self.center.y-self.diameter);
    CGPoint leftPosition  = CGPointMake(self.center.x-sqrt(3)*self.diameter/2, self.center.y+self.diameter/2);
    CGPoint rightPosition = CGPointMake(self.center.x+sqrt(3)*self.diameter/2, self.center.y+self.diameter/2);
    
    _topDot   = [self buildDotWithColor:self.topDotColor position:topPosition diameter:self.diameter];
    _leftDot  = [self buildDotWithColor:self.leftDotColor position:leftPosition diameter:self.diameter];
    _rightDot = [self buildDotWithColor:self.rightDotColor position:rightPosition diameter:self.diameter];
    
    [self.layer addSublayer:_topDot];
    [self.layer addSublayer:_leftDot];
    [self.layer addSublayer:_rightDot];
    
    // 开始进入动画
    [self startAnimation];
}


#pragma mark -- private

- (void)hide
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.layer.anchorPoint   = CGPointMake(.5, .5);
    scaleAnimation.fromValue = @1.0;
    scaleAnimation.toValue   = @2.0;
    scaleAnimation.duration  = 0.25;
    [self.layer addAnimation:scaleAnimation forKey:@"scale"];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [_topDot   removeFromSuperlayer];
        [_leftDot  removeFromSuperlayer];
        [_rightDot removeFromSuperlayer];
        _topDot   = nil;
        _leftDot  = nil;
        _rightDot = nil;
        [self removeFromSuperview];
    }];
}

- (CALayer *)buildDotWithColor:(UIColor *)color position:(CGPoint)position diameter:(CGFloat)diameter
{
    CALayer *layer        = CALayer.new;
    layer.bounds          = CGRectMake(0, 0, diameter, diameter);
    layer.position        = position;
    layer.cornerRadius    = diameter/2;
    layer.backgroundColor = color.CGColor;
    
    // 无光晕效果
    if (self.noShadow) return layer;
    
    layer.shadowPath      = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    layer.shadowOffset    = CGSizeZero;
    layer.shadowRadius    = diameter/2;
    layer.shadowOpacity   = .8;
    layer.shadowColor     = color.CGColor;
    
    return layer;
}


#pragma mark -- 动画
// 进入动画
- (void)startAnimation
{
    self.alpha = 0;
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.layer.anchorPoint   = CGPointMake(.5, .5);
    scaleAnimation.fromValue = @2.0;
    scaleAnimation.toValue   = @1.0;
    scaleAnimation.duration  = 0.25;
    [self.layer addAnimation:scaleAnimation forKey:@"scale"];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self performSelector:@selector(topDotMoveDown) withObject:nil afterDelay:.18];
    }];
}

- (void)topDotMoveDown
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveDownWithTopDot:_topDot leftDot:_leftDot rightDot:_rightDot];
    
    [self performSelector:@selector(rightDotMoveLeftBottom) withObject:nil afterDelay:waitTime];
}

- (void)rightDotMoveLeftBottom
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveLeftBottomWithRightDot:_rightDot leftDot:_leftDot bottomDot:_topDot];
    
    [self performSelector:@selector(topDotMoveDownAgain) withObject:nil afterDelay:waitTime];
}

- (void)topDotMoveDownAgain
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveDownWithTopDot:_leftDot leftDot:_rightDot rightDot:_topDot];
    
    [self performSelector:@selector(leftDotMoveRightBottom) withObject:nil afterDelay:waitTime];
}

- (void)leftDotMoveRightBottom
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveRightBottomWithLeftDot:_rightDot rightDot:_topDot bottomDot:_leftDot];
    
    [self performSelector:@selector(leftDotMoveRightTop) withObject:nil afterDelay:waitTime];
}

- (void)leftDotMoveRightTop
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveRightTopWithLeftDot:_leftDot rightDot:_rightDot topDot:_topDot];
    
    [self performSelector:@selector(bottomDotMoveUp) withObject:nil afterDelay:waitTime];
}

- (void)bottomDotMoveUp
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveUpWithBottomDot:_rightDot leftDot:_topDot rightDot:_leftDot];
    
    [self performSelector:@selector(rightDotMoveLeftTop) withObject:nil afterDelay:waitTime];
}

- (void)rightDotMoveLeftTop
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveLeftTopWithRightDot:_leftDot leftDot:_topDot topDot:_rightDot];
    
    [self performSelector:@selector(rightMoveLeftBottomAgain) withObject:nil afterDelay:waitTime];
}

- (void)rightMoveLeftBottomAgain
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveLeftBottomWithRightDot:_rightDot leftDot:_leftDot bottomDot:_topDot];
    
    [self performSelector:@selector(rightMoveLeftTopAgain) withObject:nil afterDelay:waitTime];
}

- (void)rightMoveLeftTopAgain
{
    if (self.isHide) {
        [self hide];
        return;
    }
    
    [self moveLeftTopWithRightDot:_topDot leftDot:_rightDot topDot:_leftDot];
    
    [self performSelector:@selector(rightMoveLeftBottomEnd) withObject:nil afterDelay:waitTime];
}

- (void)rightMoveLeftBottomEnd
{
    [self moveLeftBottomWithRightDot:_leftDot leftDot:_topDot bottomDot:_rightDot];
    
    [self performSelector:@selector(topDotMoveDown) withObject:nil afterDelay:waitTime];
}


// 往下移
- (void)moveDownWithTopDot:(CALayer *)topDot leftDot:(CALayer *)leftDot rightDot:(CALayer *)rightDot
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:topDot.position];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(self.center.x,self.center.y+self.diameter)];
    moveAnimation.duration  = duration;
    topDot.position         = [moveAnimation.toValue CGPointValue];
    [topDot addAnimation:moveAnimation forKey:@"move"];
    
    
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    CGPoint leftFromPoint  = leftDot.position;
    CGPoint leftToPoint    = CGPointMake(leftDot.position.x, leftDot.position.y-self.diameter);
    [leftPath moveToPoint:leftFromPoint];
    [leftPath addQuadCurveToPoint:leftToPoint controlPoint:CGPointMake(self.center.x-self.diameter*1.5, self.center.y)];
    CAKeyframeAnimation *leftMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    leftMoveAnimation.path     = leftPath.CGPath;
    leftMoveAnimation.fillMode = kCAFillModeForwards;
    leftMoveAnimation.duration = duration;
    leftDot.position           = leftToPoint;
    [leftDot addAnimation:leftMoveAnimation forKey:@"move"];
    
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    CGPoint rightFromPoint  = rightDot.position;
    CGPoint rightToPoint    = CGPointMake(rightDot.position.x, rightDot.position.y-self.diameter);
    [rightPath moveToPoint:rightFromPoint];
    [rightPath addQuadCurveToPoint:rightToPoint controlPoint:CGPointMake(self.center.x+self.diameter*1.5, self.center.y)];
    CAKeyframeAnimation *rightMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    rightMoveAnimation.path     = rightPath.CGPath;
    rightMoveAnimation.fillMode = kCAFillModeForwards;
    rightMoveAnimation.duration = duration;
    rightDot.position           = rightToPoint;
    [rightDot addAnimation:rightMoveAnimation forKey:@"move"];
}

// 往上移
- (void)moveUpWithBottomDot:(CALayer *)bottomDot leftDot:(CALayer *)leftDot rightDot:(CALayer *)rightDot
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:bottomDot.position];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y-self.diameter)];
    moveAnimation.duration  = duration;
    bottomDot.position      = [moveAnimation.toValue CGPointValue];
    [bottomDot addAnimation:moveAnimation forKey:@"move"];
    
    
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    CGPoint leftFromPoint  = leftDot.position;
    CGPoint leftToPoint    = CGPointMake(self.center.x-sqrt(3)*self.diameter/2, self.center.y+self.diameter/2);
    [leftPath moveToPoint:leftFromPoint];
    [leftPath addQuadCurveToPoint:leftToPoint controlPoint:CGPointMake(self.center.x-self.diameter*1.5, self.center.y)];
    CAKeyframeAnimation *leftMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    leftMoveAnimation.path     = leftPath.CGPath;
    leftMoveAnimation.fillMode = kCAFillModeForwards;
    leftMoveAnimation.duration = duration;
    leftDot.position           = leftToPoint;
    [leftDot addAnimation:leftMoveAnimation forKey:@"move"];
    
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    CGPoint rightFromPoint  = rightDot.position;
    CGPoint rightToPoint    = CGPointMake(self.center.x+sqrt(3)*self.diameter/2, self.center.y+self.diameter/2);
    [rightPath moveToPoint:rightFromPoint];
    [rightPath addQuadCurveToPoint:rightToPoint controlPoint:CGPointMake(self.center.x+self.diameter*1.5, self.center.y)];
    CAKeyframeAnimation *rightMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    rightMoveAnimation.path     = rightPath.CGPath;
    rightMoveAnimation.fillMode = kCAFillModeForwards;
    rightMoveAnimation.duration = duration;
    rightDot.position           = rightToPoint;
    [rightDot addAnimation:rightMoveAnimation forKey:@"move"];
}

// 往左下移
- (void)moveLeftBottomWithRightDot:(CALayer *)rightDot leftDot:(CALayer *)leftDot bottomDot:(CALayer *)bottomDot
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:rightDot.position];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(self.center.x-sqrt(3)*self.diameter/2, self.center.y+self.diameter/2)];
    moveAnimation.duration  = duration;
    rightDot.position       = [moveAnimation.toValue CGPointValue];
    [rightDot addAnimation:moveAnimation forKey:@"move"];
    
    
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    CGPoint leftFromPoint  = leftDot.position;
    CGPoint leftToPoint    = CGPointMake(self.center.x, self.center.y-self.diameter);
    [leftPath moveToPoint:leftFromPoint];
    [leftPath addQuadCurveToPoint:leftToPoint controlPoint:CGPointMake(self.center.x-self.diameter, self.center.y-sqrt(3)*self.diameter)];
    CAKeyframeAnimation *leftMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    leftMoveAnimation.path     = leftPath.CGPath;
    leftMoveAnimation.fillMode = kCAFillModeForwards;
    leftMoveAnimation.duration = duration;
    leftDot.position           = leftToPoint;
    [leftDot addAnimation:leftMoveAnimation forKey:@"move"];
    
    
    UIBezierPath *bottomPath = [UIBezierPath bezierPath];
    CGPoint bottomFromPoint  = bottomDot.position;
    CGPoint bottomToPoint    = CGPointMake(self.center.x+sqrt(3)*self.diameter/2, self.center.y+self.diameter/2);
    [bottomPath moveToPoint:bottomFromPoint];
    [bottomPath addQuadCurveToPoint:bottomToPoint controlPoint:CGPointMake(self.center.x+self.diameter, self.center.y+sqrt(3)*self.diameter)];
    CAKeyframeAnimation *bottomMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    bottomMoveAnimation.path     = bottomPath.CGPath;
    bottomMoveAnimation.fillMode = kCAFillModeForwards;
    bottomMoveAnimation.duration = duration;
    bottomDot.position           = bottomToPoint;
    [bottomDot addAnimation:bottomMoveAnimation forKey:@"move"];
}

// 往左上移
- (void)moveLeftTopWithRightDot:(CALayer *)rightDot leftDot:(CALayer *)leftDot topDot:(CALayer *)topDot
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:rightDot.position];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(leftDot.position.x, leftDot.position.y-self.diameter)];
    moveAnimation.duration  = duration;
    rightDot.position       = [moveAnimation.toValue CGPointValue];
    [rightDot addAnimation:moveAnimation forKey:@"move"];
    
    
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    CGPoint leftFromPoint  = leftDot.position;
    CGPoint leftToPoint    = CGPointMake(self.center.x, self.center.y+self.diameter);
    [leftPath moveToPoint:leftFromPoint];
    [leftPath addQuadCurveToPoint:leftToPoint controlPoint:CGPointMake(self.center.x-self.diameter, self.center.y+sqrt(3)*self.diameter)];
    CAKeyframeAnimation *leftMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    leftMoveAnimation.path     = leftPath.CGPath;
    leftMoveAnimation.fillMode = kCAFillModeForwards;
    leftMoveAnimation.duration = duration;
    leftDot.position           = leftToPoint;
    [leftDot addAnimation:leftMoveAnimation forKey:@"move"];
    
    
    UIBezierPath *topPath = [UIBezierPath bezierPath];
    CGPoint topFromPoint  = topDot.position;
    CGPoint topToPoint    = CGPointMake(self.center.x+sqrt(3)*self.diameter/2, self.center.y-self.diameter/2);
    [topPath moveToPoint:topFromPoint];
    [topPath addQuadCurveToPoint:topToPoint controlPoint:CGPointMake(self.center.x+self.diameter, self.center.y-sqrt(3)*self.diameter)];
    CAKeyframeAnimation *topMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    topMoveAnimation.path     = topPath.CGPath;
    topMoveAnimation.fillMode = kCAFillModeForwards;
    topMoveAnimation.duration = duration;
    topDot.position           = topToPoint;
    [topDot addAnimation:topMoveAnimation forKey:@"move"];
}

// 往右上移动
- (void)moveRightTopWithLeftDot:(CALayer *)leftDot rightDot:(CALayer *)rightDot topDot:(CALayer *)topDot
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:leftDot.position];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(rightDot.position.x, rightDot.position.y-self.diameter)];
    moveAnimation.duration  = duration;
    leftDot.position        = [moveAnimation.toValue CGPointValue];
    [leftDot addAnimation:moveAnimation forKey:@"move"];
    
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    CGPoint rightFromPoint  = rightDot.position;
    CGPoint rightToPoint    = CGPointMake(self.center.x,self.center.y+self.diameter);
    [rightPath moveToPoint:rightFromPoint];
    [rightPath addQuadCurveToPoint:rightToPoint controlPoint:CGPointMake(self.center.x+self.diameter, self.center.y+sqrt(3)*self.diameter)];
    CAKeyframeAnimation *leftMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    leftMoveAnimation.path     = rightPath.CGPath;
    leftMoveAnimation.fillMode = kCAFillModeForwards;
    leftMoveAnimation.duration = duration;
    rightDot.position          = rightToPoint;
    [rightDot addAnimation:leftMoveAnimation forKey:@"move"];
    
    
    UIBezierPath *topPath = [UIBezierPath bezierPath];
    CGPoint topFromPoint  = topDot.position;
    CGPoint topToPoint    = CGPointMake(self.center.x-self.diameter*sqrt(3)/2, self.center.y-self.diameter/2);
    [topPath moveToPoint:topFromPoint];
    [topPath addQuadCurveToPoint:topToPoint controlPoint:CGPointMake(self.center.x-self.diameter, self.center.y-sqrt(3)*self.diameter)];
    CAKeyframeAnimation *topMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    topMoveAnimation.path     = topPath.CGPath;
    topMoveAnimation.fillMode = kCAFillModeForwards;
    topMoveAnimation.duration = duration;
    topDot.position           = topToPoint;
    [topDot addAnimation:topMoveAnimation forKey:@"move"];
}

// 往右下移动
- (void)moveRightBottomWithLeftDot:(CALayer *)leftDot rightDot:(CALayer *)rightDot bottomDot:(CALayer *)bottomDot
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:leftDot.position];
    moveAnimation.toValue   = [NSValue valueWithCGPoint:CGPointMake(self.center.x+sqrt(3)*self.diameter/2, self.center.y+self.diameter/2)];
    moveAnimation.duration  = duration;
    leftDot.position        = [moveAnimation.toValue CGPointValue];
    [leftDot addAnimation:moveAnimation forKey:@"move"];
    
    
    UIBezierPath *rightPath = [UIBezierPath bezierPath];
    CGPoint rightFromPoint  = rightDot.position;
    CGPoint rightToPoint    = CGPointMake(self.center.x, self.center.y-self.diameter);
    [rightPath moveToPoint:rightFromPoint];
    [rightPath addQuadCurveToPoint:rightToPoint controlPoint:CGPointMake(self.center.x+self.diameter, self.center.y-sqrt(3)*self.diameter)];
    CAKeyframeAnimation *leftMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    leftMoveAnimation.path     = rightPath.CGPath;
    leftMoveAnimation.fillMode = kCAFillModeForwards;
    leftMoveAnimation.duration = duration;
    rightDot.position          = rightToPoint;
    [rightDot addAnimation:leftMoveAnimation forKey:@"move"];
    
    
    UIBezierPath *bottomPath = [UIBezierPath bezierPath];
    CGPoint bottomFromPoint  = bottomDot.position;
    CGPoint bottomToPoint    = CGPointMake(self.center.x-sqrt(3)*self.diameter/2, self.center.y+self.diameter/2);
    [bottomPath moveToPoint:bottomFromPoint];
    [bottomPath addQuadCurveToPoint:bottomToPoint controlPoint:CGPointMake(self.center.x-self.diameter, self.center.y+sqrt(3)*self.diameter)];
    CAKeyframeAnimation *bottomMoveAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    bottomMoveAnimation.path     = bottomPath.CGPath;
    bottomMoveAnimation.fillMode = kCAFillModeForwards;
    bottomMoveAnimation.duration = duration;
    bottomDot.position           = bottomToPoint;
    [bottomDot addAnimation:bottomMoveAnimation forKey:@"move"];
}


- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"------%p被回收了-------", self);
#endif
}

@end
