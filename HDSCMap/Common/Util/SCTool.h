//
//  SCTool.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationModel.h"
@class YSMapAnnotation;

@interface SCTool : NSObject

+ (NSString *)stringByAppendingLocArray:(NSArray *)arr;

+ (NSArray<YSMapAnnotation *> *)coordinateArrWithString:(NSString *)string;

+ (NSArray<YSMapAnnotation *> *)coordinateArrWithLocation:(LocationModel *)model;

+ (NSString *)saveImageToDocument:(UIImage *)image;

+ (UIImage *)getDocumentImage:(NSString *)imagePath;

@end
