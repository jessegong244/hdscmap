//
//  SCCalloutView.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/18.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UnitDetailModel.h"
typedef void(^CalloutBlock)(UnitDetailModel *model);

@interface SCCalloutView : UIView

@property (nonatomic, strong) UIImage *image; //商户图
@property (nonatomic, copy) NSString *title; //商户名
@property (nonatomic, copy) NSString *subtitle; //地址

@property (nonatomic,strong) UnitDetailModel *model;

@property (nonatomic,copy) CalloutBlock actionBlock;

- (id)initWithFrame:(CGRect)frame calloutBlock:(CalloutBlock)block;

@end
