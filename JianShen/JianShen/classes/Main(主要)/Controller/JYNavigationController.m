

#import "JYNavigationController.h"
#import "UIBarButtonItem+Item.h"
@interface JYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation JYNavigationController



- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航条的背景颜色
    self.navigationBar.barTintColor=[UIColor yellowColor];
    self.interactivePopGestureRecognizer.delegate=self;
}

//是否接受手势

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (self.childViewControllers.count>1) {
        return YES;
    }else{
        return NO;
    }
   
}

//重写 push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    //在非根控制器中判断
    //判断 子控制器的数量是否大于0
    //设置返回按钮
    if (self.childViewControllers.count>0) {
        viewController.navigationItem.leftBarButtonItem=[UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"navigationButtonReturn"] heighImage:[UIImage imageNamed:@"navigationButtonReturnClick"] addTaget:self action:@selector(backClick)];
        viewController.hidesBottomBarWhenPushed=YES;
    }
    //再调用父类的方法 这里才是真正的跳转 这里才会添加导航控制器的子控制器
    //执行完 这串代码 count会变成1；
    [super pushViewController:viewController animated:animated];

}

-(void)backClick{
   [self popViewControllerAnimated:YES];

}

+(void)load{
    //获取导航条全局对象
    UINavigationBar * navBar=[UINavigationBar appearanceWhenContainedIn:[self class], nil];
    //创建属性字典
    NSMutableDictionary * attDict=[NSMutableDictionary dictionary];
    attDict[NSFontAttributeName]=[UIFont systemFontOfSize:18];
    attDict[NSForegroundColorAttributeName]=[UIColor blackColor];
    
    // 设置富文本属性
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    // 设置文字颜色的属性
    attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    
    
    
    [navBar setTitleTextAttributes:attDict];
    UITabBarItem *item = [UITabBarItem appearance];
    NSMutableDictionary *normalDic = [NSMutableDictionary dictionary];
    normalDic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [item setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    NSMutableDictionary *selectedDic = [NSMutableDictionary dictionary];
    selectedDic[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:selectedDic forState:UIControlStateSelected];
    
    
    
}






















@end
