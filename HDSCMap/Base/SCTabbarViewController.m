//
//  SCTabbarViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "SCTabbarViewController.h"
#import "SCNavigationController.h"
#import "UPTransitionDismissAnimation.h"

@interface SCTabbarViewController ()<UITabBarControllerDelegate,UINavigationControllerDelegate>

@end

@implementation SCTabbarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有的子控制器
    [self setupChildVcs];
    self.tabBar.barTintColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.tabBar.translucent = NO;
    
}

- (void)dealloc {
//    [UPNotificationCenter removeObserver:self];
}

/**
 * 添加所有的子控制器
 */
- (void)setupChildVcs
{
    self.homeVC = [[HomeViewController alloc] init];
    [self setupChildVc:self.homeVC title:@"首页" image:@"首页-默认" selectedImage:@"首页-选中"];
    
    self.missionVC = [[MissionViewController alloc] init];
    [self setupChildVc:self.missionVC title:@"任务" image:@"自选-默认" selectedImage:@"自选-选中"];
    
    self.queryVC = [[QueryViewController alloc] init];
    [self setupChildVc:self.queryVC title:@"查询" image:@"资讯-默认" selectedImage:@"资讯-选中"];
    
    self.meVC = [[MeViewController alloc] init];
    [self setupChildVc:self.meVC title:@"我" image:@"我的-默认" selectedImage:@"我的-选中"];
}

/**
 * 添加一个子控制器
 * @param title 文字
 * @param image 图片
 * @param selectedImage 选中时的图片
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 包装一个导航控制器
    SCNavigationController *nav = [[SCNavigationController alloc] initWithRootViewController:vc];
    nav.delegate = self;
    [self addChildViewController:nav];
    
    // 设置子控制器的tabBarItem
    vc.title = title;
    //图片
    nav.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //字体颜色
    nav.tabBarController.tabBar.tintColor = UPSelectEnableColor;
}

- (BOOL)shouldAutorotate {
    return self.selectedViewController.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return self.selectedViewController.supportedInterfaceOrientations;
}

// MARK: - UITabBarControllerDelegate

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
}


// MARK: - UINavigationControllerDelegate
#pragma mark- UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    if (operation == UINavigationControllerOperationPop && [fromVC isKindOfClass:NSClassFromString(@"UPStockLandscapeViewController")]){
        return [[UPTransitionDismissAnimation alloc] init];
    }
    else
    {
        return nil;
    }
}
// MARK: - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        if (navigationController.viewControllers.count > 1)
        {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
        else
        {
            navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
    
    
    if ([viewController isKindOfClass:NSClassFromString(@"UPStockViewController")]) {
        
        NSMutableArray *array = [navigationController.viewControllers mutableCopy];
        [navigationController.viewControllers enumerateObjectsUsingBlock:^(UIViewController * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:NSClassFromString(@"UPStockViewController")]) {
                if ([array[idx-1] isKindOfClass:NSClassFromString(@"UPStockSearchViewController")]) {
                    [array removeObjectAtIndex:idx-1];
                }
            }
        }];
        navigationController.viewControllers = [array copy];
    }
    
}

@end
