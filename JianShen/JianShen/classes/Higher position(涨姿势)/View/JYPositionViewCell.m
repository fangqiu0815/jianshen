

#import "JYPositionViewCell.h"
#import "JYPosition.h"
#import "UIImageView+WebCache.h"
@interface JYPositionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *oneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *threeImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;

@end

@implementation JYPositionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

+ (instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    JYPositionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"one"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JYPositionViewCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

-(void)setPosition:(JYPosition *)position{
    self.titleLabel.text= position.title;
    self.likeCount.text=[NSString stringWithFormat:@"%ld人觉得有用",position.likecount];
   
    [self.oneImageView sd_setImageWithURL:[NSURL URLWithString:position.imglink_1]];
    self.oneImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.oneImageView.clipsToBounds = YES;

    [self.twoImageView sd_setImageWithURL:[NSURL URLWithString:position.imglink_2]];
    [self.threeImageView sd_setImageWithURL:[NSURL URLWithString:position.imglink_3]];
    
}


@end
