

#import <UIKit/UIKit.h>
@class JYHealthy;
@interface JYHealthyCell : UITableViewCell

@property(nonatomic,strong)JYHealthy * eatHealthy;
+(instancetype)tableViewCellWithTableView:(UITableView *)tableView;
@end
