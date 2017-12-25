//
//  SCAnnotationView.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/18.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "SCCalloutView.h"

@interface SCAnnotationView : MAAnnotationView

@property (nonatomic,readonly) SCCalloutView *calloutView;

@property (nonatomic,copy) CalloutBlock touchBlock;

@property (nonatomic,strong) UnitDetailModel *model;

@end
