

#import "HealthyViewController.h"
#import "MJExtension.h"
#import "AFHTTPSessionManager.h"
#import "JYHealthy.h"
#import "JYHealthyCell.h"
#import "JYMoreHealthyCell.h"
#import "JYHealthyDetailsViewController.h"
@interface HealthyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * healthyArr;
@property(nonatomic,strong)AFHTTPSessionManager * mgr;

@end



@implementation HealthyViewController

-(NSMutableArray *)healthyArr{
    if (_healthyArr==nil) {
        _healthyArr=[NSMutableArray array];
    }
    return _healthyArr;
}

-(AFHTTPSessionManager *)mgr{
    if (_mgr==nil) {
        _mgr=[AFHTTPSessionManager  manager];
    }
    return _mgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    //设置内容cell
    [self setContentViewCell];
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
}

-(void)setupNavigationBar{
     self.title=@"吃健康";
    UIBarButtonItem * rightBtn=[UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"refresh"] heighImage:[UIImage imageNamed:@"refresh"] addTaget:self action:@selector(clickRefresh)];
    // 设置富文本属性
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    // 设置文字颜色的属性
    attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 设置富文本(带有属性的字符串)属性
    [rightBtn setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    [rightBtn setTitleTextAttributes:attrSelected forState: UIControlStateNormal];
    
    self.navigationItem.rightBarButtonItem=rightBtn;

}
-(void)clickRefresh{
   JYFunc
}


- (void)setContentViewCell{
   
    
    NSDictionary *  parameters=@{@"keyword":@"",@"npc":@"0",@"opc":@"20",@"type":@"吃健康",@"uid":@"67016"};
    
    [self.mgr GET:@"http://api.exercise.app887.com/api/Articles.action" parameters: parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.healthyArr=[JYHealthy mj_objectArrayWithKeyValuesArray:responseObject[@"root"][@"list"]];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];


}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.healthyArr.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYHealthy * healthy=self.healthyArr[indexPath.row];
    if (healthy.imglink_1==nil) {
        //选用样式1;
        JYMoreHealthyCell * cell=[JYMoreHealthyCell tableViewCellWithTableView:tableView];
        cell.eatHealthy=healthy;
        return cell;
    }else{
        JYHealthyCell * cell=[JYHealthyCell tableViewCellWithTableView:tableView];
        cell.eatHealthy=healthy;
        return cell;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYHealthy * healthy=self.healthyArr[indexPath.row];
    if (healthy.imglink_1==nil) {
        return 100;
    }else{
        return 160;
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYHealthy *healthy=self.healthyArr[indexPath.row];
    JYHealthyDetailsViewController * healthyVc=[[JYHealthyDetailsViewController alloc]init];
    healthyVc.url=healthy.url;
    healthyVc.topTitle=healthy.title;
    [self.navigationController pushViewController:healthyVc animated:YES];

}
@end
