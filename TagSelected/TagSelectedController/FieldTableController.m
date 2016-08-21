//
//  FieldTableController.m
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import "FieldTableController.h"
#import "UIColor+Hex.h"
#import "Masonry.h"
#import "SelecteTagCell.h"
@interface FieldTableController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FieldTableController

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - SubViews UI
- (void)initViews{
    //初始化TableView
    [self initTableView];
}

- (void)initTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerNib:[UINib nibWithNibName:@"SelecteTagCell" bundle:nil] forCellReuseIdentifier:SelecteTagCellIdentifier];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(0);
    }];
}

-(void)setItems:(NSMutableArray *)items{
    _items =[[NSMutableArray alloc]initWithArray:items] ;
    [self.tableView reloadData];
}
-(void)setOnSelectBlock:(OnSelectBlock)onSelectBlock{
    _onSelectBlock = [onSelectBlock copy];
}
-(void)setTitleBlock:(TitleBlock)titleBlock{
    _titleBlock = [titleBlock copy];
}
-(void)setFlagBlock:(FlagBlock)flagBlock{
    _flagBlock = [flagBlock copy];
    
}

- (void)refreshWithData:(NSArray *)data atIndex:(NSInteger)index {
    
    _items  = [NSMutableArray arrayWithArray:data];
    _itemIndex = self.tableView.tag;
    [_tableView reloadData];
}

#pragma mark - UITableView M
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 55;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelecteTagCell *cell =[tableView dequeueReusableCellWithIdentifier:SelecteTagCellIdentifier];
    
    cell.titleLabels.tintColor = [UIColor grayColor];
    cell.titleLabels.textColor = [UIColor blackColor];
    
    if (_titleBlock) {
        NSDictionary *dict = _items[indexPath.row];
        cell.titleLabels.text = _titleBlock(dict);
    }
    cell.currentSelectedFlag = self.tableView.tag;
    if (_flagBlock) {
        cell.selectedFlag = _flagBlock(_items[indexPath.row]);
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SelecteTagCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (_onSelectBlock) {
        NSDictionary *dict = self.items[indexPath.row];
        if (dict != nil) {
            self.items[indexPath.row] = _onSelectBlock(dict,indexPath.row);
            if (indexPath.row!=0) {
                NSMutableDictionary *dicts = [[NSMutableDictionary alloc]initWithDictionary:self.items[0]];
                [dicts  setObject:[NSNumber numberWithBool:YES] forKey:@"flag"];
                self.items[0] = _onSelectBlock(dicts,0);
            }else{
                for (int i = 1; i<self.items.count; i++) {
                    NSMutableDictionary *dicts = [[NSMutableDictionary alloc]initWithDictionary:self.items[i]];
                    [dicts  setObject:[NSNumber numberWithBool:YES] forKey:@"flag"];
                    self.items[i] = _onSelectBlock(dicts,i);
                }
            }
        }
    }
    cell.selectedFlag =!cell.selectedFlag;
    [tableView reloadData];
}
@end
