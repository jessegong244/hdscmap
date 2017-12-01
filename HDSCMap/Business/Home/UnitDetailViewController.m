//
//  UnitDetailViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitDetailViewController.h"

@interface UnitDetailViewController ()

@end

@implementation UnitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.model.name;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
