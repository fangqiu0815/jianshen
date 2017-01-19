
#import "JYHealthyDetailsViewController.h"
#import "YJTopicSQLTools.h"
@interface JYHealthyDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation JYHealthyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.topTitle;
    [self setupNavigationBar];
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSURL * url=[NSURL URLWithString:self.url];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [self.contentWebView loadRequest:request];
    
}



-(void)setupNavigationBar{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:0 target:self action:@selector(clickShare)];

}

-(void)clickShare{

   JYFunc
}

//点击有用时调用
- (IBAction)ThumbupClick:(UIButton *)sender {
    JYFunc
    
}
- (IBAction)collectionClick:(UIButton *)sender {
    [YJTopicSQLTools saveHealthy:self.healthy];
    
}
@end
