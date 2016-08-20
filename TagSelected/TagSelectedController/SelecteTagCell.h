//
//  SelecteTagCell.h
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const SelecteTagCellIdentifier = @"SelecteTagCellIdentifier";
@interface SelecteTagCell : UITableViewCell
@property (assign,nonatomic) BOOL selectedFlag;
@property (strong,nonatomic) IBOutlet UIImageView *selectedIcon;
@property (strong,nonatomic) IBOutlet UILabel *titleLabels;
@property (strong,nonatomic) NSMutableArray *selectionIndicatorColorArray;
@property (assign,nonatomic) NSInteger currentSelectedFlag;
@end
