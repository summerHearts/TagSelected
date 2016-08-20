//
//  UIColor+Hex.m
//  FangChuang
//
//  Created by 佐毅 on 16/3/19.
//  Copyright © 2016年 上海方创资本科技有限公司. All rights reserved.
//

#import "UIColor+Hex.h"
#import <UIKit/UIKit.h>

@implementation  UIColor (Hex)

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    
    CGFloat alpha = 1.0f;
    if ([cString length] == 8) {
        //argb
        NSRange range;
        range.location = 0;
        range.length = 2;
        //alpha
        NSString *astr = [cString substringWithRange:range];
        unsigned int aa;
        [[NSScanner scannerWithString:astr] scanHexInt:&aa];
        alpha = (float)aa/255.0;

        cString = [cString substringFromIndex:2];
    }
    if ([cString length] != 6)
        return [UIColor clearColor];
    
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
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

+ (UIImage *)toImage:(UIColor *)color
{
    return [color toImage];
}

//颜色转图片
- (UIImage *)toImage
{
    CGRect rect = CGRectMake(0, 0, 10,10);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;

}
@end
