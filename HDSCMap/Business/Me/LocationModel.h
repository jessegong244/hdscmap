//
//  LocationModel.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "BaseModel.h"

@interface LocationModel : BaseModel

@property (nonatomic,assign)    NSInteger locId;
@property (nonatomic,copy)      NSString *locationStr;
@property (nonatomic,copy)      NSString *imageUrl;

@end
