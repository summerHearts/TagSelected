//
//  BaseScrollViewController.m
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "BaseScrollViewController.h"

@interface BaseScrollViewController ()

@end

@implementation BaseScrollViewController

#pragma mark - Life cycle

-(instancetype)init{
    self=[super init];
    if (self) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deallocRelease{
    _scrollView.delegate = nil;
    _scrollView = nil;
}

@end
