//
//  TownPointAnnotation.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/22.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "UnitDetailModel.h"

@interface TownPointAnnotation : MAPointAnnotation

@property (nonatomic,strong) UnitDetailModel *model;

@end
