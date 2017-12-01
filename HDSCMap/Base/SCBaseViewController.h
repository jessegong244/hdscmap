//
//  SCBaseViewController.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworkReachabilityManager.h>
#import "SCCommonDefine.h"

@interface SCBaseViewController : UIViewController

/*
 是否是第一次展现viewcontroller 默认 NO
 */
@property (nonatomic, assign) BOOL firstAppear;

/*
 * 是否监听网络状态变化 默认为NO
 * 设为YES，当网络状态
 * */
@property (nonatomic, assign) BOOL observeNetworkStatus;

/*
 * 是否隐藏navigationBar 默认NO 在viewWillappear之前设置
 * */
@property (nonatomic, assign) BOOL hideNavigationBar;

/*
 * 设置navigationBar颜色 默认主题色
 * */
@property (nonatomic, strong) UIColor *navigationBarColor;

/*
 是否监听键盘 默认NO
 */
@property (nonatomic, assign) BOOL observeKeyBoard;

/*
 显示内容的EdgeInsets
 */
@property (nonatomic, assign) UIEdgeInsets contentInset;

/*
 默认返回按钮
 */
@property (nonatomic, strong) UIBarButtonItem *popBarButtonItem;

- (void)popViewController;

- (void)keyboardChangeFrame:(NSNotification *)aNotification;

- (void)keyboardWillHide:(NSNotification *)aNotification;

/*
 * 网络状态发生变化时会调用该方法
 * */
//- (void)networkStatusChanged:(AFNetworkReachabilityStatus)status;

@end
