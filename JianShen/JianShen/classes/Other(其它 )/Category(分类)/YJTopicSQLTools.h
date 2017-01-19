//
//  YJTopicSQLTools.h
//  BaiSi
//
//  Created by Apple on 16/10/18.
//  Copyright © 2016年 ly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JYHealthy.h"
@interface YJTopicSQLTools : NSObject

// 保存帖子模型对象到数据库
+ (void)saveHealthy:(JYHealthy *)healthy;

// 获取数据库里的所有帖子模型
+ (NSMutableArray *)topics;

// 根据sql语句获取帖子模型
+ (NSMutableArray *)topicsWithSql:(NSString *)sql;

// 根据页码帖子模型
+ (NSMutableArray *)topicsWithPage:(NSInteger)page;






@end
