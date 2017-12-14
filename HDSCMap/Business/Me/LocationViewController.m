//
//  LocationViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/12.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "LocationViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "Record.h"
#import "MAMutablePolyline.h"
#import "MAMutablePolylineRenderer.h"
#import "YSCoordinateProcesser.h"
#import "YSMapCalculateFunc.h"
#import "YSMapAnnotation.h"
#import "SCDBManage.h"
#import "SCTool.h"

#define MIN_DISTANCE    10

@interface LocationViewController ()<MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@property (nonatomic,strong) MAUserLocationRepresentation *rep;

// 记录上次和当前的定位未处理过的点，用来计算当前速度
@property (nonatomic, assign) CLLocationCoordinate2D lastLocationCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D currentLocationCoordinate;
@property (nonatomic, assign) double lastLocatedTime;  // 上一次定位的时间
@property (nonatomic, assign) double currentLocatedTime;   // 当前定位的时间
@property (nonatomic, assign) NSInteger updateuLocationTimes;
@property (nonatomic, strong) NSMutableArray *annotationRecordArray;
@property (nonatomic, strong) YSCoordinateProcesser *processer;


// 用来记录测试数据
@property (nonatomic, assign) CGFloat calculationDistance;
@property (nonatomic, assign) CGFloat actualCalcutationSpeed;

@property (nonatomic, assign) CGFloat hSpeed;
@property (nonatomic, assign) CGFloat lSpeed;
@property (nonatomic, assign) CGFloat currentSpeed;

@end

@implementation LocationViewController{
    MAUserLocation *_userLocation;
    BOOL _isLocating;
}
- (IBAction)locAction:(id)sender {
    [self.mapView setCenterCoordinate:_userLocation.coordinate animated:YES];
}
- (IBAction)startAction:(id)sender {
    [self startLocation];
}
- (IBAction)endAction:(id)sender {
    [self endLocation];
}

- (MAUserLocationRepresentation *)rep{
    if (!_rep) {
        _rep = [[MAUserLocationRepresentation alloc] init];
//        _rep.fillColor = [UIColor redColor];
    }
    return _rep;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.annotationRecordArray = [NSMutableArray array];
    self.processer = [YSCoordinateProcesser new];
    
//    [[SCDBManage sharedInstance] insertTestDb];
    [self addMapView];
    
}

- (void)addMapView{
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView updateUserLocationRepresentation:self.rep];
    [self.mapView setZoomLevel:15 animated:YES];
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    _userLocation = userLocation;
    CLLocationCoordinate2D coordinate = userLocation.coordinate;
    if(updatingLocation && [self checkIsNeedInputCoordinate:coordinate]){
        [self addLocationCoordinate:coordinate];
        if (_isLocating) {
            [self updateRoute];
        }
    }
}
- (BOOL)checkIsNeedInputCoordinate:(CLLocationCoordinate2D)coordinate{
    
    if (self.annotationRecordArray.count == 0) {
        return YES;
    }
    YSMapAnnotation *anno = self.annotationRecordArray.lastObject;
    CLLocationCoordinate2D begin = anno.coordinate;
    MAMapPoint point1 = MAMapPointForCoordinate(begin);
    MAMapPoint point2 = MAMapPointForCoordinate(coordinate);
    CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
    return distance > MIN_DISTANCE;
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
- (void)removePreviousRoute
{
    NSArray *overlays = self.mapView.overlays;
    NSInteger count = [overlays count];
    
    NSInteger requireNumber = 1;    // 只需要1条路径来展示线路。
    if (count > requireNumber)
    {
        NSRange range = {0, count - requireNumber};
        NSArray *subOverlays = [overlays subarrayWithRange:range];
        [self.mapView removeOverlays:subOverlays];
    }
}
- (void)startLocation{
    _isLocating = YES;
    // 开始进行定位
}

- (void)savePointArr{
    
    if (self.annotationRecordArray.count <6) {
        return;
    }
    
    NSString *dataStr = [SCTool stringByAppendingLocArray:self.annotationRecordArray];
    NSLog(@"datastr = %@",dataStr);
    [[SCDBManage sharedInstance] insertLocation:dataStr];
}

- (void)endLocation
{
    _isLocating = NO;
    
    [self savePointArr];
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addUpdateRoute
{
    // 先移除之前绘制的路径
//    [YSMapCalculateFunc addAnnotationArray:self.annotationRecordArray toMapView:self.mapView];
    [self removePreviousRoute];
    [self addAnnotationArray:self.annotationRecordArray toMapView:self.mapView];
//    [self removePreviousRoute];
    
    // 绘制最新的路径
//    YSMapAnnotation *annotation = [self.annotationRecordArray lastObject];
//    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}

- (void)addAnnotationArray:(NSArray<YSMapAnnotation *> *)annotationArray
                 toMapView:(MAMapView *)mapView
{
    // 根据坐标点添加路径
    
    NSInteger count = [annotationArray count];
    CLLocationCoordinate2D polylineCoords[count];
    for (NSInteger i = 0; i < count; i++)
    {
        YSMapAnnotation *annotation = annotationArray[i];
        CLLocationCoordinate2D coordinate = annotation.coordinate;
        
        polylineCoords[i].latitude = coordinate.latitude;
        polylineCoords[i].longitude = coordinate.longitude;
    }
    
    MAPolyline *polyline = [MAPolyline polylineWithCoordinates:polylineCoords count:count];
    [mapView addOverlay:polyline];
}

- (void)updateRoute
{
    // 更新路径
    NSInteger numberOfCoords = [self.annotationRecordArray count];
    NSInteger requiredCount = 2;    // 需要两点来绘制新的路线
    if (numberOfCoords < requiredCount){
        // 只有初始点
        return;
    }
    [self addUpdateRoute];
}
- (void)updateSpeedWithNewCoordinate:(CLLocationCoordinate2D)newCoordinate
{
    // 每次定位更新时调用，更新时间和位置，计算当前速度
    
    // 上次定位和本次定位的时间
    self.lastLocatedTime = self.currentLocatedTime;
    self.currentLocatedTime = CFAbsoluteTimeGetCurrent();
    
    // 上次定位和本次定位的坐标
    self.lastLocationCoordinate = self.currentLocationCoordinate;
    self.currentLocationCoordinate = newCoordinate;
    
    double timeInterval = (self.currentLocatedTime - self.lastLocatedTime);
    if (timeInterval <= 0.01)
    {
        return;
    }
    
    CGFloat distance = [YSMapCalculateFunc distanceBetweenCoordinate1:self.lastLocationCoordinate coordinate2:self.currentLocationCoordinate];
    self.calculationDistance = distance;
    if (distance > 3000)
    {
        // 距离大于一定距离可当做定位出错，或者self.lastLocationCoordinate未赋值
        return;
    }
    
    self.currentSpeed = distance / timeInterval;    // m/s
    self.actualCalcutationSpeed = self.currentSpeed;
    
    // 防止因为定位漂移产生的速度过大，当速度大于一定值时做特殊处理
    if (self.currentSpeed > 50)
    {
        self.currentSpeed = 5;
    }
    
    [self updateSpeed:self.currentSpeed];
}
- (void)addLocationCoordinate:(CLLocationCoordinate2D)coordinate
{
    // 将新位置保存到数组中。
    YSMapAnnotation *annotation = [[YSMapAnnotation alloc] initWithCoordinate:coordinate];
    [self.annotationRecordArray addObject:annotation];
}
- (void)updateSpeed:(CGFloat)speed
{
    // 防止把最低速度赋值为0
    if (speed <= 0.01)
    {
        return;
    }
    
    // 第一次计算速度时未赋值。
    if (self.hSpeed < 0 && self.lSpeed < 0)
    {
        self.hSpeed = speed;
        self.lSpeed = speed;
    }
    
    // 最低速度
    if (self.lSpeed > speed)
    {
        self.lSpeed = speed;
    }
    
    // 最高速度
    if (self.hSpeed < speed)
    {
        self.hSpeed = speed;
    }
}

@end
