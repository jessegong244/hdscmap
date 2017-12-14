//
//  LocationListViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "LocationListViewController.h"
#import "LocationListCell.h"
#import "SCDBManage.h"
#import "ShowLocationViewController.h"
#import "SCTool.h"

@interface LocationListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,copy) NSArray *dataArr;

@end

@implementation LocationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"轨迹列表";
    
    self.dataArr = [[SCDBManage sharedInstance] getLocationList];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 87.5f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LocationListCell *cell = [LocationListCell cellWithTableView:tableView];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LocationModel *model = self.dataArr[indexPath.row];
    ShowLocationViewController *vc = [[ShowLocationViewController alloc] init];
    vc.annoArr = [SCTool coordinateArrWithLocation:model];
    [vc setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
