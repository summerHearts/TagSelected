//
//  BaseViewController.h
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  显示Loading
 */
- (void)showLoadingWithClear:(BOOL)isClear;

/**
 *  隐藏Loading
 */
- (void)hideLoading;


/**
 *  加载默认数据
 */
- (void)loadDefaultDataSource;

/**
 *  加载数据源
 */
- (void)loadDataSource;

/**
 *  加载UI样式
 */
- (void)initViews;

/**
 *  加载组件
 */
- (void)initComponents;

/**
 *  设置CGRectZero从导航栏下开始计算
 */
- (void)configuraEdgesForExtendedLayout;

/**
 *  将要pop时候
 */
- (void)willPopViewController;
@end
