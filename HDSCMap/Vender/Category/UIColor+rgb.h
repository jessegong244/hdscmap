//
//  UIColor+rgb.h
//
//  Created by Jimmy on 16/11/9.
//  Copyright © 2016年 HT_Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (rgb)

+ (UIColor*)colorWithHexString:(NSString*)stringToConvert;

+ (UIColor*)colorWithRGBHex:(UInt32)hex;
+ (UIColor*)colorWithRGBAHex:(UInt32)hex;

@end
