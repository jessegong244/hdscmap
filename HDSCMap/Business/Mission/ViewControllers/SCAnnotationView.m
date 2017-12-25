//
//  SCAnnotationView.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/18.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0

#import "SCAnnotationView.h"

@interface SCAnnotationView ()

@property (nonatomic, strong, readwrite) SCCalloutView *calloutView;

@end

@implementation SCAnnotationView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        CGPoint tempoint = [self.calloutView convertPoint:point fromView:self];
        if (CGRectContainsPoint(self.calloutView.bounds, tempoint))
        {
            view = self.calloutView;
        }
    }
    return view;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[SCCalloutView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.image = [UIImage imageNamed:@"building"];
        self.calloutView.title = self.annotation.title;
        self.calloutView.subtitle = self.annotation.subtitle;
        self.calloutView.actionBlock = self.touchBlock;
        self.calloutView.model = self.model;
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

@end
