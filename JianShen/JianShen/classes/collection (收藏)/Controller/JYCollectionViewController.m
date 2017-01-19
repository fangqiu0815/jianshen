

#import "JYCollectionViewController.h"
#import "JYSettingViewController.h"
#import "YJTopicSQLTools.h"
#import "JYHealthy.h"
#import "JYHealthyCell.h"
#import "JYMoreHealthyCell.h"
@interface JYCollectionViewController ()<UITableViewDelegate,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray * collectionArr;
@end

@implementation JYCollectionViewController

-(NSMutableArray *)collectionArr{

    if (_collectionArr==nil) {
        _collectionArr=[NSMutableArray array];
    }
    return _collectionArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我收藏";
    [self setupNavigationBar];
    self.tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
    self.collectionArr=[YJTopicSQLTools topics];
}

-(void)setupNavigationBar{
    UIBarButtonItem * leftBtn=[UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] heighImage:[UIImage imageNamed:@"mine-setting-icon-click"] addTaget:self action:@selector(settingInstall)];
    self.navigationItem.leftBarButtonItem=leftBtn;

}

-(void)settingInstall{
    JYSettingViewController * settingVC=[[JYSettingViewController alloc]init];
    [self.navigationController pushViewController:settingVC animated:YES];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return   self.collectionArr.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    JYHealthy * healthy=self.collectionArr[indexPath.row];
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYHealthy * healthy=self.collectionArr[indexPath.row];
    if (healthy.imglink_1==nil) {
        return 100;
    }else{
        return 160;
    }
    
}
@end
