//
//  UnitManager.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitManager.h"
#import "UnitModel.h"

@implementation UnitManager

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

@end
