

#import "UIView+Frame.h"

@implementation UIView (Frame)


-(void)setJy_x:(CGFloat)jy_x{
    CGRect frame=self.frame;
    frame.origin.x=jy_x;
    //设置 UIView的x值
    self.frame=frame;
}

-(CGFloat)jy_x{
    //返回UIView的x值
    return self.frame.origin.x;
}

-(void)setJy_y:(CGFloat)jy_y{
    CGRect frame=self.frame;
    frame.origin.y=jy_y;
    //设置 UIView的x值
    self.frame=frame;
}

-(CGFloat)jy_y{
    //返回UIView的x值
    return self.frame.origin.y;
}
//设置 width
-(void)setJy_width:(CGFloat)jy_width{

    CGRect frame=self.frame;
    frame.size.width=jy_width;
    //设置 UIView的x值
    self.frame=frame;
}

-(CGFloat)jy_width{
    return self.frame.size.width;
}

//设置 height
-(void)setJy_height:(CGFloat)jy_height{
    
    CGRect frame=self.frame;
    frame.size.height=jy_height;
    //设置 UIView的x值
    self.frame=frame;
}

-(CGFloat)jy_height{
    return self.frame.size.height;
}

//设置centerX
-(void)setJy_centerX:(CGFloat)jy_centerX{
    CGPoint center=self.center;
    center.x=jy_centerX;
    //设置 UIView的x值
    self.center=center;
}
-(CGFloat)jy_centerX{
    return  self.center.x;
}


//设置centerX
-(void)setJy_centerY:(CGFloat)jy_centerY{
    CGPoint center=self.center;
    center.y=jy_centerY;
    //设置 UIView的centery值
    self.center=center;
}
-(CGFloat)jy_centerY{
    return  self.center.y;
}
@end
