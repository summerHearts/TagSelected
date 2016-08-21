//
//  SelecteTagCell.m
//  TagSelected
//
//  Created by Kenvin on 16/8/20.
//  Copyright © 2016年 上海方创金融股份服务有限公司. All rights reserved.
//
#import "SelecteTagCell.h"
#import "UIColor+Hex.h"
#import "UIView+Extension.h"
@implementation SelecteTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedFlag = NO;    
    self.titleLabels.height = 22;
    [self.contentView addSubview: self.titleLabels];
    self.selectionIndicatorColorArray = [NSMutableArray arrayWithObjects:
                                                     [UIColor colorWithHexString:@"00bb31"],
                                                     [UIColor colorWithHexString:@"00b5e2"],
                                                     [UIColor colorWithHexString:@"cb333b"],
                                                     [UIColor colorWithHexString:@"333f48"],
                                                     [UIColor colorWithHexString:@"5b6770"],
                                                     nil];

}

- (void)setSelectedFlag:(BOOL)selectedFlag
{
    _selectedFlag = selectedFlag;
    if (_selectedFlag) {
        self.titleLabels.textColor = [UIColor blackColor];
    }else{
        self.titleLabels.textColor = [UIColor colorWithHexString:@"7c878e"];
    }
    [self setNeedsLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    if (self.selectedFlag){
        UIImage *image=  [UIImage imageNamed:@"selected"];
        [self.selectedIcon setImage:[image imageWithTintColor:[self.selectionIndicatorColorArray objectAtIndex:self.currentSelectedFlag]]];
    }else{
        [self.selectedIcon setImage:nil];
    }
    
    [UIView commitAnimations];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
