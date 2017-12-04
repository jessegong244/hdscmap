//
//  BaseModel.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

/*
 字典转模型
 
 @param dic dic
 @return model
 */
+ (instancetype)modelWithDictionary:(NSDictionary *)dic;

/*
 string转模型
 
 @param string up_formatString字符串
 @return 模型
 */
+ (instancetype)modelWithModelString:(NSString*)string;

/*
 * array 转模型
 * 将array里面的dic转模型 需要重写 modelWithDictionary
 * return array
 * */
+ (NSMutableArray *)modelsWithJsonArray:(NSArray <NSDictionary *>*)array;

/*
 唯一索引
 
 @return 唯一索引
 */
- (NSString *)uniqueQuery;

@end
