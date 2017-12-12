//
//  LocationViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/12.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "LocationViewController.h"
#import <MAMapKit/MAMapKit.h>

@interface LocationViewController ()

@property (weak, nonatomic) IBOutlet MAMapView *mapView;

@property (nonatomic,strong) MAUserLocationRepresentation *rep;

@end

@implementation LocationViewController

- (MAUserLocationRepresentation *)rep{
    if (!_rep) {
        _rep = [[MAUserLocationRepresentation alloc] init];
        _rep.fillColor = [UIColor redColor];
    }
    return _rep;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMapView];
    
}

- (void)addMapView{
//    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    [self.mapView updateUserLocationRepresentation:self.rep];
}

@end
