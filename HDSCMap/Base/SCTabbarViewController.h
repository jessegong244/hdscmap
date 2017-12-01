//
//  SCTabbarViewController.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HomeViewController.h"
#import "MeViewController.h"
#import "MissionViewController.h"
#import "QueryViewController.h"

@interface SCTabbarViewController : UITabBarController

@property (nonatomic,strong) HomeViewController *homeVC;
@property (nonatomic,strong) MissionViewController *missionVC;
@property (nonatomic,strong) QueryViewController *queryVC;
@property (nonatomic,strong) MeViewController *meVC;

@end
