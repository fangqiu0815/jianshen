

#import "UIImage+Original.h"

@implementation UIImage (Original)

+(UIImage *)imageWithOriginal:(NSString *)imageName{
    UIImage * oldImage=[UIImage imageNamed:imageName];
    UIImage * originalImg=[oldImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    return originalImg;

}

@end
