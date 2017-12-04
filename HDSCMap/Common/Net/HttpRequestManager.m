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
    
    NSString *urlStr = [[[@"http://" stringByAppendingString:INTERFACE_ADDRESS] stringByAppendingString:@"/whsc/"] stringByAppendingString:url];
    NSString *encodeUrl = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [manager GET:encodeUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        failBlock(error);
    }];
}

+ (void)httpRequestPostWithUrl:(NSString *)url parameter:(NSDictionary *)parameter success:(SuccessBlock)sucBlock failture:(FailureBlock)failBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:url parameters:[HttpRequestManager dictionaryToJson:parameter] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        sucBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failBlock(error);
    }];
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
