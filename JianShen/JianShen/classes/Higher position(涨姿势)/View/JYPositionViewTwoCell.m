

#import "JYPositionViewTwoCell.h"
#import "JYPosition.h"
#import "UIImageView+WebCache.h"
@interface JYPositionViewTwoCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end
@implementation JYPositionViewTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    JYPositionViewTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"two"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JYPositionViewTwoCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setPosition:(JYPosition *)position{
    self.titleLabel.text= position.title;
    self.subTitleLabel.text=[NSString stringWithFormat:@"%ld人觉得有用",position.likecount];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:position.imglink]];
    self.iconImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.iconImageView.clipsToBounds = YES;

}

@end
