

#import "SkillDetailsViewController.h"

@interface SkillDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *skillWebView;

@end

@implementation SkillDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=self.headTitle;
    [self setupNavigationBar];
    self.automaticallyAdjustsScrollViewInsets=NO;
    NSURL *url=[NSURL URLWithString:self.url];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [self.skillWebView loadRequest:request];
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
    
    JYFunc
}
@end
