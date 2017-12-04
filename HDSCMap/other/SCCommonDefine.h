//
//  SCCommonDefine.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#ifndef SCCommonDefine_h
#define SCCommonDefine_h

// MARK: - NSLog

#ifdef NSLog
#undef NSLog
#endif

#ifdef DEBUG
#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d> %s\n",                                           \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "\n");                                                      \
} while (0)
#else
#define NSLog(format, ...)
#endif

// MARK: - 资源加载

//#define UPImage(imageName) [UPFileLoader loadImage:(imageName) pattern:UPFilePatternPNG]

#define SCScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define SCScreenHeight   [[UIScreen mainScreen] bounds].size.height

//#define UPFullScreenViewHeight   (UPScreenHeight - 64 - 49) //满屏View的高度

//判断iPhoneX
#define isIphoneX (UIScreen.mainScreen.bounds.size.width * UIScreen.mainScreen.scale == 1125 && UIScreen.mainScreen.bounds.size.height * UIScreen.mainScreen.scale == 2436)

// cell 分割线高度
#define SCSplitLineHeight 0.5


#define Device_iPhone4_4s   (SCScreenWidth == 320.f && SCScreenHeight == 480.f ? YES : NO)
#define Device_iPhone5_5s   (SCScreenWidth == 320.f && SCScreenHeight == 568.f ? YES : NO)

// MARK: - WeakSelf

#ifndef WeakSelf
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#endif

// MARK: - 系统相关

#ifndef IOS7_OR_LATER
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 )
#endif

#ifndef IOS8_OR_LATER
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 )
#endif

#ifndef IOS9_OR_LATER
#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 )
#endif

#ifndef IOS10_OR_LATER
#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#endif

#ifndef IOS11_OR_LATER
#define IOS11_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)
#endif


// 通知中心
#define SCNotificationCenter [NSNotificationCenter defaultCenter]

// 窗口
#define SCKeyWindow [[UIApplication sharedApplication].delegate window]

// MARK: - 判断合法

// 判断一个数组是否合法
#define IsValidateArr(arr) ((arr && [arr isKindOfClass:[NSArray class]] && [arr count] > 0))


// 判断一个字典是否合法
#define IsValidateDic(dic) (nil != dic && [dic isKindOfClass:[NSDictionary class]] && [dic count] > 0)

// 判断一个NSString是否合法
#define IsValidateString(str) ((nil != str) && ([str isKindOfClass:[NSString class]]) && ([str length] > 0) && (![str isEqualToString:@"(null)"]) && ((NSNull *) str != [NSNull null]))

// MARK: -

// 随机色
#define UPRandomColor [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0]
// 通过颜色值返回颜色
#define UPHexStringColor(string) [UIColor colorWithHexString:string]

// #111111 不同alpha的颜色值
#define UPBlackAlphaColor(alphaValue) [UIColor colorWithRed:17.f/255.f green:17.f/255.f blue:17.f/255.f alpha:(alphaValue)]

// #FFFFFF 不同alpha的颜色值
#define UPWhiteAlphaColor(alphaValue) [UIColor colorWithRed:255.f/255.f green:255.f/255.f blue:255.f/255.f alpha:(alphaValue)]

// navigationBar，toolBar的tint颜色
#define UPBarYellowColor [UIColor colorWithHexString:@"#EF7F21"]
// 背景颜色
#define UPBgGreyColor [UIColor colorWithHexString:@"#F4F4F4"]
// 分割线颜色
#define UPSplitLineGreyColor [UIColor colorWithHexString:@"#EBECED"]

// 超链接颜色
#define UPHrefBlueColor [UIColor colorWithHexString:@"#5871A6"]
// 时间日期颜色
#define UPTimeGreyColor [UIColor colorWithHexString:@"#B2B2B2"]
// 错误警告颜色
#define UPWarningRedColor [UIColor colorWithHexString:@"#E73C39"]

// 主要内容标题颜色
#define UPPrimaryBlackColor [UIColor colorWithHexString:@"#000000"]
// 大段说明性内容颜色
#define UPJuniorGreyColor [UIColor colorWithHexString:@"#333333"]
// 说明性内容颜色
#define UPInfoGreyColor [UIColor colorWithHexString:@"#808080"]

// 选中和非选中颜色
#define UPSelectEnableColor [UIColor colorWithHexString:@"#EF7F21"]
#define UPSelectDisableColor [UIColor colorWithHexString:@"#B2B2B2"]

// 涨跌平颜色
#define UPStockRiseColor [UIColor colorWithHexString:@"#E94C2D"]
#define UPStockFallColor [UIColor colorWithHexString:@"#38AB48"]
#define UPStockEqualColor [UIColor colorWithHexString:@"#ACADAF"]

// 停牌颜色
#define UPStockSuspendColor [UIColor colorWithHexString:@"#ACADAF"]

//amap key
#define AMAP_KEY    @"467496928a6153e0e0b52ca4beac87b2"

//interface url
#define INTERFACE_ADDRESS   @"192.168.2.107:8080"

#endif /* SCCommonDefine_h */
