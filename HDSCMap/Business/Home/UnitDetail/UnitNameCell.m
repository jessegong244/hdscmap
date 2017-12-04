//
//  UnitNameCell.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitNameCell.h"
@interface UnitNameCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation UnitNameCell

+ (UnitNameCell *)cellWithTableView:(UITableView *)tableView model:(UnitDetailModel *)model{
    
    UnitNameCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.nameLabel.text = model.name;
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
