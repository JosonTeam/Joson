#import "TabbarViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
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
    _webview = [[UIWebView alloc]initWithFrame:self.view.frame];
    _webview.scrollView.bounces = 1 ;
    _webview.delegate = self;
    _webview.scalesPageToFit = YES;
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:InterfaceForSinaToGetCode(AppkeyForSinaMicroblog)]];
    [request setHTTPMethod:@"POST"];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    if ([request.URL.absoluteString hasPrefix:RedirectURL])
//    {
//       NSString * code = [[request.URL.absoluteString componentsSeparatedByString:@"="]lastObject];
//        
//        NSMutableURLRequest * re = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:InterfaceForSinaToGetAccesstoken(AppkeyForSinaMicroblog, AppsecretForSinaMicroblog, code)]];
//        [re setHTTPMethod:@"POST"];
//        NSData * da = [NSURLConnection sendSynchronousRequest:re returningResponse:nil error:nil];
//        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:da options:NSJSONReadingAllowFragments error:nil];
    
        TabbarViewController * tabBar = [TabbarViewController new];
        tabBar.access_token = @"2.00WZkEoBGfkwgCe225676bb60AP1JZ";//dic[@"access_token"];

        [self presentViewController:tabBar animated:YES completion:nil];
//    }
    
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
