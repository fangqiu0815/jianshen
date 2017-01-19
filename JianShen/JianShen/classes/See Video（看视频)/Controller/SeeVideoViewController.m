

#import "SeeVideoViewController.h"
#import "JYPictureOneViewController.h"
@interface SeeVideoViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *seeWebView;

@end

@implementation SeeVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"看视频";
    NSURL *url=[[NSBundle mainBundle]URLForResource:@"index" withExtension:@"html"];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    self.seeWebView.delegate=self;
    [self.seeWebView loadRequest:request];
    [self setupNavigatitonBar];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    NSString * scheme=@"jianshen://";
    NSString * requestStr=request.URL.absoluteString;
    if ([requestStr hasPrefix:scheme]) {
        NSString * str=[requestStr lastPathComponent];
        
        NSString * params=[str substringFromIndex:12];
        NSString * method=[str substringToIndex:11];
        method=[method stringByAppendingString:@":"];
        SEL sel=NSSelectorFromString(method);
        [self performSelector:sel withObject:params];
        
        
//        NSString *params = [str substringFromIndex:12];
//        NSString *method = [str substringToIndex:11];
//        method = [method stringByAppendingString:@":"];
//        SEL sel=NSSelectorFromString(method);
//        [self performSelector:sel withObject:params];
//        [self performSelector:sel];
        return NO;
    }
    
    return YES;
}

- (void)jumpPicture:(NSString *)type{
    NSLog(@"type = %@",type);
    JYPictureOneViewController * picOneVc=[[JYPictureOneViewController alloc]init];
    picOneVc.type = type;
    [self.navigationController pushViewController:picOneVc animated:YES];
    
}

#pragma mark 设置导航条内容

//-(void)setupNavigatitonBar{
//    UIBarButtonItem * rightBtn=[[UIBarButtonItem alloc]init];
//    rightBtn.image=[UIImage imageNamed:@"refresh"];
//    //添加到导航条上
//    self.navigationItem.rightBarButtonItem=rightBtn;
//    
//    
//}


-(void)setupNavigatitonBar{
    UIBarButtonItem * rightItem =[UIBarButtonItem creatItemWithImage:[UIImage imageNamed:@"refresh"] heighImage:[UIImage imageNamed:@"refresh"]  addTaget:self action:@selector(clickRefresh)];
    
    self.navigationItem.rightBarButtonItem=rightItem;
    
}


-(void)clickRefresh{

   JYFunc
}
//
//- (void)jumpPicture2{
//    JYPictureOneViewController * picOneVc=[[JYPictureOneViewController alloc]init];
//    [self.navigationController pushViewController:picOneVc animated:YES];
//    
//}
//
//- (void)jumpPicture3{
//    JYPictureOneViewController * picOneVc=[[JYPictureOneViewController alloc]init];
//    [self.navigationController pushViewController:picOneVc animated:YES];
//    
//}
//
//- (void)jumpPicture4{
//    JYPictureOneViewController * picOneVc=[[JYPictureOneViewController alloc]init];
//    [self.navigationController pushViewController:picOneVc animated:YES];
//    
//}
//
//- (void)jumpPicture5{
//    JYPictureOneViewController * picOneVc=[[JYPictureOneViewController alloc]init];
//    [self.navigationController pushViewController:picOneVc animated:YES];
//    
//}
//
//- (void)jumpPicture6{
//    JYPictureOneViewController * picOneVc=[[JYPictureOneViewController alloc]init];
//    [self.navigationController pushViewController:picOneVc animated:YES];
//    
//}
//
//- (void)jumpPicture7{
//    JYPictureOneViewController * picOneVc=[[JYPictureOneViewController alloc]init];
//    [self.navigationController pushViewController:picOneVc animated:YES];
//    
//}

@end
