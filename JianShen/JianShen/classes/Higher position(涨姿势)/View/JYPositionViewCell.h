

#import <UIKit/UIKit.h>
@class JYPosition;
@interface JYPositionViewCell : UITableViewCell
@property(nonatomic,strong)JYPosition * position;

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

@end
