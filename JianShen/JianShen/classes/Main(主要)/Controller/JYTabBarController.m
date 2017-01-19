

#import "JYTabBarController.h"
#import "JYCollectionViewController.h"
#import "HealthyViewController.h"
#import "HigherPositionViewController.h"
#import "JYSkillViewController.h"
#import "SeeVideoViewController.h"
#import "JYNavigationController.h"
@interface JYTabBarController ()

@end

@implementation JYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置所有子控件
    [self setupAllChildVc];
    //设置所有子控制器的内容
    [self setupAllTabBarButton];
}

//设置所有子控件
-(void)setupAllChildVc{
   //涨姿势
    HigherPositionViewController * positionVC=[[HigherPositionViewController alloc]init];
    JYNavigationController * nav0=[[JYNavigationController alloc]initWithRootViewController:positionVC];
    [self addChildViewController:nav0];
   //学技巧
    JYSkillViewController * skillVC=[[JYSkillViewController alloc]init];
    JYNavigationController * nav1=[[JYNavigationController alloc]initWithRootViewController:skillVC];
    [self addChildViewController:nav1];
    
    
    //看视频
    SeeVideoViewController * seeVC=[[SeeVideoViewController alloc]init];
    JYNavigationController * nav2=[[JYNavigationController alloc]initWithRootViewController:seeVC];
    [self addChildViewController:nav2];
   //吃健康
    HealthyViewController * healthyVC=[[HealthyViewController alloc]init];
    JYNavigationController * nav3=[[JYNavigationController alloc]initWithRootViewController:healthyVC];
    [self addChildViewController:nav3];
    //收藏
    JYCollectionViewController * collectionVC=[[JYCollectionViewController alloc]init];
    JYNavigationController * nav4=[[JYNavigationController alloc]initWithRootViewController:collectionVC];
    [self addChildViewController:nav4];
    
}

-(void)setupAllTabBarButton{
    UINavigationController  * nav0=self.childViewControllers[0];
    //标题
    nav0.tabBarItem.title=@"涨姿势";
    //图片
    nav0.tabBarItem.image=[UIImage imageNamed:@"zhishi"];
    //设置图片的渲染模式
    //图片选中状态
    nav0.tabBarItem.selectedImage=[UIImage imageWithOriginal:@"zhishi_1"];
    
    UINavigationController  * nav1=self.childViewControllers[1];
    //标题
    nav1.tabBarItem.title=@"学技巧";
    //图片
    nav1.tabBarItem.image=[UIImage imageNamed:@"jiqiao"];
    //设置图片的渲染模式
    //图片选中状态
    nav1.tabBarItem.selectedImage=[UIImage imageWithOriginal:@"jiqiao_1"];
    
    
    UINavigationController  * nav2=self.childViewControllers[2];
    //标题
    nav2.tabBarItem.title=@"看视频";
    //图片
    nav2.tabBarItem.image=[UIImage imageNamed:@"video"];
    //设置图片的渲染模式
    //图片选中状态
    nav2.tabBarItem.selectedImage=[UIImage imageWithOriginal:@"video_1"];
    
    UINavigationController  * nav3=self.childViewControllers[3];
    //标题
    nav3.tabBarItem.title=@"吃健康";
    //图片
    nav3.tabBarItem.image=[UIImage imageNamed:@"food"];
    //设置图片的渲染模式
    //图片选中状态
    nav3.tabBarItem.selectedImage=[UIImage imageWithOriginal:@"food_1"];
    

    
    UINavigationController  * nav4=self.childViewControllers[4];
    //标题
    nav4.tabBarItem.title=@"我收藏";
  
    //图片
    nav4.tabBarItem.image=[UIImage imageNamed:@"my"];
    //设置图片的渲染模式
    //图片选中状态
    nav4.tabBarItem.selectedImage=[UIImage imageWithOriginal:@"my_1"];



}






















@end
