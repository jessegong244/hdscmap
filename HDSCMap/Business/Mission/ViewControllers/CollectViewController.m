//
//  CollectViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/4.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "CollectViewController.h"
#import "UnitManager.h"
#import "UnitModel.h"

@interface CollectViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,assign) SelectState state;

@property (weak, nonatomic) IBOutlet UIButton *juBtn;
@property (weak, nonatomic) IBOutlet UIButton *fenjuBtn;
@property (weak, nonatomic) IBOutlet UIButton *gdsBtn;
@property (weak, nonatomic) IBOutlet UIButton *bdzBtn;
@property (weak, nonatomic) IBOutlet UIButton *lineBtn;
@property (weak, nonatomic) IBOutlet UIButton *cunBtn;
@property (weak, nonatomic) IBOutlet UIButton *hubiaoBtn;

@property (weak, nonatomic) IBOutlet UIPickerView *pickView;
@end

@implementation CollectViewController{
    NSArray *_juArr;
    NSArray *_fenjuArr;
    NSArray *_gdsArr;
    NSArray *_bdzArr;
    NSArray *_lineArr;
    NSArray *_cunArr;
    NSArray *_hubiaoArr;
    NSArray *_dataArr;
    
    NSInteger _juIndex;
    NSInteger _fenjuIndex;
    NSInteger _gdsIndex;
    NSInteger _bdzIndex;
    NSInteger _lineIndex;
    NSInteger _cunIndex;
    NSInteger _hubiaoIndex;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = (self.type == 1) ? @"采集户表" : @"采集杆";
    self.state = SelectStateNone;
    
    [UnitManager getUnitListByFatherId:0 resultBlock:^(NSArray *unitArr, NSError *error) {
        if (!error) {
            _juArr = unitArr;
            _dataArr = _juArr;
            [self.pickView reloadAllComponents];
        }
    }];
}
- (IBAction)confirmAction:(id)sender {
    self.pickView.hidden = YES;
}
- (IBAction)cancleAction:(id)sender {
    self.pickView.hidden = YES;
}

- (IBAction)selectAction:(id)sender {
    
    self.pickView.hidden = NO;
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 0:{
            self.state = SelectStateJu;
            _dataArr = _juArr;
        }
            break;
        case 1:{
            self.state = SelectStateFenju;
            _dataArr = _fenjuArr;
        }
            break;
        case 2:{
            self.state = SelectStateGongdj;
            _dataArr = _gdsArr;
        }
            break;
        case 3:{
            self.state = SelectStateBiandz;
            _dataArr = _bdzArr;
        }
            break;
        case 4:{
            self.state = SelectStateLine;
            _dataArr = _lineArr;
        }
            break;
        case 5:{
            self.state = SelectStateCun;
            _dataArr = _cunArr;
        }
            break;
        case 6:{
            self.state = SelectStateHubiao;
            _dataArr = _hubiaoArr;
        }
            break;
            
        default:{
            self.state = SelectStateNone;
        }
            break;
    }
    [self.pickView reloadAllComponents];
}

- (void)selectUnit:(NSInteger)row{
    switch (self.state) {
        case SelectStateNone:{
            
        }
            break;
        case SelectStateJu:{
            _juIndex = row;
        }
            break;
        case SelectStateFenju:{
            _fenjuIndex = row;
        }
            break;
        case SelectStateGongdj:{
            _gdsIndex = row;
        }
            break;
        case SelectStateBiandz:{
            _bdzIndex = row;
        }
            break;
        case SelectStateLine:{
            _lineIndex = row;
        }
            break;
        case SelectStateCun:{
            _cunIndex = row;
        }
            break;
        case SelectStateHubiao:{
            _hubiaoIndex = row;
        }
            break;
        default:
            break;
    }
}

#pragma mark - UIPickerView Delegate & Datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataArr.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return SCScreenWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    UnitModel *model = _dataArr[row];
    return model.name;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.pickView.hidden = YES;
    [self selectUnit:row];
}

@end
