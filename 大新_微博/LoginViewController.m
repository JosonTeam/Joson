#import "TabbarViewController.h"
#import "LoginViewController.h"
#import "JSKit.h"

@interface LoginViewController ()
{
    UIWebView * _webview;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加WebView
    _webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    _webview.scrollView.bounces = 1 ;
    _webview.delegate = self;
    _webview.scalesPageToFit = YES;
    
#pragma mark 加载授权页面
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:InterfaceForSinaToGetCode(AppkeyForSinaMicroblog)]];
    [request setHTTPMethod:@"POST"];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
#pragma mark 获取access_token
    NSString * token = [GetDataOfLocalFile getContentOfTxtFileAtParh:NSDocumentDirectory ForFileName:@"AT"];
    
    //从本地读取不到access_token时，输入账号密码登录
    if (!token)
    {
        if ([request.URL.absoluteString hasPrefix:RedirectURL])
        {
                NSString * code = [[request.URL.absoluteString componentsSeparatedByString:@"="]lastObject];
            
                //取得code，准备获取access_token
                NSMutableURLRequest * re = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:InterfaceForSinaToGetAccesstoken(AppkeyForSinaMicroblog, AppsecretForSinaMicroblog, code)]];
                [re setHTTPMethod:@"POST"];
                NSData * da = [NSURLConnection sendSynchronousRequest:re returningResponse:nil error:nil];
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:da options:NSJSONReadingAllowFragments error:nil];
            
                TabbarViewController * tabBar = [TabbarViewController new];
                tabBar.access_token = dic[@"access_token"];
                [tabBar init_View];
            
                NSString * str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
                NSString * path = [NSString stringWithFormat:@"%@/AT.txt",str];
            
                //把access_token保存到本地，方便下次登录
                [dic[@"access_token"] writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
            
                [self presentViewController:tabBar animated:YES completion:nil];
        }
    }
    else
    {
        //本地获取access_token成功，跳转到首页
        TabbarViewController * tabBar = [TabbarViewController new];
        tabBar.access_token = token;
        [tabBar init_View];
        [self presentViewController:tabBar animated:YES completion:nil];
    }
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
