//
//  MeterListViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/12.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "MeterListViewController.h"
#import "UnitManager.h"
#import <MAMapKit/MAMapKit.h>
#import "UnitDetailModel.h"

@interface MeterListViewController ()<MAMapViewDelegate>

@property (nonatomic,strong) NSMutableArray *unitDetailArr;

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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UnitManager getUnitDetailListByFatherId:self.fatherId resultBlock:^(NSMutableArray *unitArr, NSError *error) {
        self.unitDetailArr = unitArr;
        NSLog(@"arr = %@",unitArr);
        
    }];
}
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    [self addPoint];
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
    [self.mapView setZoomLevel:15 animated:YES];
}

- (void)addPoint{
    
    CLLocationCoordinate2D commonPolylineCoords[self.unitDetailArr.count];
    
    for (int i = 0; i < self.unitDetailArr.count; i++) {
        
        UnitDetailModel *model = self.unitDetailArr[i];
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(model.latitude.doubleValue, model.longitude.doubleValue);
        pointAnnotation.title = model.name;
        pointAnnotation.subtitle = model.descriptions;
        [self.mapView addAnnotation:pointAnnotation];
        
        commonPolylineCoords[i].longitude = model.longitude.doubleValue;
        commonPolylineCoords[i].latitude = model.latitude.doubleValue;
    }
    MAPolyline *line = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:self.unitDetailArr.count];
    [self.mapView addOverlay:line];
    
    UnitDetailModel *tmp = self.unitDetailArr.firstObject;
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(tmp.latitude.doubleValue, tmp.longitude.doubleValue);
    [self.mapView setZoomLevel:15 animated:YES];
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
    
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    
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


@end
