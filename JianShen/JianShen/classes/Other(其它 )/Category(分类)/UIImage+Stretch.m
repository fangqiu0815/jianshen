
#import "UIImage+Stretch.h"

@implementation UIImage (Stretch)
// 设置图片的拉伸区域(以中心区域拉伸)
-(instancetype)stretchCenter{
    return [self stretchableImageWithLeftCapWidth:self.size.width*0.5 topCapHeight:self.size.height * 0.5];
}










@end
