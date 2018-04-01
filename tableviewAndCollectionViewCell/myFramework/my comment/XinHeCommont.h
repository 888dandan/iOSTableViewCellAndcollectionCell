//
//  XinHeCommont.h
//  xinhehui
//
//  Created by 曹轩 on 2017/11/13.
//  Copyright © 2017年 刘柯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface XinHeCommont : NSObject

//手机号码检测
+ (BOOL)validateMobile:(NSString *)mobileNum;


//缩放图片 改变图片的大小
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
// 制作图片
+(UIImage *)GetImageWithColor:(UIColor *)color andHeight:(CGFloat)height;
// 获取当前时间

+(NSString*)CXGetCurrentTimeAndDateFormat:(NSString*)CXDataforMat;;


//navgationItem 仅适用于有文字
+(UIBarButtonItem*)rightnavgationitemTitle:(NSString*)title taget:(id)taget sel:(SEL)sel;
// 导航栏按钮有图片的
+(UIBarButtonItem*)avgationitemImageName:(NSString*)imageName taget:(id)taget sel:(SEL)sel;



// 字典转json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

//json格式字符串转字典：
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

//判断字符串是否为nil
+ (BOOL) isBlankString:(NSString *)string;

// 身份证
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

@end
