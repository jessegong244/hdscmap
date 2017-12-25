//
//  SCTool.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "SCTool.h"
#import "YSMapAnnotation.h"

#pragma IMAGE_PATH  @"/Documents/"

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

+ (NSString *)saveImageToDocument:(UIImage *)image{
    
    NSString *imageName = [self createImageName];
    
    NSString *imagePath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@",imageName]];
    NSString *projPath = [NSString stringWithFormat:@"/Documents/%@",imageName];
    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
    return projPath;
}

+ (UIImage *)getDocumentImage:(NSString *)imagePath{
    if (!imagePath) {
        return nil;
    }
    return [[UIImage alloc] initWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:imagePath]];
}

+ (NSString *)createImageName{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    return fileName;
}


@end
