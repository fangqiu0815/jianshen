

#import <Foundation/Foundation.h>

@interface YJFileTools : NSObject
/**
 *  @param path 要计算大小的文件夹路径
 *
 *  @return 缓存的总大小(单位字节)
 */
+ (void)getCacheSizeWithPath:(NSString *)path complete:(void(^)(NSInteger totalSize))complete;

/**
 *  处理缓存的大小，将缓存的大小转换成字符串
 *
 *  @param total 缓存的大小(单位b)
 *  @return 处理后的字符串
 */
+ (NSString *)dealWhitSize:(NSInteger)total;

/**
 *  清除某个文件夹的缓存
 *
 *  @param path 要清除的文件夹路径
 */
+ (void)clearCacheWithPath:(NSString *)path complete:(void(^)())complete;

















@end
