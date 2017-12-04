//
//  UnitModel.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//


#import "BaseModel.h"

@interface UnitModel : BaseModel

@property (nonatomic,assign)NSInteger unitId;
@property (nonatomic,assign)NSInteger fatherId;
@property (nonatomic,assign)NSInteger level;
@property (nonatomic,copy)NSString *name;

@end
