//
//  UIImage+Tint.h
//  Tool
//
//  Created by Kenvin on 16/8/19.
//  Copyright © 2016年 上海方创资本科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tint)
- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
