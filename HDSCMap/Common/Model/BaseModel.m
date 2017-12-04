//
//  BaseModel.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
    return nil;
}

+ (instancetype)modelWithModelString:(NSString *)string {
//    id result = [string up_formatObject];
    if ([string isKindOfClass:[NSDictionary class]]) {
        return [self modelWithDictionary:string];
    }
    return nil;
}

+ (NSMutableArray *)modelsWithJsonArray:(NSArray <NSDictionary *> *)array {
    if (!array.count) {
        return nil;
    }
    NSMutableArray *mutableArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            id  model = [self modelWithDictionary:obj];
            if (model) {
                [mutableArray addObject:model];
            }
        }
    }];
    return mutableArray;
}

- (NSString *)uniqueQuery {
    return @"";
}

@end
