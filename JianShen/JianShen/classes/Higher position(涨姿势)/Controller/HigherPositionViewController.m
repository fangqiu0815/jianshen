

#import "HigherPositionViewController.h"
#import "JYPosition.h"
#import "AFHTTPSessionManager.h"
#import "MJExtension.h"
#import "JYPositionViewCell.h"
#import "JYPositionViewTwoCell.h"
#import "JYDetailsViewController.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter.h"
@interface HigherPositionViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 标题view */
@property(nonatomic,strong)UIView * titleView;

/*保存所有的标题按钮*/
@property(nonatomic,strong)NSMutableArray * titleBtns;
/*保存上一次点击的按钮*/
@property(nonatomic,strong)UIButton * preBtn;
/*下划线*/
@property(nonatomic,strong)UIView * lineView;
/** 帖子模型数组 */
@property(nonatomic,strong)NSMutableArray * positions;
//会话管理者
@property(nonatomic,strong)AFHTTPSessionManager * mgr;
@property (nonatomic,strong)NSString *sourceName;

@property(nonatomic,assign)int opcNum;

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;

@end

@implementation HigherPositionViewController

-(AFHTTPSessionManager *) mgr{
    if (_mgr==nil) {
        _mgr=[AFHTTPSessionManager manager];
    }
    return _mgr;
}



-(NSMutableArray *)titleBtns{
    if (_titleBtns==nil) {
        _titleBtns=[NSMutableArray array];
    }
    return _titleBtns;
}
static NSString * positonID=@"positionCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.opcNum = 20;
    //搭建子标题栏
    [self setupTitleView];
    //默认点击下标为0 的按钮
    [self titleBtnClick:self.titleBtns[0]];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    // 添加下拉刷新和上拉加载更多view
    [self setupRefreshView];
//    self.navigationController.navigationBar.translucent = NO;
//    self.contentTableView.rowHeight= 140 ;
//    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JYPositionViewCell class]) bundle:nil] forCellReuseIdentifier:positonID];
//    [self.contentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([JYPositionViewTwoCell class]) bundle:nil] forCellReuseIdentifier:positonID];
}

#pragma mark 搭建标题栏
-(void)setupTitleView{
    UIView * titlesView=[[UIView alloc]init];
    titlesView.backgroundColor=[UIColor whiteColor];
    self.titleView=titlesView;
    //设置frame
    titlesView.frame=CGRectMake(0, 64, JYScreenW, 35);
    [self.view addSubview:titlesView];
    // 设置tableView的内边距
    self.contentTableView.contentInset=UIEdgeInsetsMake(99, 0, 44, 0);
    //添加所有的子标题
    [self addAllTitleBtns];
    //添加下划线
    [self setupUnderLineView];
    //自定义cell分割线
    //先去掉系统的分割线
    self.contentTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
   //设置导航条内容
    [self setupNavigatitonBar];
}

// 添加下拉刷新和上拉加载更多view
-(void)setupRefreshView{
     //下拉刷新控件
    self.contentTableView.mj_header=[MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDatas)];
    //程序一启动就自动刷新
    [self.contentTableView.mj_header beginRefreshing];
    
    
    // 上拉加载更多控件
    self.contentTableView.mj_footer=[MJChiBaoZiFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDatas)];

}
#pragma mark - 请求最新数据
- (void)loadNewDatas{
    NSDictionary * parameters=@{@"keyword":@"",@"npc":@"0",@"opc":@"20",@"sourceName":self.sourceName,@"type":@"涨姿势",@"uid":@"67016"};
    [self.mgr GET:@"http://api.exercise.app887.com/api/Articles.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        self.positions=[JYPosition mj_objectArrayWithKeyValuesArray:responseObject[@"root"][@"list"]];
        
        
            [self.contentTableView reloadData];
        // 结束刷新
        [self.contentTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];

}

-(void)loadMoreDatas{
    self.opcNum+=20;
    NSString *opc = [NSString stringWithFormat:@"%d",self.opcNum];
    NSDictionary * parameters=@{@"keyword":@"",@"npc":@"0",@"opc":opc,@"sourceName":self.sourceName,@"type":@"涨姿势",@"uid":@"67016"};
    [self.mgr GET:@"http://api.exercise.app887.com/api/Articles.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        self.positions=[JYPosition mj_objectArrayWithKeyValuesArray:responseObject[@"root"][@"list"]];
        
        
        [self.contentTableView reloadData];
        // 结束刷新
        [self.contentTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];

}

#pragma mark 设置导航条内容

-(void)setupNavigatitonBar{
    UIBarButtonItem * rightItem =[UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"refresh"] heighImage:[UIImage imageNamed:@"refresh"]  addTaget:self action:@selector(clickRefresh)];
    
    self.navigationItem.rightBarButtonItem=rightItem;
    
}
-(void)clickRefresh{
    [self loadMoreDatas];

}

#pragma mark 添加下划线
-(void)setupUnderLineView{
    UIButton *titleBtn=self.titleBtns[0];
    UIView * lineView=[[UIView alloc]init];
    self.lineView=lineView;
    lineView.backgroundColor=[UIColor yellowColor];
    CGFloat lineViewH=2;
    CGFloat Y=self.titleView.jy_height-lineViewH;
    lineView.jy_height=lineViewH;
    lineView.jy_y=Y;
    // 设置下划线的宽度比文本内容宽度大10
    [titleBtn.titleLabel sizeToFit];
    lineView.jy_width=titleBtn.titleLabel.jy_width+15;
    lineView.jy_centerX=titleBtn.jy_centerX;
    [self.titleView addSubview:lineView];
}

#pragma mark 添加所有的子标题
-(void)addAllTitleBtns{
    NSArray * titles=@[@"健身知识",@"女士健身",@"瑜伽课堂"];
    CGFloat btnW=JYScreenW/titles.count;
    CGFloat btnH=self.titleView.jy_height;
    for (int i=0; i<titles.count; i++) {
        //创建标题按钮
        UIButton * titleBtn=[[UIButton alloc]init];
        titleBtn.tag=i;
        titleBtn.frame=CGRectMake(i*btnW, 0, btnW, btnH);
        [titleBtn setTitle:titles[i] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
        [self.titleView addSubview:titleBtn];
        //保存标题按钮
        [self.titleBtns addObject:titleBtn];
        //添加点击事件
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchDown];
    }
  
}
#pragma mark  点击事件调用

-(void)titleBtnClick:(UIButton *)titlebtn{
    //判断标题按钮是否重复点击
    if (titlebtn==self.preBtn) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"JYTitleBtnRepeatClickNotification" object:nil];
    }
    self.preBtn.selected=NO;
    titlebtn.selected=YES;
    self.preBtn=titlebtn;

//    NSInteger tag=titlebtn.tag;
    //处理下划线的移动
    [UIView animateWithDuration:0.25 animations:^{
        self.lineView.jy_width=titlebtn.titleLabel.jy_width+15;
        self.lineView.jy_centerX=titlebtn.jy_centerX;
    }];
    //设置导航条的标题
    self.title = titlebtn.currentTitle;
    // 开启数据下载 使用afn -- >  下载完成，数据显示到tableview上
    if (titlebtn.tag==0) {
        self.sourceName = @"健身知识";
        // ?keyword=&npc=0&opc=20&sourceName=健身知识&type=涨姿势&uid=67016
    }else if (titlebtn.tag==1){
        self.sourceName = @"女士健身";
        //?keyword=&npc=0&opc=20&sourceName=女士健身&type=涨姿势&uid=67016
    }else if (titlebtn.tag==2){
        self.sourceName = @"瑜伽课堂";
    }
    NSString *opc = [NSString stringWithFormat:@"%d",self.opcNum];
    //?keyword=&npc=0&opc=20&sourceName=瑜伽课堂&type=涨姿势&uid=67016
    NSDictionary * parameters=@{@"keyword":@"",@"npc":@"0",@"opc":opc,@"sourceName":self.sourceName,@"type":@"涨姿势",@"uid":@"67016"};
    [self.mgr GET:@"http://api.exercise.app887.com/api/Articles.action" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject---%@",responseObject);
        self.positions=[JYPosition mj_objectArrayWithKeyValuesArray:responseObject[@"root"][@"list"]];
     
        [self.contentTableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error--%@",error);
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.positions.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JYPosition * position=self.positions[indexPath.row];
    // 根据这个变量是否有值去区分开
    if (position.imglink_1 == nil) {
        // 选用cell1
        JYPositionViewTwoCell *cell=[JYPositionViewTwoCell tableViewCellWithTableView:tableView];
        cell.position=position;
        return cell;
    }else{
        // 选用cell2
        JYPositionViewCell * cell=[JYPositionViewCell tableViewCellWithTableView:tableView];
        cell.position=position;
        return  cell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JYPosition * position=self.positions[indexPath.row];
    if (position.imglink_1 == nil) {
        return 100;
    }else{
        return 160;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   JYPosition * position=self.positions[indexPath.row];
    JYDetailsViewController * detailsVc=[[JYDetailsViewController alloc]init];
    detailsVc.topTitle=position.title;
    detailsVc.url=position.url;
    
    [self.navigationController pushViewController:detailsVc animated:YES];
    
}
@end
