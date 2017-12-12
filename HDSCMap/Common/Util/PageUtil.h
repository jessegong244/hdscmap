//
//  PageUtil.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/6.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageUtil : NSObject

/*
 * 获取当前navigationController
 * */
+ (UINavigationController *)getCurrentNavigationController;

/*
 * 获取当前(最上层）ViewController
 * */
+ (UIViewController *)getCurrentViewController;

/**
 获取当前tabBarController
 */
+ (UITabBarController *)getCurrentTabBarController;

@end
