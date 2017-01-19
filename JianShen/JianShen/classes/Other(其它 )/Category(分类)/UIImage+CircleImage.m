
#import "UIImage+CircleImage.h"

@implementation UIImage (CircleImage)

-(instancetype)circleImage{
    UIGraphicsBeginImageContext(self.size);
    //设置裁剪区域
    UIBezierPath * path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    [path addClip];
    [self drawAtPoint:CGPointZero];
    //绘制图片到上下文
    UIImage * circleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return circleImage;

}
@end
