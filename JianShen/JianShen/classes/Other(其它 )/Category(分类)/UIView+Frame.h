

#import <UIKit/UIKit.h>
/*
 分类里只能声明方法 不能声明属性
 在分类声明属性里是没有成员变量的 只有getter和setter方法
 
 
 */


@interface UIView (Frame)
//x 值
@property CGFloat jy_x;
@property CGFloat jy_y;

@property CGFloat jy_width;
@property CGFloat jy_height;

@property CGFloat jy_centerX;
@property CGFloat jy_centerY;
@end
