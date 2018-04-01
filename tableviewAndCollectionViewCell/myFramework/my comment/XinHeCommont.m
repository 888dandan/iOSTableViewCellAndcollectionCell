//
//  XinHeCommont.m
//  xinhehui
//
//  Created by 曹轩 on 2017/11/13.
//  Copyright © 2017年 刘柯. All rights reserved.
//

#import "XinHeCommont.h"

@implementation XinHeCommont


// 手机号码选择
+ (BOOL)validateMobile:(NSString *)mobile;
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11){
        return NO;
    }else{
        NSString *CM_NUM = @"^((1))\\d{10}|(1705)\\d{7}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        
        if (isMatch1) {
            return YES;
        }else{
            return NO;
        }
    }
}


//图片的缩放处理   改变图片的大小
+ (UIImage*)OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    //size 为CGSize类型，即你所需要的图片尺寸
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //返回的就是已经改变的图片
    return scaledImage;
}

// 制作图片
+(UIImage *)GetImageWithColor:(UIColor *)color andHeight:(CGFloat)height {
    CGRect r = CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


// 获取当前时间
+(NSString*)CXGetCurrentTimeAndDateFormat:(NSString*)CXDataforMat{
    //获取当前时间  这个时间是格林时间
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    // 获取  年，月，日，时，分，秒，
    //[formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
     [formatter setDateFormat:CXDataforMat];

    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}

// 导航栏按钮 仅使用 文字的
// 调用此方法只需  self.navigationItem.rightBarButtonItem=item;
+(UIBarButtonItem*)rightnavgationitemTitle:(NSString*)title taget:(id)taget sel:(SEL)sel{
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 35, 35);
    [rightBtn setTitle:title forState:UIControlStateNormal];
    [rightBtn addTarget:taget action:sel forControlEvents:UIControlEventTouchUpInside];
    rightBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    return item;
}

// 导航栏按钮有图片的
// 调用此方法只需  self.navigationItem.rightBarButtonItem=item;
+(UIBarButtonItem*)avgationitemImageName:(NSString*)imageName taget:(id)taget sel:(SEL)sel{
    
    UIButton *rightBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame=CGRectMake(0, 0, 25, 25);
    UIImage *image=[UIImage imageNamed:imageName];
    UIImage *image2=[self OriginImage:image scaleToSize: CGSizeMake(20, 20)];
    
    [rightBtn setBackgroundImage:image2 forState:UIControlStateNormal];
    [rightBtn addTarget:taget action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    return item;
}

// 字典转 json
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
//json格式字符串转字典：
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

//判断字符串是否为nil
+ (BOOL) isBlankString:(NSString *)string {
    
        if (string == nil || string == NULL) {
        
                return YES;
        
             }
    
         if ([string isKindOfClass:[NSNull class]]) {
        
                return YES;
        
            }
    
         if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
    
                 return YES;
        
            }
    
        return NO;
    
     }

//#pragma 正则匹配用户身份证号15或18位
+ (BOOL)validateIdentityCard:(NSString *)identityCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:identityCard];
    
    return isMatch;
}


+(UIButton*)addSureButton{
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    // btn.frame=CGRectMake(0, self.view.frame.size.height-50, self.view.frame.size.width, 50);
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:2/255.0 green:160/255.0 blue:234/255.0 alpha:1]];
   // [btn addTarget:self action:@selector(gotoCoast:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_appointmentNewBtn];
//    [self.view insertSubview:_appointmentNewBtn aboveSubview:self.tableView];
    return btn;

}

//方法3代码
- (CGFloat)cellHeightstr:(NSString*)str {
    // 文字的最大尺寸(设置内容label的最大size，这样才可以计算label的实际高度，需要设置最大宽度，但是最大高度不需要设置，只需要设置为最大浮点值即可)，53为内容label到cell左边的距离
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 53, MAXFLOAT);
    
    // 计算内容label的高度
    CGFloat textH = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil].size.height;
    /*
     昵称label和cell的顶部为0
     17为昵称label的高度
     8.5为昵称label和内容label的间距
     textH为内容label的高度
     304为内容image的高度
     */
    
    return textH+5;
}




@end
