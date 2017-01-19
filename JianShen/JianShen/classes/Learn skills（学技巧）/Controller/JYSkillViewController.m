

#import "JYSkillViewController.h"
#import "JYSkill.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "JYSkillCell.h"
#import "UIBarButtonItem+Item.h"
#import "SkillDetailsViewController.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
@interface JYSkillViewController ()<UITableViewDelegate,UITableViewDelegate>
/** 帖子模型数组 */
@property(nonatomic,strong)NSMutableArray * skillArr;
//会话管理者
@property(nonatomic,strong)AFHTTPSessionManager * mgr;

@property(nonatomic,assign)int opcNum;
@end

@implementation JYSkillViewController

-(AFHTTPSessionManager * )mgr{
    if (_mgr==nil) {
        _mgr=[AFHTTPSessionManager manager];
    }
    return _mgr;
}

-(NSMutableArray *)skillArr{
    if (_skillArr==nil) {
        _skillArr=[NSMutableArray array];
    }
    return _skillArr;
}

static NSString * skillID=@"skillCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.opcNum=20;
    self.title=@"学技巧";
    [self setContentCell];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([JYSkillCell class]) bundle:nil] forCellReuseIdentifier:skillID];
    self.tableView.rowHeight=100;
    //设置导航条内容
    [self setupNavigatitonBar];
    //刷新数据
    [self setupRefreshView];
}
#pragma mark - 刷新数据

-(void)setupRefreshView{
    self.tableView.mj_header=[MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    
   self.tableView.mj_footer=[MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];
}

-(void)loadNewDatas{
     NSString *opc=[NSString stringWithFormat:@"%d",self.opcNum];
    //  keyword=&npc=0&opc=20&type=学技巧&uid=67016
    NSDictionary * parameters=@{@"keyword":@"",@"npc":@"0",@"opc":@"20",@"type":@"学技巧",@"uid":@"67016",};
    [self.mgr GET:@"http://api.exercise.app887.com/api/Articles.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject---%@",responseObject);
        self.skillArr=[JYSkill mj_objectArrayWithKeyValuesArray:responseObject[@"root"][@"list"]];
        //回到主线程更新tableview；
       
            [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        

    }];

}

-(void)loadMoreDatas{
    self.opcNum+=20;
    NSString *opc=[NSString stringWithFormat:@"%d",self.opcNum];
    //  keyword=&npc=0&opc=20&type=学技巧&uid=67016
    NSDictionary * parameters=@{@"keyword":@"",@"npc":@"0",@"opc":opc,@"type":@"学技巧",@"uid":@"67016",};
    [self.mgr GET:@"http://api.exercise.app887.com/api/Articles.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject---%@",responseObject);
        self.skillArr=[JYSkill mj_objectArrayWithKeyValuesArray:responseObject[@"root"][@"list"]];
    
            [self.tableView reloadData];
       
             [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
    }];

}
#pragma mark -设置导航条内容

-(void)setupNavigatitonBar{
    UIBarButtonItem * rightItem =[UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"refresh"] heighImage:[UIImage imageNamed:@"refresh"]  addTaget:self action:@selector(clickRefresh)];
   
    self.navigationItem.rightBarButtonItem=rightItem;

}

-(void)clickRefresh{

   JYFunc
}

#pragma mark -   设置cell
-(void)setContentCell{
    NSString *opc=[NSString stringWithFormat:@"%d",self.opcNum];
    
    //  keyword=&npc=0&opc=20&type=学技巧&uid=67016
    NSDictionary * parameters=@{@"keyword":@"",@"npc":@"0",@"opc":@"20",@"type":@"学技巧",@"uid":@"67016",};
    [self.mgr GET:@"http://api.exercise.app887.com/api/Articles.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
         NSLog(@"responseObject---%@",responseObject);
        self.skillArr=[JYSkill mj_objectArrayWithKeyValuesArray:responseObject[@"root"][@"list"]];
        //回到主线程更新tableview；
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
        
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];

}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.skillArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSkillCell * cell=[tableView dequeueReusableCellWithIdentifier:skillID];
    JYSkill * skill=self.skillArr[indexPath.row];
    cell.skill=skill;
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    JYSkill * skill=self.skillArr[indexPath.row];
    SkillDetailsViewController * skillDetaVc=[[SkillDetailsViewController alloc]init];
    skillDetaVc.headTitle=skill.title;
    skillDetaVc.url=skill.url;
    [self.navigationController pushViewController:skillDetaVc animated:YES];
    

}

@end
