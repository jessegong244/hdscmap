//
//  MeterListViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/12.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//
#define BOTTOM_HEIGHT   80
#define DURANTION_TIME  .1

#import "MeterListViewController.h"
#import "UnitManager.h"
#import <MAMapKit/MAMapKit.h>
#import "UnitDetailModel.h"
#import "SCAnnotationView.h"
#import "CreateViewController.h"
#import "SCPointAnnotation.h"
#import "TownPointAnnotation.h"

@interface MeterListViewController ()<MAMapViewDelegate>

@property (nonatomic,strong) NSMutableArray *unitDetailArr;
@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottonConstrain;
@property (weak, nonatomic) IBOutlet UITextField *meterInput;

@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (nonatomic,strong) MAUserLocationRepresentation *rep;

@end

@implementation MeterListViewController

- (MAUserLocationRepresentation *)rep{
    if (!_rep) {
        _rep = [[MAUserLocationRepresentation alloc] init];
        _rep.showsAccuracyRing = YES;
    }
    return _rep;
}
- (void)dismissView{
    [UIView animateWithDuration:DURANTION_TIME animations:^{
        self.bottonConstrain.constant = -BOTTOM_HEIGHT;
        [self.view layoutIfNeeded];
    }];
}
- (void)showView{
    
    [UIView animateWithDuration:DURANTION_TIME animations:^{
        self.bottonConstrain.constant = 0;
        [self.view layoutIfNeeded];
    }];
}
- (IBAction)confirmBtnAction:(id)sender {
    [self dismissView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
}

- (void)getlist{
    [UnitManager getUnitDetailListByFatherId:self.fatherId resultBlock:^(NSMutableArray *unitArr, NSError *error) {
        self.unitDetailArr = unitArr;
        NSLog(@"arr = %@",unitArr);
//        [self addPoint];
        [self addTown];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    self.mapView.rotateEnabled = NO;
    self.mapView.rotateCameraEnabled = NO;
    [self.mapView setMapType:MAMapTypeStandard];
    [self.mapView updateUserLocationRepresentation:self.rep];
    [self getlist];
}

- (void)addTown{
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];

    UnitDetailModel *model = self.unitDetailArr[0];
    TownPointAnnotation *pointAnnotation = [[TownPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.latitude.doubleValue, model.longitude.doubleValue);
    pointAnnotation.title = model.name;
    pointAnnotation.subtitle = model.descriptions;
    pointAnnotation.model = model;
    [self.mapView addAnnotation:pointAnnotation];
    
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(model.latitude.doubleValue, model.longitude.doubleValue);
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}

- (void)addPoint{
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    CLLocationCoordinate2D commonPolylineCoords[self.unitDetailArr.count];
    
    for (int i = 0; i < self.unitDetailArr.count; i++) {
        
        UnitDetailModel *model = self.unitDetailArr[i];
        SCPointAnnotation *pointAnnotation = [[SCPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.latitude.doubleValue, model.longitude.doubleValue);
        pointAnnotation.title = model.name;
        pointAnnotation.subtitle = model.descriptions;
        pointAnnotation.model = model;
        [self.mapView addAnnotation:pointAnnotation];
        
        
        commonPolylineCoords[i].longitude = model.longitude.doubleValue;
        commonPolylineCoords[i].latitude = model.latitude.doubleValue;
    }
    MAPolyline *line = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:self.unitDetailArr.count];
    [self.mapView addOverlay:line];

    UnitDetailModel *tmp = self.unitDetailArr.firstObject;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(tmp.latitude.doubleValue, tmp.longitude.doubleValue);
    [self.mapView showOverlays:self.mapView.overlays edgePadding:UIEdgeInsetsMake(100, 100, 100, 100) animated:YES];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view isKindOfClass:[SCAnnotationView class]]) {
        [self addPoint];
    }
//    [self showView];
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    [self dismissView];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[TownPointAnnotation class]]) {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        SCAnnotationView *annotationView = (SCAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[SCAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"town.png"];
        annotationView.model = ((SCPointAnnotation *)annotation).model;
        annotationView.touchBlock = ^(UnitDetailModel *model) {
            NSLog(@"title = %@",model);
            
            
            CreateViewController *vc = [CreateViewController new];
            //            vc.fatherId = 8;
            //            vc.level = 10;
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        };
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        annotationView.selected = YES;
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -3.5);
        return annotationView;
    }
    if ([annotation isKindOfClass:[SCPointAnnotation class]])
    {
        
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        SCAnnotationView *annotationView = (SCAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[SCAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"电表.png"];
        annotationView.model = ((SCPointAnnotation *)annotation).model;
        annotationView.touchBlock = ^(UnitDetailModel *model) {
            NSLog(@"title = %@",model);
            
            
            CreateViewController *vc = [CreateViewController new];
//            vc.fatherId = 8;
//            vc.level = 10;
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
        };
        // 设置为NO，用以调用自定义的calloutView
        annotationView.canShowCallout = NO;
        annotationView.selected = YES;
        // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
        annotationView.centerOffset = CGPointMake(0, -3.5);
        return annotationView;
    }
    return nil;
}

@end
