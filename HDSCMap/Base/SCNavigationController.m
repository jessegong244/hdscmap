//
//  SCNavigationController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "SCNavigationController.h"

@interface SCNavigationController ()

@property (nonatomic, assign) BOOL isStatebarHide;

@end

@implementation SCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
//
//    self.navigationBar.barTintColor = UPBarYellowColor;
//
//    self.navigationBar.tintColor = [UIColor whiteColor];
//    [self.navigationBar setTitleTextAttributes:@{
//                                                 NSForegroundColorAttributeName : [UIColor whiteColor],
//                                                 NSFontAttributeName : [UIFont systemFontOfSize:17],
//                                                 }];
}

//
//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
//    [super pushViewController:viewController animated:animated];
//
//    // 修改tabBra的frame
//    CGRect frame = self.tabBarController.tabBar.frame;
//    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
//    self.tabBarController.tabBar.frame = frame;
//}
//
//
//- (BOOL)shouldAutorotate {
//    return self.topViewController.shouldAutorotate;
//}
//
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//    return self.topViewController.supportedInterfaceOrientations;
//}
//
//
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return [self.topViewController preferredStatusBarStyle];
//}
//
//- (BOOL)prefersStatusBarHidden {
//    return [self.topViewController prefersStatusBarHidden];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

@end
