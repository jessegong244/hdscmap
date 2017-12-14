//
//  SCDBManage.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "SCDBManage.h"
#import "LocationModel.h"

#define SCDatabaseName @"SCDatabaseName"        //总表

#define COORDINATE_TABLE @"coordinate_tableName"//坐标

#define LOCATION_KEY    @"location"

@implementation SCDBManage{
    FMDatabaseQueue *_dbQueue;
    
}

static SCDBManage *_instance = nil;

+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[SCDBManage alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDatabase];
        [self initTable];
    }
    return self;
}

- (void)initDatabase {
    NSString *docPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"database"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:docPath] == NO) {
        [fileManager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@.sqlite", docPath, SCDatabaseName];
    NSLog(@"path =   %@",dbPath);
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
}

- (BOOL)initTable {
    
    __block BOOL result = YES;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        if (![db tableExists:COORDINATE_TABLE]) {
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT,location TEXT)", COORDINATE_TABLE];
            result = [db executeUpdate:sql];
            if (!result) {
                result = NO;
                NSLog(@"创建数据库%@失败--%@",COORDINATE_TABLE, sql);
            }
        }
    }];
    return result;
}

- (void)insertLocation:(NSString *)locationString{
    
    [_dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        NSString *sql = [NSString stringWithFormat:@"insert into %@ (location) values (\"%@\")",COORDINATE_TABLE,locationString];
        
        BOOL result = [db executeUpdate:sql];
        if (!result) {
            NSLog(@"insert 失败！！！---------%@",sql);
            *rollback = YES;
        }
    }];
}

- (NSArray<LocationModel *> *)getLocationList{
    
    __block NSMutableArray *arr = [NSMutableArray array];
    [_dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSString *sql = [NSString stringWithFormat:@"select * from %@",COORDINATE_TABLE];
        FMResultSet *set = [db executeQuery:sql];
        while ([set next]) {
            NSInteger locId = [set intForColumn:@"_id"];
            NSString *location = [set objectForColumn:@"location"];
            
            LocationModel *model = [LocationModel new];
            model.locId = locId;
            model.locationStr = location;
            [arr addObject:model];
        }
        [set close];
    }];
    return arr;
}




























































@end
