

#import <Foundation/Foundation.h>

@interface JYHealthy : NSObject
///** id */
@property (nonatomic,assign) NSInteger ID;
/** 图1 */
@property(nonatomic,strong)NSString * imglink_1;
/** 图2 */
@property(nonatomic,strong)NSString * imglink_2;
/** 图3 */
@property(nonatomic,strong)NSString * imglink_3;

/** 图4 */
@property(nonatomic,strong)NSString * imglink;
/** 地址*/
@property(nonatomic,strong)NSString * url;
//喜欢数
@property(nonatomic,assign)NSInteger likecount;
//标题
@property(nonatomic,strong)NSString * title;
@end
