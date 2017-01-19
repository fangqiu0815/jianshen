//
//  YJTopicSQLTools.m
//  BaiSi
//
//  Created by Apple on 16/10/18.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJTopicSQLTools.h"
#import "FMDB.h"
static FMDatabase *db;
@implementation YJTopicSQLTools
+ (void)initialize
{
    // 数据库文件路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSString *filename = [path stringByAppendingPathComponent:@"JianShen.sqlite"];
    // 打开数据库
    db = [FMDatabase databaseWithPath:filename];
    if ([db open]) {
       NSLog(@"打开数据库成功");
        // 创建帖子表
        NSString *sql = @"create table if not exists t_topic(url text,imglink text,title text,imglink_1 text,imglink_2 text,imglink_3 text,likecount integer);";
        if([db executeUpdate:sql]){
            NSLog(@"创建表成功");
            NSLog(@"%@",NSHomeDirectory());
        }else{
            NSLog(@"创建表失败");
        }
    }else{
       NSLog(@"打开数据库失败");
    }
}


// 保存帖子模型对象到数据库
+ (void)saveHealthy:(JYHealthy *)healthy
{
    NSString *sql = @"insert into t_topic(url,imglink,title,imglink_1,imglink_2,imglink_3,likecount) values (?,?,?,?,?,?,?);";
    // 注意：?填补的值一定要是对象类型
    BOOL success = [db executeUpdate:sql,healthy.url,healthy.imglink,healthy.title,healthy.imglink_1,healthy.imglink_2,healthy.imglink_3,@(healthy.likecount)];
    if (success) {
        NSLog(@"保存帖子到数据库成功");
    }else{
        NSLog(@"保存帖子到数据库失败");
    }
}

// 获取数据库里的所有帖子模型
+ (NSMutableArray *)topics;
{
    NSString *sql = @"select * from t_topic;";
    NSMutableArray *datas = [self topicsWithSql:sql];
    NSLog(@"datas---%@",datas);
    return datas;
}

// 根据sql语句获取帖子模型
+ (NSMutableArray *)topicsWithSql:(NSString *)sql
{
    NSMutableArray *topics = [NSMutableArray array];
    FMResultSet *result = [db executeQuery:sql];
    while ([result next]) { // 是否有下一条记录
       
        NSInteger likecount = [result intForColumn:@"likecount"];
        NSString *url = [result stringForColumn:@"url"];
        NSString *imglink = [result stringForColumn:@"imglink"];
        NSString *imglink_1 = [result stringForColumn:@"imglink_1"];
        NSString *imglink_2 = [result stringForColumn:@"imglink_2"];
        NSString *imglink_3 = [result stringForColumn:@"imglink_3"];
        NSString *title = [result stringForColumn:@"title"];
       

        JYHealthy *healthy = [[JYHealthy alloc] init];
        
        healthy.title = title;
        healthy.url = url;
        healthy.imglink = imglink;
        healthy.imglink_1 = imglink_1;
        healthy.imglink_2 = imglink_2;
        healthy.imglink_3 = imglink_3;
        healthy.likecount = likecount;
      
        [topics addObject:healthy];
    }
    return topics;
}

// 根据页码帖子模型
// 根据页码帖子模型
+ (NSMutableArray *)topicsWithPage:(NSInteger)page
{
    NSString *sql = nil;
    sql=[NSString stringWithFormat:@"select * from t_collection limit %ld,20;",page * 20];
    return [self topicsWithSql:sql];
}

@end
