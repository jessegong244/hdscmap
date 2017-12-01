//
//  UPTransitionPresentAnimation.m
//  UPBaseUI
//
//  Created by Jimmy on 2017/5/16.
//  Copyright © 2017年 UpChina. All rights reserved.
//

#import "UPTransitionPresentAnimation.h"

#define PERSPECTIVE -1.0 / 200.0
#define ROTATION_ANGLE M_PI_2

@implementation UPTransitionPresentAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25f;
}
-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    
    [[transitionContext containerView] addSubview:toVc.view];
    
    toVc.view.frame = CGRectMake(0,0, SCScreenHeight, SCScreenWidth);
    toVc.view.transform = CGAffineTransformMakeRotation(M_PI_2);
    toVc.view.alpha = 0.5;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext]
                          delay:0.0
         usingSpringWithDamping:0.0
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         fromVC.view.alpha = 0;
                         toVc.view.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }];
}


@end
