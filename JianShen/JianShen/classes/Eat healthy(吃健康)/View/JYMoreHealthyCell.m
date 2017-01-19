

#import "JYMoreHealthyCell.h"
#import "JYHealthy.h"
#import "UIImageView+WebCache.h"
@interface JYMoreHealthyCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;

@end
@implementation JYMoreHealthyCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

-(void)setEatHealthy:(JYHealthy *)eatHealthy{
    self.titleLabel.text=eatHealthy.title;
    self.subTitleLabel.text=[NSString stringWithFormat:@"%ld人觉得有用",eatHealthy.likecount];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:eatHealthy.imglink]];

}

+(instancetype)tableViewCellWithTableView:(UITableView *)tableView{
    JYMoreHealthyCell *  cell=[tableView dequeueReusableCellWithIdentifier:@"MoreHealthy"];
    if (cell==nil) {
        cell=[[NSBundle mainBundle]loadNibNamed:@"JYMoreHealthyCell" owner:nil options:nil].lastObject;
    }
    return  cell;
}
@end
