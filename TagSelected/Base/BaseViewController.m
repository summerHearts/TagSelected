//
//  BaseViewController.m
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

/**
 *  load背景页面
 */
@property (nonatomic, strong) UIView *loadBackgroundView;

/**
 *  通知
 */
@property (nonatomic, strong) NSMutableArray *notificationCenterObservers;


@end

@implementation BaseViewController

#pragma mark - Life cycle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //兼容iOS7
    self.automaticallyAdjustsScrollViewInsets=NO;
    // 设置导航默认标题的颜色及字体大小
    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self loadDefaultDataSource];
    [self initComponents];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    
}

#pragma mark - SubViews UI

- (void)initViews {
    self.view.backgroundColor=[UIColor whiteColor];
    // subClass
}

- (void)initComponents{
    // subClass
}

#pragma mark - Data Source

- (void)loadDefaultDataSource {
    // subClass
}

- (void)loadDataSource {
    // subClass
}

#pragma mark - Public Methods

- (void)configuraEdgesForExtendedLayout {
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)willPopViewController{
    // subClass
}

- (void)showLoadingWithClear:(BOOL)isClear{
    [self.view addSubview:self.loadBackgroundView];
    if (isClear) {
        _loadBackgroundView.backgroundColor=[UIColor clearColor];
    }else{
        _loadBackgroundView.backgroundColor=[UIColor whiteColor];
    }
}

- (void)hideLoading{
    [_loadBackgroundView removeFromSuperview];
}

@end
