//
//  YJFileTools.m
//  BaiSi
//
//  Created by Apple on 16/10/15.
//  Copyright © 2016年 ly. All rights reserved.
//

#import "YJFileTools.h"

@implementation YJFileTools
/**
 *  @param path 要计算大小的文件夹路径
 *
 *  @return 缓存的总大小(单位字节)
 */
+ (void)getCacheSizeWithPath:(NSString *)path complete:(void(^)(NSInteger totalSize))complete
{
    // 定义缓存的总大小为0
    __block NSInteger total = 0;
    // 创建文件管理者
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    // 是否是文件夹
    BOOL isDirectory;
    // 容错处理，path必须为文件夹的路径
    BOOL isExists = [fileMgr fileExistsAtPath:path isDirectory:&isDirectory];
    // 当是文件夹并且存在的时候才计算文件夹的大小
    if (!isDirectory || !isExists) {
        // 不计算，提示使用者
        // 模仿系统抛出异常，提示开发者
        NSException *exception = [[NSException alloc] initWithName:@"乱传" reason:@"必须要传一个文件夹" userInfo:nil];
        // 抛出异常
        [exception raise];
        return;
    }
    
    // 开启子线程计算缓存的总大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",[NSThread currentThread]);
        // 获取文件夹里所有子文件的名称
        NSArray *subArr = [fileMgr subpathsAtPath:path];
        for (NSString *subName in subArr) {
            // 遍历所有子文件(包括文件夹)的名称
            //        NSLog(@"subName--%@",subName);
            // 拼接子文件的完整路径
            NSString *subPath = [path stringByAppendingPathComponent:subName];
            // 获取子文件的大小，注意：不能获取文件夹的大小
            // 获取子文件的属性字典
            NSDictionary *attrDict = [fileMgr attributesOfItemAtPath:subPath error:nil];
            // 从文件的属性字典里获取到文件的大小(单位b(字节))
            NSInteger size = [attrDict[NSFileSize] integerValue];
            total += size;
            // 回调主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"%@",[NSThread currentThread]);
                if (complete) {
                    complete(total);
                }
            });
        }

    });
}

#pragma mark - 处理缓存的大小，将缓存的大小转换成字符串
+ (NSString *)dealWhitSize:(NSInteger)total
{
    // 声明缓存大小的字符串
    NSString *totalStr = nil;
    // 将缓存的大小的单位转换成用户能看懂的GB/MB/KB
    // 单位：1GB = 1024MB(理论值) 1MB = 1024KB,1KB = 1024B
    // 硬件厂商: 1GB = 1000MB，1MB = 1000KB,1KB = 1000B
    // 判断缓存大小是否大于1GB
    if (total > 1000 * 1000 * 1000) { // 大于1GB,显示多少GB
        totalStr = [NSString stringWithFormat:@"%0.fGB",total / (1000*1000*1000.0)];
        // 10.0GB -> 10GB,去掉字符串里的.0
        totalStr = [totalStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        // 判断缓存大小是否大于1MB
    }else if (total > 1000 * 1000){ // 大于1MB,显示多少MB
        totalStr = [NSString stringWithFormat:@"%0.fMB",total / (1000*1000.0)];
        // 10.0MB -> 10MB,去掉字符串里的.0
        totalStr = [totalStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
        // 判断缓存大小是否大于1KB
    }else if (total >1000){ // 大于1KB,显示多少KB
        totalStr = [NSString stringWithFormat:@"%0.fKB",total / 1000.0];
        // 10.0KB -> 10KB,去掉字符串里的.0
        totalStr = [totalStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    }else{
        totalStr = @"0";
    }
    
    return totalStr;
    
}

/**
 *  清除某个文件夹的缓存
 *
 *  @param path 要清除的文件夹路径
 */
+ (void)clearCacheWithPath:(NSString *)path complete:(void(^)())complete
{
    // 创建文件管理者
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    // 是否是文件夹
    BOOL isDirectory;
    // 容错处理，path必须为文件夹的路径
    BOOL isExists = [fileMgr fileExistsAtPath:path isDirectory:&isDirectory];
    // 当时文件夹并且存在的时候才计算文件夹的大小
    if (!isDirectory || !isExists) {
        // 不计算，提示使用者
        // 模仿系统抛出异常，提示开发者
        NSException *exception = [[NSException alloc] initWithName:@"乱传" reason:@"必须要传一个文件夹" userInfo:nil];
        // 抛出异常
        [exception raise];
        return;
    }
    // 开启子线程计算缓存的总大小
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",[NSThread currentThread]);
        // 获取文件夹里所有子文件(或子文件夹)的名称
        NSArray *subArr = [fileMgr subpathsAtPath:path];
        for (NSString *subName in subArr) {
            // 拼接子文件的完整路径
            NSString *subPath = [path stringByAppendingPathComponent:subName];
            // 是否是文件夹
            BOOL isDirectory;
            // 删除文件，判断是否是文件及文件是否存在
            BOOL isExists = [fileMgr fileExistsAtPath:subPath isDirectory:&isDirectory];
            // 当文件存在且是文件的时候删除
            if (isExists && !isDirectory) {
                // 删除文件
                [fileMgr removeItemAtPath:subPath error:nil];
            }
            
        }
        
        
        // 回调主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSThread currentThread]);
            if (complete) {
                complete();
            }
        });
    });

}















@end
