//
//  MeViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "MeViewController.h"
#import "LocationViewController.h"
#import "FLEX.h"
#import "LocationListViewController.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    
    UIButton *btn = [UIButton new];
    [btn setBackgroundColor:UIColor.grayColor];
    [btn setTitle:@"增加轨迹" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@40);
        make.centerX.equalTo(self.view);
    }];
    
//    UIButton *testBtn = [UIButton new];
//    [testBtn setBackgroundColor:UIColor.grayColor];
//    [testBtn setTitle:@"Test" forState:UIControlStateNormal];
//    [testBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [testBtn addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:testBtn];
//    [testBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.view);
//        make.width.mas_equalTo(@60);
//        make.height.mas_equalTo(@40);
//        make.right.equalTo(self.view);
//    }];
    
    UIButton *ListBtn = [UIButton new];
    [ListBtn setBackgroundColor:UIColor.grayColor];
    [ListBtn setTitle:@"轨迹list" forState:UIControlStateNormal];
    [ListBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ListBtn addTarget:self action:@selector(listAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:ListBtn];
    [ListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@40);
        make.left.equalTo(self.view);
    }];
    
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction)];
    gr.numberOfTapsRequired = 5;
    [self.navigationController.navigationBar addGestureRecognizer:gr];
}

- (void)listAction{
    LocationListViewController *vc = [[LocationListViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)testAction{
    [[FLEXManager sharedManager] showExplorer];
}

- (void)locationAction{
    LocationViewController *vc = [[LocationViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
