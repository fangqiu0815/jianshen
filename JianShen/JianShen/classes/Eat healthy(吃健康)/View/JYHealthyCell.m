
#import "JYHealthyCell.h"
#import "JYHealthy.h"
#import "UIImageView+WebCache.h"
@interface JYHealthyCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *iconThreeImageView;

@end

@implementation JYHealthyCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

-(void)setEatHealthy:(JYHealthy *)eatHealthy{
    self.titleLabel.text=eatHealthy.title;
    self.subTitleLabel.text=[NSString stringWithFormat:@"%ld人觉得有用",eatHealthy.likecount];
    [self.iconOneImageView sd_setImageWithURL:[NSURL URLWithString:eatHealthy.imglink_1]];
    [self.iconTwoImageView sd_setImageWithURL:[NSURL URLWithString:eatHealthy.imglink_2]];
    [self.iconThreeImageView sd_setImageWithURL:[NSURL URLWithString:eatHealthy.imglink_3]];


}
+(instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    JYHealthyCell *  cell=[tableView dequeueReusableCellWithIdentifier:@"healthy"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"JYHealthyCell" owner:nil options:nil].lastObject;
    }
    return  cell;
}

@end
