//
//  HttpRequestManager.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/30.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

typedef void(^SuccessBlock)(id returnData);
typedef void(^FailureBlock)(id returnData);

typedef void(^ProgressBlock)(NSProgress *uploadProgress);

#import <Foundation/Foundation.h>

@interface HttpRequestManager : NSObject

+ (void)httpRequestGetWithUrl:(NSString *)url
                    parameter:(NSDictionary *)parameter
                      success:(SuccessBlock)sucBlock
                     failture:(FailureBlock)failBlock;

+ (void)httpRequestPostWithUrl:(NSString *)url
                    parameter:(NSDictionary *)parameter
                      success:(SuccessBlock)sucBlock
                     failture:(FailureBlock)failBlock;

+ (void)httpUploadImage:(UIImage *)image progress:(ProgressBlock)progress suc:(SuccessBlock)suc fail:(FailureBlock)fail;


@end
