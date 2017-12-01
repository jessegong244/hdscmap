//
//  UIColor+rgb.m
//
//  Created by Jimmy on 16/11/9.
//  Copyright © 2016年 HT_Technology. All rights reserved.
//

#import "UIColor+rgb.h"
#import <UIKit/UIKit.h>

@implementation UIColor (rgb)

+ (UIColor*)colorWithHexString:(NSString*)stringToConvert{
    if([stringToConvert hasPrefix:@"#"])
    {
        stringToConvert = [stringToConvert substringFromIndex:1];
    }
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if(![scanner scanHexInt:&hexNum])
    {
        return nil;
    }
    if (stringToConvert.length > 6) {
        return[UIColor colorWithRGBAHex:hexNum];
    } else {
        return[UIColor colorWithRGBHex:hexNum];
    }
}

+ (UIColor*)colorWithRGBHex:(UInt32)hex{
    int r = (hex >>16) &0xFF;
    int g = (hex >>8) &0xFF;
    int b = (hex) &0xFF;
    return[UIColor colorWithRed:r /255.0f
                         green:g /255.0f
                          blue:b /255.0f
                         alpha:1.0f];
}

+ (UIColor*)colorWithRGBAHex:(UInt32)hex{
    int r = (hex >> 24) &0xFF;
    int g = (hex >> 16) &0xFF;
    int b = (hex >> 8) &0xFF;
    int a = (hex) &0xFF;
    return[UIColor colorWithRed:r /255.0f
                          green:g /255.0f
                           blue:b /255.0f
                          alpha:a /255.0f];
}

@end
