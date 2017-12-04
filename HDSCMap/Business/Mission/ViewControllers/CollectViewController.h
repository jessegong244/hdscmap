//
//  CollectViewController.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

typedef enum : NSUInteger {
    SelectStateNone,
    SelectStateJu,
    SelectStateFenju,
    SelectStateGongdj,
    SelectStateBiandz,
    SelectStateLine,
    SelectStateCun,
    SelectStateHubiao
} SelectState;

#import "SCBaseViewController.h"

@interface CollectViewController : SCBaseViewController

@property (nonatomic,assign) int type;//0-杆，1-户表

@end
