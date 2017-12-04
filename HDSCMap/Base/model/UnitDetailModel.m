//
//  UnitModel.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitDetailModel.h"

@implementation UnitDetailModel

+ (UnitDetailModel *)modelWithDictionary:(NSDictionary *)dic{
    
    UnitDetailModel *model = [[UnitDetailModel alloc] init];
    model.address = dic[@"address"];
    model.descriptions = dic[@"description"];
    model.keyId = ((NSString *)dic[@"id"]).integerValue;
    model.image = dic[@"image"];
    model.latitude = dic[@"latitude"];
    model.longitude = dic[@"longitude"];
    model.name = dic[@"name"];
    model.number = dic[@"number"];
    model.phone = dic[@"phone"];
    model.unitId = ((NSString *)dic[@"unitId"]).integerValue;
    model.updateTime = dic[@"updateTime"];
    return model;
}

@end
