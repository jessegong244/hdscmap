//
//  UnitModel.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitModel.h"

@implementation UnitModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dic{
    if (!dic) {
        return nil;
    }
    UnitModel *model = [UnitModel new];
    model.unitId = [dic[@"unitId"] integerValue];
    model.fatherId = [dic[@"fatherId"] integerValue];
    model.level = [dic[@"level"] integerValue];
    model.name = dic[@"name"];
    return model;
}

@end
