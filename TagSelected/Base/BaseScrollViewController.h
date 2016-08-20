//
//  BaseScrollViewController.h
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseScrollViewController : BaseViewController<UIScrollViewDelegate>

/**
 *  滑动控件
 */
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
