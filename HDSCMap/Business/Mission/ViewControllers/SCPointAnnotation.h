//
//  SCPointAnnotation.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/19.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "UnitDetailModel.h"

@interface SCPointAnnotation : MAPointAnnotation

@property (nonatomic,strong) UnitDetailModel *model;

@end
