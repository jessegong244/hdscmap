//
//  HttpRequestManager.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/30.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

typedef void(^SuccessBlock)(id returnData);
typedef void(^FailureBlock)(id returnData);

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


@end
