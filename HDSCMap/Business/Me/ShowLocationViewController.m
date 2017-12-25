//
//  ShowLocationViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/14.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "ShowLocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "YSMapAnnotation.h"
#import "SCTool.h"

@interface ShowLocationViewController ()<MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *screenImage;

@end

@implementation ShowLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:0 target:self action:@selector(getScreen)];
//    self.navigationItem.rightBarButtonItem = item;
    
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [self addAnnotation];
}

- (void)addAnnotation{
    
    // 根据坐标点添加路径
    NSInteger count = [self.annoArr count];
    CLLocationCoordinate2D polylineCoords[count];
    for (NSInteger i = 0; i < count; i++)
    {
        YSMapAnnotation *annotation = self.annoArr[i];
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        
        polylineCoords[i].latitude = coordinate.latitude;
        polylineCoords[i].longitude = coordinate.longitude;
    }
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:count];
    [self.mapView addOverlay:polyline];
    [self.mapView showOverlays:self.mapView.overlays edgePadding:UIEdgeInsetsMake(100, 100, 100, 100) animated:YES];
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor blueColor];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}


@end
