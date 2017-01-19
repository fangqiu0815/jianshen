

#import <UIKit/UIKit.h>
@class JYPosition;
@interface JYPositionViewTwoCell : UITableViewCell
@property(nonatomic,strong)JYPosition * position;

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView;

@end
