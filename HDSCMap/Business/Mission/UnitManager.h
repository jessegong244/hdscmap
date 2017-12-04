//
//  UnitManager.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitManager : NSObject

+ (void)getUnitListByFatherId:(NSInteger)fatherId resultBlock:(void (^)(NSArray *unitArr,NSError *error))Block;

@end
