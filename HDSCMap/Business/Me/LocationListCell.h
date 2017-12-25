//
//  LocationListCell.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

@interface LocationListCell : UITableViewCell

+ (LocationListCell *)cellWithTableView:(UITableView *)tableView model:(LocationModel *)model;

@end
