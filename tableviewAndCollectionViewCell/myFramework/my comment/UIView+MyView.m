//
//  UIView+MyView.m
//  CXApp
//
//  Created by Yunxin on 2016/11/17.
//  Copyright © 2016年 ftsafe. All rights reserved.
//

#import "UIView+MyView.h"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

/*
 Phone4做原型时，可以用320*480,
 iPhone5做原型时，可以用320*568,
 iPhone6做原型时，可以用375*667,
 iPhone6 Plus原型，可以用414x736,
 */

CGRect  CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    //屏幕适配比例
    float autoSizeScaleX;
    float autoSizeScaleY;
    
    
    // inphone  5  se
    if (ScreenHeight >480&&ScreenHeight<570) {
        
        autoSizeScaleX = ScreenWidth/320;
        autoSizeScaleY = ScreenHeight/568;
        
        
        
    }
    
    // inphone6
    else if (ScreenHeight>650&&ScreenHeight<670){
        
        autoSizeScaleX=ScreenWidth/375;
        
        autoSizeScaleY=ScreenHeight/568;
        
    
    }
    // inphone6splus  inphone7splus
    else if (ScreenHeight>720&&ScreenHeight<740){
        
        autoSizeScaleX=ScreenWidth/414;
        
        autoSizeScaleY=ScreenHeight/736;
 
        
        }
    
    //  inphone 4    
    else {
        
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    
    
    CGRect rect;
    rect.origin.x = x * autoSizeScaleX;
    rect.origin.y = y * autoSizeScaleY;
    rect.size.width = width * autoSizeScaleX;
    rect.size.height = height * autoSizeScaleY;
    
    return rect;
}

//表你妹的尺寸
CGRect CGRectMakeBiaoNiMei(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    
    CGRect rect;
    rect.origin.x = ScreenWidth/360*x;
    rect.origin.y = ScreenHeight/640*y;
    rect.size.width = ScreenWidth/360*width;
    rect.size.height = ScreenHeight/640*height;
    return rect;
    
}


@implementation UIView (MyView)

-(CGFloat)x{
    
    return self.frame.origin.x;
    
}
-(void)setX:(CGFloat)x{
    
    CGRect  rect=self.frame;
    
    rect.origin.x=x;
    
    self.frame=rect;
    
}

-(CGFloat)y{
    
    
    return self.frame.origin.y;
    
}

-(void)setY:(CGFloat)y{
    
    CGRect  rect=self.frame;
    
    rect.origin.y=y;
    self.frame=rect;
    
    
    
}
-(CGFloat)width{
    
    return self.frame.size.width;
}
-(void)setWidth:(CGFloat)width{
    
    CGRect  rect=self.frame;
    
    rect.size.width=width;
    
    self.frame=rect;
    
}


-(CGFloat)height{
    
    return self.frame.size.height;
}

-(void)setHeight:(CGFloat)height{
    
    
    CGRect rect=self.frame;
    
    rect.size.height=height;
    
    self.frame=rect;
}


-(CGFloat)centerX{
    
    return self.center.x;
}


-(void)setCenterX:(CGFloat)centerX{
    
    CGPoint  point=self.center;
    
    point.x=centerX;
    
    self.center=point;
    
    
}

-(CGFloat)centery{
    
    
    return self.center.y;
    
}

-(void)setCentery:(CGFloat)centery{
    
    CGPoint  point=self.center;
    point.y=centery;
    
    self.center=point;
    
}


-(CGSize)size{
    
    return self.frame.size;
}

-(void)setSize:(CGSize)size{
    
    CGRect rect=self.frame;
    
    rect.size=size;
    
    self.frame=rect;
    
}

 - (void)alignHorizontal
 {
         self.x = (self.superview.width - self.width) * 0.5;
     }

 - (void)alignVertical
 {
         self.y = (self.superview.height - self.height) *0.5;
     }

 - (void)setBorderWidth:(CGFloat)borderWidth
 {
    
        if (borderWidth < 0) {
                 return;
             }
         self.layer.borderWidth = borderWidth;
     }

 - (void)setBorderColor:(UIColor *)borderColor
 {
         self.layer.borderColor = borderColor.CGColor;
     }

 - (void)setCornerRadius:(CGFloat)cornerRadius
 {
         self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
}

 - (BOOL)isShowOnWindow
{
        //主窗口
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
         //相对于父控件转换之后的rect
         CGRect newRect = [keyWindow convertRect:self.frame fromView:self.superview];
         //主窗口的bounds
        CGRect winBounds = keyWindow.bounds;
        //判断两个坐标系是否有交汇的地方，返回bool值
        BOOL isIntersects =  CGRectIntersectsRect(newRect, winBounds);
         if (self.hidden != YES && self.alpha >0.01 && self.window == keyWindow && isIntersects) {
                return YES;
             }else{
                     return NO;
                 }
     }

 - (CGFloat)borderWidth
 {
         return self.borderWidth;
     }

 - (UIColor *)borderColor
 {
         return self.borderColor;
    
     }
 - (CGFloat)cornerRadius
 {
         return self.cornerRadius;
     }

// 判断view的控制器
 - (UIViewController *)parentController
{
        UIResponder *responder = [self nextResponder];
        while (responder) {
                 if ([responder isKindOfClass:[UIViewController class]]) {
                        return (UIViewController *)responder;
                    }
                responder = [responder nextResponder];
            }
        return nil;
     }

// 获取战顶控制器
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}


@end
