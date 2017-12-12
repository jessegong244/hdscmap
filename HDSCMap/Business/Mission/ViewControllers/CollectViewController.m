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
#import "CreateViewController.h"
#import "MeterListViewController.h"

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
@property (weak, nonatomic) IBOutlet UIView *picker;
@end

@implementation CollectViewController{
//    NSArray *_juArr;
//    NSArray *_fenjuArr;
//    NSArray *_gdsArr;
//    NSArray *_bdzArr;
//    NSArray *_lineArr;
//    NSArray *_cunArr;
//    NSArray *_hubiaoArr;
    NSArray *_dataArr;
    
    UnitModel *_juModel;
    UnitModel *_fenjuModel;
    UnitModel *_gdsModel;
    UnitModel *_bdzModel;
    UnitModel *_lineModel;
    UnitModel *_cunModel;
    UnitModel *_hubiaoModel;
    
    NSInteger _juIndex;
    NSInteger _fenjuIndex;
    NSInteger _gdsIndex;
    NSInteger _bdzIndex;
    NSInteger _lineIndex;
    NSInteger _cunIndex;
    NSInteger _hubiaoIndex;
    
    UnitModel *_tmpModel;
    
    NSInteger _hubiaoFatherId;
    NSInteger _hubiaoLevel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = (self.type == 1) ? @"采集户表" : @"采集杆";
    self.state = SelectStateNone;
    
}
- (IBAction)confirmAction:(id)sender {
    self.picker.hidden = YES;
    [self confirm];
}
- (IBAction)cancleAction:(id)sender {
    self.picker.hidden = YES;
}


- (IBAction)juAction:(id)sender {
    self.state = SelectStateJu;
    [UnitManager getUnitListByFatherId:0 resultBlock:^(NSArray *unitArr, NSError *error) {
        if (!error) {
            _dataArr = unitArr;
            self.picker.hidden = NO;
            _juModel = _dataArr[0];
            [self.pickView reloadAllComponents];
        }
    }];
}
- (IBAction)fenjuAction:(id)sender {
    if (!_juModel) {
        return;
    }
    self.state = SelectStateFenju;
    
    [UnitManager getUnitListByFatherId:_juModel.unitId resultBlock:^(NSArray *unitArr, NSError *error) {
        if (!error) {
            _dataArr = unitArr;
            self.picker.hidden = NO;
            _fenjuModel = _dataArr[0];
            [self.pickView reloadAllComponents];
        }
    }];
}
- (IBAction)gdsAction:(id)sender {
    if (!_fenjuModel) {
        return;
    }
    self.state = SelectStateGongdj;
    
    [UnitManager getUnitListByFatherId:_fenjuModel.unitId resultBlock:^(NSArray *unitArr, NSError *error) {
        if (!error) {
            _dataArr = unitArr;
            self.picker.hidden = NO;
            _gdsModel = _dataArr[0];
            [self.pickView reloadAllComponents];
        }
    }];
}
- (IBAction)bdzAction:(id)sender {
    if (!_gdsModel) {
        return;
    }
    self.state = SelectStateBiandz;
    
    [UnitManager getUnitListByFatherId:_gdsModel.unitId resultBlock:^(NSArray *unitArr, NSError *error) {
        if (!error) {
            _dataArr = unitArr;
            self.picker.hidden = NO;
            _bdzModel = _dataArr[0];
            [self.pickView reloadAllComponents];
        }
    }];
}
- (IBAction)lineAction:(id)sender {
    if (!_bdzModel) {
        return;
    }
    self.state = SelectStateLine;
    
    [UnitManager getUnitListByFatherId:_bdzModel.unitId resultBlock:^(NSArray *unitArr, NSError *error) {
        if (!error) {
            _dataArr = unitArr;
            self.picker.hidden = NO;
            _lineModel = _dataArr[0];
            [self.pickView reloadAllComponents];
        }
    }];
}
- (IBAction)cunAction:(id)sender {
    if (!_lineModel) {
        return;
    }
    self.state = SelectStateCun;
    
    [UnitManager getUnitListByFatherId:_lineModel.unitId resultBlock:^(NSArray *unitArr, NSError *error) {
        if (!error) {
            _dataArr = unitArr;
            self.picker.hidden = NO;
            _cunModel = _dataArr[0];
            [self.pickView reloadAllComponents];
        }
    }];
}

- (IBAction)createNew:(id)sender {
    
    if (_hubiaoLevel == 0 || _hubiaoFatherId == 0) {
        return;
    }
    CreateViewController *vc = [CreateViewController new];
    vc.fatherId = _hubiaoFatherId;
    vc.level = _hubiaoLevel;
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)checkAction:(id)sender {
    
    _hubiaoLevel = 8;
    _hubiaoFatherId = 10;
    //for test
    
    if (_hubiaoLevel == 0 || _hubiaoFatherId == 0) {
        return;
    }
    MeterListViewController *vc = [MeterListViewController new];
    vc.fatherId = _hubiaoFatherId;
    vc.level = _hubiaoLevel;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)confirm{
    switch (self.state) {
        case SelectStateNone:{
            
        }
            break;
        case SelectStateJu:{
            [self.juBtn setTitle:_juModel.name forState:UIControlStateNormal];
            
            [self.fenjuBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _fenjuModel = nil;
            [self.gdsBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _gdsModel = nil;
            [self.bdzBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _bdzModel = nil;
            [self.lineBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _lineModel = nil;
            [self.cunBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _cunModel = nil;
        }
            break;
        case SelectStateFenju:{
            [self.fenjuBtn setTitle:_fenjuModel.name forState:UIControlStateNormal];
            
            [self.gdsBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _gdsModel = nil;
            [self.bdzBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _bdzModel = nil;
            [self.lineBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _lineModel = nil;
            [self.cunBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _cunModel = nil;
        }
            break;
        case SelectStateGongdj:{
            [self.gdsBtn setTitle:_gdsModel.name forState:UIControlStateNormal];
            
            [self.bdzBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _bdzModel = nil;
            [self.lineBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _lineModel = nil;
            [self.cunBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _cunModel = nil;
        }
            break;
        case SelectStateBiandz:{
            [self.bdzBtn setTitle:_bdzModel.name forState:UIControlStateNormal];
            
            [self.lineBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _lineModel = nil;
            [self.cunBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _cunModel = nil;
        }
            break;
        case SelectStateLine:{
            [self.lineBtn setTitle:_lineModel.name forState:UIControlStateNormal];
            
            [self.cunBtn setTitle:@"请选择" forState:UIControlStateNormal];
            _cunModel = nil;
        }
            break;
        case SelectStateCun:{
            [self.cunBtn setTitle:_cunModel.name forState:UIControlStateNormal];
            _hubiaoFatherId = _cunModel.unitId;
            _hubiaoLevel = _cunModel.level+1;
        }
            break;
        case SelectStateHubiao:{
            [self.hubiaoBtn setTitle:_hubiaoModel.name forState:UIControlStateNormal];
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
    switch (self.state) {
        case SelectStateNone:{
            
        }
            break;
        case SelectStateJu:{
            _juModel = _dataArr[row];
        }
            break;
        case SelectStateFenju:{
            _fenjuModel = _dataArr[row];
        }
            break;
        case SelectStateGongdj:{
            _gdsModel = _dataArr[row];
        }
            break;
        case SelectStateBiandz:{
            _bdzModel = _dataArr[row];
        }
            break;
        case SelectStateLine:{
            _lineModel = _dataArr[row];
        }
            break;
        case SelectStateCun:{
            _cunModel = _dataArr[row];
        }
            break;
        case SelectStateHubiao:{
            _hubiaoModel = _dataArr[row];
        }
            break;
        default:
            break;
    }
}

@end
