//
//  CreateViewController.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/7.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "CreateViewController.h"
#import <QBImagePickerController/QBImagePickerController.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "UnitManager.h"

@interface CreateViewController ()<QBImagePickerControllerDelegate>

@property (nonatomic,strong) AMapLocationManager *locationManager;

//@property (nonatomic,copy)NSString *nameString;
//@property (nonatomic,copy)NSString *addresString;
//@property (nonatomic,copy)NSString *descString;
//@property (nonatomic,copy)NSString *numString;
//@property (nonatomic,copy)NSString *phoneString;
//@property (nonatomic,assign)double longitude;
//@property (nonatomic,assign)double latitude;
//@property (nonatomic,copy)NSString *image;


@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *descField;
@property (weak, nonatomic) IBOutlet UITextField *numField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *localField;

@property (weak, nonatomic) IBOutlet UIImageView *imageView0;

@property (nonatomic,strong) UIBarButtonItem *editItem;
@end

@implementation CreateViewController

- (AMapLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.locationTimeout = 10;
        _locationManager.reGeocodeTimeout = 10;
    }
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.editItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:0 target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem = self.editItem;
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(image0TapAction)];
    [self.imageView0 addGestureRecognizer:tapGr];
    [self setupTextField];
}

- (void)setupTextField{
    if (IsValidateString(self.model.name)) {
        self.nameField.text = self.model.name;
    }
    if (IsValidateString(self.model.address)) {
        self.addressField.text = self.model.address;
    }
    if (IsValidateString(self.model.descriptions)) {
        self.descField.text = self.model.descriptions;
    }
    self.localField.text = [NSString stringWithFormat:@"经度：%@,纬度：%@",self.model.longitude,self.model.latitude];
    if (IsValidateString(self.model.number)) {
        self.numField.text = self.model.number;
    }
    if (IsValidateString(self.model.phone)) {
        self.phoneField.text = self.model.phone;
    }
    [self.imageView0 sd_setImageWithURL:[NSURL URLWithString:self.model.image]];
}

- (void)image0TapAction{
    QBImagePickerController *vc = [QBImagePickerController new];
    vc.delegate = self;
    vc.allowsMultipleSelection = YES;
    vc.mediaType = QBImagePickerMediaTypeImage;
    vc.maximumNumberOfSelection = 1;
    vc.minimumNumberOfSelection = 1;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets{
    for (PHAsset *asset in assets) {
        __block NSData * data;
//       PHAssetResource * resource = [[PHAssetResource assetResourcesForAsset: asset] firstObject];
        if (asset.mediaType == PHAssetMediaTypeImage) {
            PHImageRequestOptions * options = [[PHImageRequestOptions alloc] init];
            options.version = PHImageRequestOptionsVersionCurrent;
            options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
            options.synchronous = YES;
            [[PHImageManager defaultManager] requestImageDataForAsset: asset options: options resultHandler: ^(NSData * imageData, NSString * dataUTI, UIImageOrientation orientation, NSDictionary * info) {
                data = [NSData dataWithData: imageData];
                
                [self.imageView0 setImage:[UIImage imageWithData:data]];
                
                [HttpRequestManager httpUploadImage:[UIImage imageWithData:data] progress:^(NSProgress *uploadProgress) {
                    
                } suc:^(id returnData) {
//                    self.image = (NSString *)returnData;
                    self.model.image = (NSString *)returnData;
//                    NSLog(@"image = %@",self.image);
                } fail:^(id returnData) {
                    
                }];
            }];
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)locationAction:(id)sender {
    [MBProgressHUD showHUDAddedTo:[PageUtil getCurrentViewController].view animated:YES];
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error){
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed){
                
                [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
                return;
            }
        }
        
        CLLocationCoordinate2D coordinate = location.coordinate;
        self.model.longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
        self.model.latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
        self.localField.text = [NSString stringWithFormat:@"经度：%f,纬度：%f",coordinate.longitude,coordinate.latitude];
        NSLog(@"location:%@", location);
        [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
    }];
}

- (void)rightAction{
//    return;
    
    
    self.model.name = self.nameField.text;
    self.model.address = self.addressField.text;
    self.model.descriptions = self.descField.text;
    self.model.number = self.numField.text;
    self.model.phone = self.phoneField.text;
    
    if (!IsValidateString(self.model.name) ||
        !IsValidateString(self.model.address) ||
        !IsValidateString(self.model.descriptions)||
        !IsValidateString(self.model.number)||
        !IsValidateString(self.model.phone)) {
        NSLog(@"有参数为空");
        return;
    }
    
    [UnitManager updateUnitAndDetailWithName:self.model.name
                                          id:self.model.keyId
                                      unitId:self.model.unitId
                                     address:self.model.address
                                 description:self.model.descriptions
                                      number:self.model.number
                                       phone:self.model.phone
                                   longitude:self.model.longitude.doubleValue
                                    latitude:self.model.latitude.doubleValue
                                    fatherId:self.model.fatherId
                                       level:self.model.level
                                       image:self.model.image
                                 resultBlock:^(id response, NSError *error) {
        
        NSDictionary *dic = (NSDictionary *)response;
        if ([dic[@"fatherId"] integerValue] > 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
//    [UnitManager insertUnitAndDetailWithName:self.nameString address:self.addresString description:self.descString number:self.numString phone:self.phoneString longitude:self.longitude latitude:self.latitude fatherId:self.fatherId level:self.level image:self.image resultBlock:^(id response, NSError *error) {
//
//        NSDictionary *dic = (NSDictionary *)response;
//        if ([dic[@"fatherId"] integerValue] > 0) {
//            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
//        }
//    }];
}

@end
