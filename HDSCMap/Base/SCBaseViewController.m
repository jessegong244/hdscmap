//
//  SCBaseViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "SCBaseViewController.h"

@interface SCBaseViewController ()

@end

@implementation SCBaseViewController

// MARK: - LifeCircle

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.popBarButtonItem;
    self.view.backgroundColor = UPBgGreyColor;
}


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.hidesBottomBarWhenPushed = NO;
        self.firstAppear = YES;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = self.navigationBarColor;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController setNavigationBarHidden:self.hideNavigationBar animated:YES];
//    if (_observeNetworkStatus) {
//        [UPNotificationCenter addObserver:self selector:@selector(notifNetworkStatusChanged:) name:UPNotifNetworkStatusChanged object:nil];
//    }
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.navigationController.viewControllers.count > 1) {
//        _gestureDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.interactivePopGestureRecognizer.delegate = _gestureDelegate;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// MARK: - Public

- (void)popViewController {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardWillHide:(NSNotification *)aNotification {
}

//- (void)networkStatusChanged:(UPReachabilityStatus)status {
//    
//}


- (void)keyboardChangeFrame:(NSNotification *)aNotification {
}

// MARK: - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return self.navigationController.childViewControllers.count > 1;
    }
    return NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return self.navigationController.viewControllers.count > 1;
    }
    return NO;
}

// MARK: - Notification

//- (void)notifNetworkStatusChanged:(NSNotification *)notification {
//    NSNumber *statusNumber = [notification object];
//    UPReachabilityStatus status = [statusNumber integerValue];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self networkStatusChanged:status];
//    });
//}

// MARK: - Getter & Setter
- (UIColor *)navigationBarColor
{
    if (_navigationBarColor == nil)
    {
        _navigationBarColor = UPBarYellowColor;
    }
    return _navigationBarColor;
}

- (UIBarButtonItem *)popBarButtonItem {
    if (!_popBarButtonItem) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_back"]];
        imageView.frame = CGRectMake(-6, 7, 26, 26);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addSubview:imageView];
        button.frame = CGRectMake(0, 0, 40, 40);
        [button addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
        _popBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }
    return _popBarButtonItem;
}

- (void)setObserveKeyBoard:(BOOL)observeKeyBoard {
    if (observeKeyBoard == _observeKeyBoard) {
        return;
    }
    _observeKeyBoard = observeKeyBoard;
    if (observeKeyBoard) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardChangeFrame:)
                                                     name:UIKeyboardWillChangeFrameNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
}

- (UIEdgeInsets)contentInset {
    CGFloat topSpace = 0.f;
    if (self.navigationController && !self.navigationController.navigationBar.hidden) {
        topSpace += CGRectGetHeight(self.navigationController.navigationBar.frame);
    }
    topSpace += CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    
    CGFloat bottomSpace = 0.f;
    UITabBar *tabBar = self.navigationController.tabBarController.tabBar;
    if (tabBar && !tabBar.hidden) {
        bottomSpace = CGRectGetHeight(tabBar.frame);
    }
    return UIEdgeInsetsMake(topSpace, 0.f, bottomSpace, 0.f);
}

@end
