//
//  QueryViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "QueryViewController.h"
#import "SkyAssociationMenuView.h"
#import "MenuConfig.h"

@interface QueryViewController ()<SkyAssociationMenuViewDelegate>

@property (strong, nonatomic) SkyAssociationMenuView *menuView;

@property (nonatomic,copy) NSArray *configArr;

@end

@implementation QueryViewController{
    NSInteger _index0;
    NSInteger _index1;
    NSInteger _index2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    self.configArr = [MenuConfig configQueryArr];
    self.menuView = [SkyAssociationMenuView new];
    self.menuView.delegate = self;
    [self.menuView showAsDrawDownView:self.view];
}

- (NSInteger)assciationMenuView:(SkyAssociationMenuView*)asView countForClass:(NSInteger)idx {
    if (idx == 0) {
        return self.configArr.count;
    }
    if (idx == 1) {
        
        NSDictionary *dic = self.configArr[_index0];
        NSArray *arr = dic[@"sonArr"];
        return arr.count;
    }
    if (idx == 2) {
        
        NSDictionary *dic = self.configArr[_index0];
        NSArray *arr = dic[@"sonArr"];
        NSDictionary *dic2 = arr[_index1];
        NSArray *arr2 = dic2[@"sonArr"];
        return arr2.count;
    }
    
    return 0;
}
- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 {
    NSDictionary *dic = self.configArr[idx_1];
    return dic[@"title"];
}

- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
    NSDictionary *dic = self.configArr[idx_1];
    NSArray *arr = dic[@"sonArr"];
    NSDictionary *dic2 = arr[idx_2];
    return dic2[@"title"];
}

- (NSString*)assciationMenuView:(SkyAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 class_3:(NSInteger)idx_3 {
    NSDictionary *dic = self.configArr[idx_1];
    NSArray *arr = dic[@"sonArr"];
    NSDictionary *dic2 = arr[idx_2];
    NSArray *arr2 = dic2[@"sonArr"];
    NSDictionary *dic3 = arr2[idx_3];
    return dic3[@"title"];
}

- (BOOL)assciationMenuView:(SkyAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1{
    _index0 = idx_1;
    NSDictionary *dic = self.configArr[idx_1];
    NSArray *arr = dic[@"sonArr"];
    if (arr.count > 0) {
        return YES;
    }else{
        [self clickActionWithId:dic[@"id"]];
        return NO;
    }
}
- (BOOL)assciationMenuView:(SkyAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2{
    _index0 = idx_1;
    _index1 = idx_2;
    NSDictionary *dic = self.configArr[idx_1];
    NSArray *arr = dic[@"sonArr"];
    NSDictionary *dic2 = arr[idx_2];
    NSArray *arr2 = dic2[@"sonArr"];
    if (arr2.count > 0) {
        return YES;
    }else{
        [self clickActionWithId:dic2[@"id"]];
        return NO;
    }
}
- (BOOL)assciationMenuView:(SkyAssociationMenuView *)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2 class3:(NSInteger)idx_3{
    _index0 = idx_1;
    _index1 = idx_2;
    _index2 = idx_3;
    NSDictionary *dic = self.configArr[idx_1];
    NSArray *arr = dic[@"sonArr"];
    NSDictionary *dic2 = arr[idx_2];
    NSArray *arr2 = dic2[@"sonArr"];
    NSDictionary *dic3 = arr2[idx_3];
    NSArray *arr3 = dic3[@"sonArr"];
    if (arr3.count > 0) {
        return YES;
    }else{
        [self clickActionWithId:dic3[@"id"]];
        return NO;
    }
}

- (void)clickActionWithId:(NSString *)idStr{
    NSLog(@"%@",idStr);
    switch (idStr.integerValue) {
            
        case 2021:{
            
        }
            break;
        case 2022:{
            
        }
            break;
        case 2023:{
            
        }
            break;
        case 2024:{
            
        }
            break;
        case 2025:{
            
        }
            break;
        case 2026:{
            
        }
            break;
        case 2027:{
            
        }
            break;
        case 2028:{
            
        }
            break;
            
        default:
            break;
    }
}
@end
