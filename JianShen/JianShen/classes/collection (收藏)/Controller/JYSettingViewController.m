

#import "JYSettingViewController.h"
#import "YJFileTools.h"
#import "SVProgressHUD.h"
@interface JYSettingViewController ()
{
    NSInteger _totalSize;
    NSString * _cachePath;

}
@end

@implementation JYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title=@"设置";
   
    [self setupNavigationBar];
    //获取沙盒的缓存文件夹的路径
    _cachePath=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
  // 提示用户正在计算缓存的大小
    [SVProgressHUD showInfoWithStatus:@"正在拼命计算缓存大小中..."];
    //获取缓存大小
    [YJFileTools getCacheSizeWithPath:_cachePath complete:^(NSInteger totalSize) {
        [SVProgressHUD dismiss];
        //计算缓存大小完成
        _totalSize=totalSize;
        //刷新tableview
        [self.tableView reloadData];
    }];
}

-(void)setupNavigationBar{
    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStyleDone target:self action:@selector(clickMore)];
    // 设置富文本属性
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    // 设置文字颜色的属性
    attrSelected[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // 设置富文本(带有属性的字符串)属性
    [rightBtn setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    [rightBtn setTitleTextAttributes:attrSelected forState: UIControlStateNormal];

    self.navigationItem.rightBarButtonItem=rightBtn;
}

-(void)clickMore{
   JYFunc


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 5;
    }else{
       return 2;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * ID=@"cell";
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.section==0) {
        if (indexPath.row==0) {
           cell.textLabel.text=@"意见反馈";
        }else if (indexPath.row==1){
          cell.textLabel.text=@"评分";
        
        }else if (indexPath.row==2){
            cell.textLabel.text=@"版本号";
        }else if (indexPath.row==3){
            cell.textLabel.text=@"通知";
        }else if (indexPath.row==4){
            if (_totalSize==0) {
                 cell.textLabel.text=@"缓存清理完毕";
            }else{
            cell.textLabel.text=[NSString stringWithFormat:@"清除缓存 %@",[YJFileTools dealWhitSize:_totalSize]];
            }
        }
        
        
      
    }else{
        if (indexPath.row==0) {
            cell.textLabel.text=@"设置头像";
        }else{
            cell.textLabel.text=@"修改昵称";
        }
    
    }
    
    if (indexPath.row == 2) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        label.text=@"1.1.6";
        cell.accessoryView = label;
    }else if (indexPath.row == 3){
        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
       
        cell.accessoryView = sw;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}
//设置每个组头的高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section NS_AVAILABLE_IOS(7_0){
    if(section==0){
        return 44;
    }else{
        return 30;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==4) {
             // 清除缓存
            [YJFileTools clearCacheWithPath:_cachePath complete:^{
                //清除成功之后提示用户
                [SVProgressHUD showSuccessWithStatus:@"清除缓存成功"];
                 // 设置缓存大小为0
                _totalSize=0;
                [self.tableView reloadData];
            }];
        }
    }

}


@end
