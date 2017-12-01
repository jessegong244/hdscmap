//
//  SCDBManage.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/11/27.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "SCDBManage.h"

#define SCDatabaseName @"SCDatabaseName"        //总表

#define CityTableName @"CityTableName"          //市局
#define AreaTableName @"AreaTableName"          //分局
#define PlaceTableName @"PlaceTableName"        //供电所
#define StationTableName @"StationTableName"    //变电站
#define LineTableName @"LineTableName"          //线路
#define VillageTableName @"VillageTableName"    //村
#define MeterTableName @"MeterTableName"        //户表



@implementation SCDBManage{
    FMDatabaseQueue *_dbQueue;
    NSArray *_tableArr;
    NSArray *_nameArr;
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
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@.db", docPath, SCDatabaseName];
    NSLog(@"path =   %@",dbPath);
    
    _dbQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    _tableArr = @[CityTableName,AreaTableName,PlaceTableName,StationTableName,LineTableName,VillageTableName,MeterTableName];
    _nameArr = @[@"电力局",@"电力局分局",@"供电所",@"变电站",@"线路",@"xx村",@"户表"];
}

- (BOOL)initTable {
    __block BOOL result = YES;
    [_dbQueue inDatabase:^(FMDatabase *db) {
        
        for (int i = 0; i < _tableArr.count; i ++) {
            
            NSString * tableName = _tableArr[i];
            if (![db tableExists:tableName]) {
                NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@ (_id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,fatherId INTEGER)", tableName];
                result = [db executeUpdate:sql];
                if (!result) {
                    result = NO;
                    NSLog(@"创建数据库%@失败--%@",tableName, sql);
                }
            }
        }
    }];
    return result;
}

- (void)insertTestDb{
    [self insertCity];
    
}

- (void)insertCity{
    
    [_dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (name,fatherId) VALUES(\"%@\",%d)", CityTableName,
                         @"武汉供电局",
                         0];
        BOOL result = [db executeUpdate:sql];
        if (!result) {
            NSLog(@"插入数据失败--%@", sql);
            *rollback = YES;
        }
    }];
}

- (void)insertArea{
    [_dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        
        
    }];
}
































































@end
