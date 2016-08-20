//
//  FieldTableController.h
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "BaseViewController.h"
typedef id (^OnSelectBlock)(id item,NSInteger index);
typedef NSString* (^TitleBlock)(id item);
typedef BOOL (^FlagBlock)(id item);

@interface FieldTableController : BaseViewController

@property (nonatomic, strong)  UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic, assign) NSInteger itemIndex;
@property (nonatomic,copy) OnSelectBlock onSelectBlock;
@property (nonatomic,copy) FlagBlock flagBlock;
@property (nonatomic,copy) TitleBlock titleBlock;

-(void)setOnSelectBlock:(OnSelectBlock)onSelectBlock;
-(void)setTitleBlock:(TitleBlock)titleBlock;
-(void)setFlagBlock:(FlagBlock)flagBlock;
- (void)refreshWithData:(NSArray *)data atIndex:(NSInteger)index;
@end
