//
//  LocationListCell.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "LocationListCell.h"

@implementation LocationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (LocationListCell *)cellWithTableView:(UITableView *)tableView{
    
    LocationListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (nil == cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
