//
//  PageUtil.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/6.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "PageUtil.h"

@implementation PageUtil

+ (UIViewController *)getCurrentViewController {
    UINavigationController *navigationController = [self getCurrentNavigationController];
    NSArray *viewControllers = navigationController.viewControllers;
    if (viewControllers.count) {
        return [viewControllers lastObject];
        
    }
    return nil;
}

+ (UINavigationController *)getCurrentNavigationController {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    id rootViewController = keyWindow.rootViewController;
    if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return rootViewController;
        
    }
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = keyWindow.rootViewController;
        UINavigationController *navigationController = tabBarController.selectedViewController;
        return navigationController;
        
    }
    return nil;
}

+ (UITabBarController *)getCurrentTabBarController {
    NSArray *windows = [UIApplication sharedApplication].windows;
    __block UIWindow *keyWindow = nil;
    [windows enumerateObjectsUsingBlock:^(UIWindow *window, NSUInteger idx, BOOL *stop) {
        if (window.tag == 10234) {
            *stop = YES;
            keyWindow = window;
        }
    }];
    if ([keyWindow.rootViewController isKindOfClass:[UITabBarController class]]) {
        return keyWindow.rootViewController;
    }
    return nil;
}

@end
