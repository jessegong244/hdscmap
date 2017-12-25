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

+ (void)insertUnitAndDetailWithName:(NSString *)name
                            address:(NSString *)address
                        description:(NSString *)desc
                             number:(NSString *)num
                              phone:(NSString *)phone
                          longitude:(double)longitude
                           latitude:(double)latitude
                           fatherId:(NSInteger)fatherId
                              level:(NSInteger)level
                              image:(NSString *)image
                        resultBlock:(void (^)(id response,NSError *error))Block;

+ (void)updateUnitAndDetailWithName:(NSString *)name
                                 id:(NSInteger)Id
                             unitId:(NSInteger)unitId
                            address:(NSString *)address
                        description:(NSString *)desc
                             number:(NSString *)num
                              phone:(NSString *)phone
                          longitude:(double)longitude
                           latitude:(double)latitude
                           fatherId:(NSInteger)fatherId
                              level:(NSInteger)level
                              image:(NSString *)image
                        resultBlock:(void (^)(id response,NSError *error))Block;


+ (void)getUnitDetailListByFatherId:(NSInteger)fatherId resultBlock:(void (^)(NSMutableArray *unitArr,NSError *error))Block;

@end
