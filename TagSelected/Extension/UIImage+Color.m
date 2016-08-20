//
//  UIImage+Color.m
//  FangChuang
//
//  Created by 佐毅 on 16/3/19.
//  Copyright © 2016年 上海方创资本科技有限公司. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

+(UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
