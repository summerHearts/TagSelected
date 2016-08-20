//
//  UIColor+Hex.h
//  FangChuang
//
//  Created by 佐毅 on 16/3/19.
//  Copyright © 2016年 上海方创资本科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIColor (Hex)
//十六进制颜色
+ (UIColor *) colorWithHexString: (NSString *)color;

//颜色转图片
+ (UIImage *)toImage:(UIColor *)color;

//颜色转图片
- (UIImage *)toImage;

@end
