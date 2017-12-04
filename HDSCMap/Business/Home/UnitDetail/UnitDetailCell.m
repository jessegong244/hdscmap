//
//  UnitDetailCell.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitDetailCell.h"

@interface UnitDetailCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end

@implementation UnitDetailCell

+ (UnitDetailCell *)cellWithTableView:(UITableView *)tableView model:(UnitDetailModel *)model index:(NSIndexPath *)path{
    UnitDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (path.row == 1) {
        cell.titleLabel.text = @"地址：";
        cell.descLabel.text = model.address;
    }
    if (path.row == 2) {
        cell.titleLabel.text = @"电话：";
        cell.descLabel.text = model.phone;
    }
    if (path.row == 3) {
        cell.titleLabel.text = @"描述：";
        cell.descLabel.text = model.descriptions;
    }
    if (path.row == 4) {
        cell.titleLabel.text = @"更新时间：";
        cell.descLabel.text = model.updateTime;
    }
    if (path.row == 5) {
        cell.titleLabel.text = @"经纬度：";
        cell.descLabel.text = [NSString stringWithFormat:@"E %@   N %@",model.longitude,model.latitude];
    }
    
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
