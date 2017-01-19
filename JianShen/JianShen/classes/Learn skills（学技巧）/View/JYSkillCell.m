
#import "JYSkillCell.h"
#import "JYSkill.h"
#import "UIImageView+WebCache.h"
@interface JYSkillCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end

@implementation JYSkillCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
}

-(void)setSkill:(JYSkill *)skill{
    _skill=skill;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:skill.imglink]];
    self.titleLabel.text=skill.title;
    self.subTitleLabel.text=[NSString stringWithFormat:@"%@人觉得有用",skill.likecount];


}

@end
