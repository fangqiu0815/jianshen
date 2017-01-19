

#import "JYDetailsViewController.h"

@interface JYDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation JYDetailsViewController

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
// 点击导航条分享按钮时调用
-(void)clickShare{
   
  JYFunc
}
//点击有用时调用
- (IBAction)ThumbupBtn:(UIButton *)sender {
}
- (IBAction)collectionBtn:(id)sender {
}
@end
