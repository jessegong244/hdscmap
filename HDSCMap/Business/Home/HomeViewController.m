//
//  HomeViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "HomeViewController.h"
#import "SCDBManage.h"
#import "HttpRequestManager.h"
#import <MAMapKit/MAMapKit.h>
#import "UnitModel.h"
#import "UnitDetailViewController.h"

@interface HomeViewController ()<MAMapViewDelegate>

@property (nonatomic,copy)NSString *latitude;
@property (nonatomic,copy)NSString *longitude;

@property (nonatomic,strong)MAMapView *mapView;

@property (nonatomic,strong)UnitModel *model;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self makeView];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)makeView{
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"insert" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(insertAction) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = UIColor.redColor;
    [self.view addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
    }];
    
    self.mapView = [[MAMapView alloc] init];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.desiredAccuracy = kCLLocationAccuracyBest;
    self.mapView.distanceFilter = 1.0f;
    [self.mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    self.mapView.pausesLocationUpdatesAutomatically = NO;
//    self.mapView.allowsBackgroundLocationUpdates = YES;
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
}

- (void)insertAction{
//    [[SCDBManage sharedInstance] insertTestDb];
    
    NSDictionary *dic = @{@"unitId":@"15"};
    NSString *url = @"http://localhost:8080/whsc/getUnitDetail";
    NSString *encodeUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [HttpRequestManager httpRequestGetWithUrl:encodeUrl parameter:dic success:^(id returnData) {
        NSLog(@"returen = %@",returnData);
        NSDictionary *dic = (NSDictionary *)returnData;
        _model = [UnitModel modelWithDictionary:dic];
        self.latitude = _model.latitude;
        self.longitude = _model.longitude;
        
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.longitude.doubleValue, self.latitude.doubleValue);
        pointAnnotation.title = _model.name;
        pointAnnotation.subtitle = _model.descriptions;
        [self.mapView addAnnotation:pointAnnotation];
        
        UnitDetailViewController *vc = [[UnitDetailViewController alloc] init];
        vc.model = self.model;
        [vc setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:vc animated:YES];
        
    } failture:^(id returnData) {
        
    }];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    NSLog(@"yes");
}


@end
