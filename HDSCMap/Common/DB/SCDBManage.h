//
//  SCDBManage.h
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface SCDBManage : NSObject

+ (instancetype)sharedInstance;

- (void)insertTestDb;

@end
