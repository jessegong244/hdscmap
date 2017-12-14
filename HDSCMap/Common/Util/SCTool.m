//
//  SCTool.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "SCTool.h"
#import "YSMapAnnotation.h"

@implementation SCTool

+ (NSString *)stringByAppendingLocArray:(NSArray *)arr{
    
    NSString *dataString = @"";
    for (int i = 0; i < arr.count; i++) {
        
        YSMapAnnotation *annotation = arr[i];
        NSString *longitude = [NSString stringWithFormat:@"%f",annotation.coordinate.longitude];
        NSString *latitude = [NSString stringWithFormat:@"%f",annotation.coordinate.latitude];
        NSString *locString = @"";
        if (i == 0) {
            locString = [NSString stringWithFormat:@"%@|%@",latitude,longitude];
        }else{
            locString = [NSString stringWithFormat:@",%@|%@",latitude,longitude];
        }
        dataString = [dataString stringByAppendingString:locString];
    }
    return dataString;
}

+ (NSArray<YSMapAnnotation *> *)coordinateArrWithString:(NSString *)string{
    
    NSMutableArray *annoArr = [NSMutableArray new];
    NSArray *itemArr = [string componentsSeparatedByString:@","];
    for (NSString *tmp in itemArr) {
        
        NSArray *location = [tmp componentsSeparatedByString:@"|"];
        NSString *latittudeStr = location.firstObject;
        NSString *longtitudeStr = location.lastObject;
        double latitude = latittudeStr.doubleValue;
        double longtitude = longtitudeStr.doubleValue;
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longtitude);
        YSMapAnnotation *annotation = [[YSMapAnnotation alloc] initWithCoordinate:coordinate];
        [annoArr addObject:annotation];
    }
    return annoArr;
}

+ (NSArray<YSMapAnnotation *> *)coordinateArrWithLocation:(LocationModel *)model{
    return [self coordinateArrWithString:model.locationStr];
}


@end
