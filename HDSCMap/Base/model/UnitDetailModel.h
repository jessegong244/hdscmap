//
//  UnitModel.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitDetailModel : NSObject

@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *descriptions;
@property (nonatomic,assign)NSInteger keyId;
@property (nonatomic,copy)NSString *image;
@property (nonatomic,copy)NSString *latitude;
@property (nonatomic,copy)NSString *longitude;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *number;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,assign)NSInteger unitId;
@property (nonatomic,copy)NSString *updateTime;

+ (UnitDetailModel *)modelWithDictionary:(NSDictionary *)dic;

@end
