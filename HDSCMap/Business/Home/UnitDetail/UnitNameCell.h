//
//  UnitNameCell.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnitDetailModel.h"

@interface UnitNameCell : UITableViewCell

+ (UnitNameCell *)cellWithTableView:(UITableView *)tableView model:(UnitDetailModel *)model;

@end
