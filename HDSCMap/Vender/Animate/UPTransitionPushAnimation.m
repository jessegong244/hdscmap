//
// Created by Nic on 2017/7/5.
// Copyright (c) 2017 UpChina. All rights reserved.
//

#import "UPTransitionPushAnimation.h"

@implementation UPTransitionPushAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];

    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect fromVCRect = fromVC.view.frame;
    fromVCRect.origin.x = 0;
    fromVC.view.frame = fromVCRect;
    [container addSubview:toVC.view];

    CGRect toVCRect = toVC.view.frame;
    toVCRect.origin.x = screenWidth;
    toVC.view.frame = toVCRect;

    fromVCRect.origin.x = -screenWidth;
    toVCRect.origin.x = 0;

    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromVC.view.frame = fromVCRect;
        toVC.view.frame = toVCRect;
    } completion:^(BOOL finished){
        [fromVC.view removeFromSuperview];
        [transitionContext completeTransition:finished];//动画结束、取消必须调用
    }];

}

@end