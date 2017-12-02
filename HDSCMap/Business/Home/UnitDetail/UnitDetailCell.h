//
//  UnitDetailCell.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnitModel.h"

@interface UnitDetailCell : UITableViewCell

+ (UnitDetailCell *)cellWithTableView:(UITableView *)tableView model:(UnitModel *)model index:(NSIndexPath *)path;

@end
