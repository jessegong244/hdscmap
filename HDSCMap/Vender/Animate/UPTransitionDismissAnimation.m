//
//  UPTransitionDismissAnimation.m
//  UPBaseUI
//
//  Created by Jimmy on 2017/5/16.
//  Copyright © 2017年 UpChina. All rights reserved.
//
#import "UPTransitionDismissAnimation.h"

@implementation UPTransitionDismissAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect finalFrameForVc = [transitionContext finalFrameForViewController:toVc];
    
    toVc.view.frame = CGRectOffset(finalFrameForVc, 0, 0);
    
    [[transitionContext containerView] addSubview:toVc.view];
    toVc.view.alpha = 0.5;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         toVc.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
}
@end
