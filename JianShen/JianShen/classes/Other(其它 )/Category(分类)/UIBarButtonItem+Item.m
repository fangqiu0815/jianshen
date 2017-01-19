

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (Item)

+(UIBarButtonItem *)creatItemWithImage:(UIImage*)image heighImage:(UIImage *)heighImage addTaget:(id)taget action:(SEL)action{
    UIButton * btn=[[UIButton alloc]init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:heighImage forState:UIControlStateHighlighted];
    
    [btn addTarget:taget action:action forControlEvents:UIControlEventTouchDown];
    [btn sizeToFit];
    UIBarButtonItem * item=[[UIBarButtonItem alloc]initWithCustomView:btn];
    return item;
}

@end
