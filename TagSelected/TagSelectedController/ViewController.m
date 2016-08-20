//
//  ViewController.m
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Hex.h"
#import "Masonry.h"
#import "UIImage+Color.h"
#import "HMSegmentedControl.h"
#import "FieldTableController.h"
#define IPHONE_SCREEN_WIDTH         ([[UIScreen mainScreen] bounds].size.width)
#define IPHONE_SCREEN_HEIGHT        ([[UIScreen mainScreen] bounds].size.height)
@interface ViewController ()

@property (nonatomic,strong) HMSegmentedControl *hmSegmentedControl;

@property (nonatomic,strong) FieldTableController    *fieldTableController;

@property (nonatomic,strong) NSMutableArray *dataList;

@property (assign,nonatomic) BOOL isClear;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataSource];
}

- (void)setSegmentTag:(NSInteger)segmentTag{
    _segmentTag=segmentTag;
    [self.hmSegmentedControl setSelectedSegmentIndex:_segmentTag animated:YES];
}
- (void)initViews{
    [super initViews];
    [self initNavigationBar];
    [self initScrollView];
    [self initHMSelectControl];
}

- (void)initComponents{
    [super initComponents];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    // 设置导航默认标题的颜色及字体大小
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

    [self.navigationController.navigationBar setTitleTextAttributes:@{
                                                                      NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"00bb31"];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage createImageWithColor:[UIColor colorWithHexString:@"00bb31"]] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 5, 10, 5)] forBarMetrics:UIBarMetricsDefault];
}
- (void)initHMSelectControl{
    NSArray *titleArr = @[@"领域",@"轮次",@"阶段",@"币种",@"地区"];
    self.hmSegmentedControl = [[HMSegmentedControl alloc]initWithSectionTitles:titleArr];
    self.hmSegmentedControl.frame = CGRectMake(0,64,([[UIScreen mainScreen] bounds].size.width), 44);
    self.hmSegmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.hmSegmentedControl.selectionIndicatorColor = [UIColor colorWithHexString:@"00bb31"];
    self.hmSegmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    [self.hmSegmentedControl setSelectedSegmentIndex:0 animated:YES];
    self.hmSegmentedControl.selectionIndicatorHeight = 2.0f;
    self.hmSegmentedControl.borderColor = [UIColor lightGrayColor];
    self.hmSegmentedControl.borderType =  HMSegmentedControlBorderTypeBottom;
    self.hmSegmentedControl.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                                                    NSForegroundColorAttributeName : [UIColor blackColor]};
    self.hmSegmentedControl.selectedTitleTextAttributes = @{ NSFontAttributeName : [UIFont systemFontOfSize:14.0f],
                                                             NSForegroundColorAttributeName : [UIColor blackColor]};
    [self.view addSubview:self.hmSegmentedControl];
    typeof(self) __weak weakSelf = self;
    
    self.hmSegmentedControl.indexChangeBlock = ^(NSInteger i){
        typeof(self) __strong strongSelf = weakSelf;

        weakSelf.segmentTag=weakSelf.hmSegmentedControl.selectedSegmentIndex;
        [strongSelf loadDataSource];
    };
}

- (void)initScrollView{
    self.scrollView =  [[UIScrollView alloc]init];
    self.scrollView.scrollEnabled=NO;
    self.scrollView.frame=CGRectMake(0, 64+40, IPHONE_SCREEN_WIDTH, IPHONE_SCREEN_HEIGHT-40-64);
    self.scrollView.pagingEnabled=YES;
    self.scrollView.showsHorizontalScrollIndicator=NO;
    [self.scrollView setContentSize:CGSizeMake(IPHONE_SCREEN_WIDTH*4, 0)];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(64+44);
    }];
}
- (void)initNavigationBar{
    UIBarButtonItem * rightBarItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishSelected:)];
    UIBarButtonItem * leftBarItem = [[UIBarButtonItem alloc]initWithTitle:@"重置" style:UIBarButtonItemStylePlain target:self action:@selector(clearSelected:)];
    self.navigationItem.leftBarButtonItem =leftBarItem;
    self.navigationItem.rightBarButtonItem = rightBarItem;
    
}


- (void)loadDefaultDataSource{
    [super loadDefaultDataSource];
    [self loadFilterData];

}
- (void)loadDataSource{
    [super loadDataSource];
    [self loadOrderDataWithIndex:_segmentTag];
}

- (void)loadFilterData{
    self.dataList = [NSMutableArray array];
    NSArray *customArray = @[@{@"id":@(0),@"name":@"所有领域",@"flag":[NSNumber numberWithBool:YES]},
                             @{@"id":@(1),@"name":@"TMT",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(2),@"name":@"大数据",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(3),@"name":@"企业服务",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(4),@"name":@"医疗健康",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(5),@"name":@"大消费",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(6),@"name":@"高端制造",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(7),@"name":@"金融",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(8),@"name":@"文化产业",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(9),@"name":@"物流",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(10),@"name":@"环保节能",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(11),@"name":@"信息安全",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(12),@"name":@"其他",@"flag":[NSNumber numberWithBool:NO]}];
    
    
    NSArray *froundsArray = @[@{@"id":@(0),@"name":@"所有轮次",@"flag":[NSNumber numberWithBool:YES]}
                              ,@{@"id":@(1),@"name":@"天使轮",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(2),@"name":@"PRE-A轮",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(3),@"name":@"A轮",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(4),@"name":@"B轮",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(5),@"name":@"C轮",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(6),@"name":@"上市前",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(7),@"name":@"其它",@"flag":[NSNumber numberWithBool:NO]}];
    
    //所有阶段
    NSArray *statgesArray = @[@{@"id":@(0),@"name":@"所有阶段",@"flag":[NSNumber numberWithBool:YES]},
                              @{@"id":@(1),@"name":@"未上线",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(2),@"name":@"已上线",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(3),@"name":@"有数据",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(4),@"name":@"盈亏平衡",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(5),@"name":@"产生收入",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(6),@"name":@"百万利润",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(7),@"name":@"5百万利润",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(8),@"name":@"1千万以上利润",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(9),@"name":@"5千万利润",@"flag":[NSNumber numberWithBool:NO]},
                              @{@"id":@(10),@"name":@"准备上市",@"flag":[NSNumber numberWithBool:NO]}];
    //所有币
    NSArray *currencysArray = @[@{@"id":@(0),@"name":@"所有币种",@"flag":[NSNumber numberWithBool:YES]},
                                @{@"id":@(1),@"name":@"美金",@"flag":[NSNumber numberWithBool:NO]},
                                @{@"id":@(2),@"name":@"人民币",@"flag":[NSNumber numberWithBool:NO]}];
    //所有地区
    NSArray *citysArray =  @[@{@"id":@(0),@"name":@"所有地区",@"flag":[NSNumber numberWithBool:YES]},
                             @{@"id":@(1),@"name":@"上海",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(2),@"name":@"北京",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(3),@"name":@"广州",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(4),@"name":@"成都",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(5),@"name":@"杭州",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(6),@"name":@"深圳",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(7),@"name":@"南京",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(8),@"name":@"武汉",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(9),@"name":@"厦门",@"flag":[NSNumber numberWithBool:NO]},
                             @{@"id":@(10),@"name":@"其它",@"flag":[NSNumber numberWithBool:NO]}];
    
    [self.dataList addObject:customArray];
    [self.dataList addObject:froundsArray];
    [self.dataList addObject:statgesArray];
    [self.dataList addObject:currencysArray];
    [self.dataList addObject:citysArray];
}

- (void)finishSelected:(UIBarButtonItem *)barItem {
    NSMutableArray *tmpArray = [self.dataList objectAtIndex:self.fieldTableController.tableView.tag];
    if (tmpArray.count!=0&&tmpArray!=nil&&self.fieldTableController.items.count!=0) {
        [self.dataList replaceObjectAtIndex:self.fieldTableController.tableView.tag withObject:self.fieldTableController.items];
    }
    
    NSMutableArray *nameArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    for (int i = 0; i< self.dataList.count; i++) {
        NSMutableString *tmpNameStr =[[NSMutableString alloc]initWithString:@""];
        NSArray *array =  [self.dataList objectAtIndex:i];
        for ( int j = 1; j< array.count; j++) {
            NSDictionary *dict = [array objectAtIndex:j];
            if ([[dict objectForKey:@"flag"] boolValue]) {
                [tmpNameStr appendString:[NSString stringWithFormat:@"%@,",[dict objectForKey:@"name"]]];
                [nameArray replaceObjectAtIndex:i withObject:tmpNameStr];
            }
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clearSelected:(UIBarButtonItem *)barItem {
    [self loadFilterData];
    self.isClear = YES;
    
    [self loadOrderDataWithIndex:_segmentTag];
}
- (void)loadOrderDataWithIndex:(NSInteger)index{
    if (self.fieldTableController==nil) {
        self.fieldTableController=[[FieldTableController alloc]init];
        [self addChildViewController:self.fieldTableController];
        self.fieldTableController.view.frame=CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        [self.scrollView addSubview:self.fieldTableController.view];
        self.fieldTableController.tableView.tag = 0;
    }else{
        if (!self.isClear) {
            NSMutableArray *tmpArray = [self.dataList objectAtIndex:self.fieldTableController.tableView.tag];
            if (tmpArray.count!=0&&tmpArray!=nil&&self.fieldTableController.items.count!=0) {
                [self.dataList replaceObjectAtIndex:self.fieldTableController.tableView.tag withObject:self.fieldTableController.items];
            }
        }else{
            self.isClear = NO;
        }
       
    }

    self.fieldTableController.items  = [self.dataList objectAtIndex:index];

    [ self.fieldTableController setTitleBlock:^NSString *(id item) {
        return [item objectForKey:@"name"];
    }];
    
    [ self.fieldTableController setFlagBlock:^BOOL (id item) {
        return [[item objectForKey:@"flag"] boolValue];
    }];

    [ self.fieldTableController setOnSelectBlock:^id (id item, NSInteger index) {
        
        NSDictionary *modify = @{@"name":[item objectForKey:@"name"],
                                 @"flag":[NSNumber numberWithBool:![[item objectForKey:@"flag"] boolValue]]};
        return modify;
    }];
    self.fieldTableController.tableView.tag = index;
}

@end
