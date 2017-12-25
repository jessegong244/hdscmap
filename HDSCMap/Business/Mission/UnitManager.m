//
//  UnitManager.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitManager.h"
#import "UnitModel.h"
#import "UnitDetailModel.h"

@implementation UnitManager

+ (void)getUnitDetailListByFatherId:(NSInteger)fatherId resultBlock:(void (^)(NSMutableArray *, NSError *))Block{
    NSDictionary *param = @{@"fatherId":[NSNumber numberWithInteger:fatherId]};
    NSString *urlName = @"getUnitDetailList";
    
    [HttpRequestManager httpRequestGetWithUrl:urlName parameter:param success:^(id returnData) {
        
        NSMutableArray *arr = [UnitDetailModel modelsWithJsonArray:returnData];
        if (Block) {
            Block(arr,nil);
        }
    } failture:^(id returnData) {
        NSError *error = [NSError new];
        if (Block) {
            Block(nil,error);
        }
    }];
}

+ (void)getUnitListByFatherId:(NSInteger)fatherId resultBlock:(void (^)(NSArray *, NSError *))Block{
    
    NSDictionary *param = @{@"fatherId":[NSNumber numberWithInteger:fatherId]};
    NSString *urlName = @"listSonUnit";
    
    [HttpRequestManager httpRequestGetWithUrl:urlName parameter:param success:^(id returnData) {
        NSArray *arr = [UnitModel modelsWithJsonArray:returnData];
        if (Block) {
            Block(arr,nil);
        }
    } failture:^(id returnData) {
        NSError *error = [NSError new];
        if (Block) {
            Block(nil,error);
        }
    }];
}

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
                        resultBlock:(void (^)(id, NSError *))Block{
    NSString *urlName = @"insertUnitAndDetail";
    NSDictionary *param = @{
                            @"name":[self encodeing:name],
                            @"address":[self encodeing:address],
                            @"description":[self encodeing:desc],
                            @"number":[self encodeing:num],
                            @"phone":[self encodeing:phone],
                            @"longitude":[NSNumber numberWithDouble:longitude],
                            @"latitude":[NSNumber numberWithDouble:latitude],
                            @"fatherId":[NSNumber numberWithInteger:fatherId],
                            @"level":[NSNumber numberWithInteger:level],
                            @"image":[self encodeing:image]
                            };
    [HttpRequestManager httpRequestPostWithUrl:urlName parameter:param success:^(id returnData) {
        if (Block) {
            Block(returnData,nil);
        }
    } failture:^(id returnData) {
        
        Block(nil,nil);
    }];
}

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
                        resultBlock:(void (^)(id, NSError *))Block{
    NSString *urlName = @"updateUnitDetail";
    NSDictionary *param = @{
                            @"name":[self encodeing:name],
                            @"address":[self encodeing:address],
                            @"description":[self encodeing:desc],
                            @"number":[self encodeing:num],
                            @"phone":[self encodeing:phone],
                            @"longitude":[NSNumber numberWithDouble:longitude],
                            @"latitude":[NSNumber numberWithDouble:latitude],
                            @"fatherId":[NSNumber numberWithInteger:fatherId],
                            @"level":[NSNumber numberWithInteger:level],
                            @"id":[NSNumber numberWithInteger:Id],
                            @"unitId":[NSNumber numberWithInteger:unitId],
                            @"image":[self encodeing:image]
                            };
    [HttpRequestManager httpRequestPostWithUrl:urlName parameter:param success:^(id returnData) {
        if (Block) {
            Block(returnData,nil);
        }
    } failture:^(id returnData) {
        
        Block(nil,nil);
    }];
}

+ (NSString *)encodeing:(NSString *)str{
    NSString *urlStr=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return urlStr;
}

@end
