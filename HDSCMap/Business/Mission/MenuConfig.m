//
//  MenuConfig.m
//  HDSCMap
//
//  Created by 龚伟强 on 2017/12/1.
//  Copyright © 2017年 WHShunCheng. All rights reserved.
//

#import "MenuConfig.h"

@implementation MenuConfig

+ (NSArray *)configArr{
    return @[
             @{@"id":@"1010",@"title":@"新建",@"sonArr":@[
                              @{@"id":@"1011",@"title":@"抄表",@"sonArr":@[]},
                              @{@"id":@"1012",@"title":@"巡线",@"sonArr":@[]},
                              @{@"id":@"1013",@"title":@"检修",@"sonArr":@[
                                            @{@"id":@"1014",@"title":@"杆",@"sonArr":@[]},
                                            @{@"id":@"1015",@"title":@"表",@"sonArr":@[]}
                                        ]},
                              @{@"id":@"1016",@"title":@"催费",@"sonArr":@[]},
                              @{@"id":@"1017",@"title":@"采集",@"sonArr":@[
                                            @{@"id":@"1018",@"title":@"杆",@"sonArr":@[]},
                                            @{@"id":@"1019",@"title":@"表",@"sonArr":@[]}
                                        ]}
                          ]},
                @{@"id":@"1020",@"title":@"查询",@"sonArr":@[
                              @{@"id":@"1021",@"title":@"杆",@"sonArr":@[]},
                              @{@"id":@"1022",@"title":@"表",@"sonArr":@[]}
                          ]},
                @{@"id":@"1023",@"title":@"最近",@"sonArr":@[]}
            ];
}

@end
