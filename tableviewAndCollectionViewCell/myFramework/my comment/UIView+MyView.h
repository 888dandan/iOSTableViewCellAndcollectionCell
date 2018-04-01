//
//  UIView+MyView.h
//  CXApp
//
//  Created by Yunxin on 2016/11/17.
//  Copyright © 2016年 ftsafe. All rights reserved.
//

#import <UIKit/UIKit.h>

CGRect CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

CGRect CGRectMakeBiaoNiMei(CGFloat x, CGFloat y, CGFloat width, CGFloat height);

CGRect CGRectMakeBiaoNiMei(CGFloat x, CGFloat y, CGFloat width, CGFloat height);


@interface UIView (MyView)

@property(nonatomic,assign)  CGFloat  x;
@property(nonatomic,assign)  CGFloat  y;
@property(nonatomic,assign)  CGFloat  width;
@property(nonatomic,assign)  CGFloat  height;
@property(nonatomic,assign)   CGSize  size;
@property(nonatomic,assign)  CGFloat  centerX;
@property(nonatomic,assign)  CGFloat  centery;

@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
/**
 18  *  水平居中
 19  */
 - (void)alignHorizontal;
 /**
    22  *  垂直居中
    23  */
 - (void)alignVertical;
/**
    26  *  判断是否显示在主窗口上面
    27  *
    28  *  @return 是否
    29  */
 - (BOOL)isShowOnWindow;
 - (UIViewController *)parentController;
- (UIViewController *)topViewController;


@end
