//
//  HttpRequestManager.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/30.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "HttpRequestManager.h"
#import "AFNetworking.h"

@implementation HttpRequestManager

+ (void)httpRequestGetWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(SuccessBlock)sucBlock failture:(FailureBlock)failBlock{
    
    [MBProgressHUD showHUDAddedTo:[PageUtil getCurrentViewController].view animated:YES];
    
    NSString *urlStr = [[[@"http://" stringByAppendingString:INTERFACE_ADDRESS] stringByAppendingString:@"/whsc/"] stringByAppendingString:url];
    NSString *encodeUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSLog(@"url = %@,parameter = %@",url,parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:encodeUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
        failBlock(error);
    }];
}

+ (void)httpRequestPostWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(SuccessBlock)sucBlock failture:(FailureBlock)failBlock{
    
    [MBProgressHUD showHUDAddedTo:[PageUtil getCurrentViewController].view animated:YES];
    
    NSString *urlStr = [[[@"http://" stringByAppendingString:INTERFACE_ADDRESS] stringByAppendingString:@"/whsc/"] stringByAppendingString:url];
    NSString *encodeUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"url = %@,parameter = %@",encodeUrl,parameter);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:encodeUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
        failBlock(error);
    }];
}

+ (void)httpUploadImage:(UIImage *)image progress:(ProgressBlock)progress suc:(SuccessBlock)suc fail:(FailureBlock)fail{
    [MBProgressHUD showHUDAddedTo:[PageUtil getCurrentViewController].view animated:YES];
    
    NSString *urlStr = [[[@"http://" stringByAppendingString:INTERFACE_ADDRESS] stringByAppendingString:@"/whsc/"] stringByAppendingString:@"uploadImage"];
    NSString *encodeUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"url = %@",encodeUrl);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:encodeUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSData *data = UIImagePNGRepresentation(image);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        //上传的参数(上传图片，以文件流的格式)
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
//        NSLog(@"progress = %f",uploadProgress.fractionCompleted);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
        suc(responseString);
        NSLog(@"response = %@",responseString);
        NSLog(@"上传成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD hideHUDForView:[PageUtil getCurrentViewController].view animated:YES];
        
        fail(error);
        NSLog(@"error = %@",error);
        NSLog(@"上传失败%@",error);
    }];
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
