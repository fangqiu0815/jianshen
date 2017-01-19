

#import <UIKit/UIKit.h>
@class JYHealthy;
@interface JYHealthyDetailsViewController : UIViewController
/** 帖子数据模型 */
@property (nonatomic,strong) JYHealthy *healthy;
//标题
@property(nonatomic,strong)NSString * topTitle;
/** 地址*/
@property(nonatomic,strong)NSString * url;

@end
