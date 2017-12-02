//
//  UnitDetailViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "UnitDetailViewController.h"
#import "UnitDetailCell.h"
#import "UnitNameCell.h"

@interface UnitDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) UIView *footView;

@end

@implementation UnitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.name;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.footView = ({
        UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCScreenWidth, 100)];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
        [foot addSubview:imageView];
        foot;
    });
    self.tableView.tableFooterView = self.footView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UnitNameCell *cell = [UnitNameCell cellWithTableView:tableView model:self.model];
        return cell;
    }else{
        UnitDetailCell *cell = [UnitDetailCell cellWithTableView:tableView model:self.model index:indexPath];
        return cell;
    }
    
}

@end
