

#import "JYPictureOneViewController.h"

@interface JYPictureOneViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *contentWebView;

@end

@implementation JYPictureOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"看视频";
    NSString *basePath = @"http://api.exercise.app887.com/exercise/";
    // 开启网络数据的加载
    NSString *urlPath = [NSString stringWithFormat:@"%@%@.html",basePath,self.type];
    NSURL * url =[NSURL URLWithString:urlPath];
 
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [self.contentWebView loadRequest:request];
   
    [self setupNavigationBar];
}

-(void)setupNavigationBar{
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share"] style:0 target:self action:@selector(clickShare)];
    
}

-(void)clickShare{
    JYFunc

}
@end
