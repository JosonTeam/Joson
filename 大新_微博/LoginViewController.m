#import "TabbarViewController.h"
#import "LoginViewController.h"

@interface LoginViewController ()
{
    UIWebView * _webview; //webView 
}

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

#pragma mark 界面初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加WebView
    _webview = [[UIWebView alloc] initWithFrame:self.view.frame];
    _webview.scrollView.bounces = 1;
    _webview.scalesPageToFit = YES;
    _webview.delegate = self;
    
#pragma mark 加载授权页面
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL : [NSURL URLWithString : InterfaceForSinaToGetCode(AppkeyForSinaMicroblog)]];//@"http://t.cn/zR7wYV8"]];
    [request setHTTPMethod:@"POST"];
    [_webview loadRequest:request];
    [self.view addSubview:_webview];

}

#pragma mark 加载页面
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{

#pragma mark 获取access_token
    NSString * token = [GetDataOfLocalFile getContentOfTxtFileAtParh : NSDocumentDirectory
                                                          ForFileName:@"AT"];
    
    //从本地读取不到access_token时，输入账号密码登录
    if (!token)
    {
        
        if ([request.URL.absoluteString hasPrefix:RedirectURL])
        {
            
                NSString * code = [[request.URL.absoluteString componentsSeparatedByString:@"="] lastObject];
            
                //取得code，准备获取access_token
                NSMutableURLRequest * re = [[NSMutableURLRequest alloc] initWithURL : [NSURL URLWithString : InterfaceForSinaToGetAccesstoken(AppkeyForSinaMicroblog , AppsecretForSinaMicroblog , code)]];
                [re setHTTPMethod:@"POST"];
            
                //发送请求，获得回调数据
                NSData * da = [NSURLConnection sendSynchronousRequest:re
                                                    returningResponse:nil
                                                                error:nil];
            
                //得到数据,获取access_token
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:da
                                                                    options : NSJSONReadingAllowFragments
                                                                       error:nil];
            
                TabbarViewController * tabBar = [TabbarViewController new];
                tabBar.access_token = dic[@"access_token"];
                [tabBar init_View];
            
                NSString * str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString * path = [NSString stringWithFormat:@"%@/AT.txt",str];
            
                //把access_token保存到本地，方便下次登录
                [dic[@"access_token"] writeToFile:path atomically:YES
                                        encoding : NSUTF8StringEncoding
                                            error:nil];
            
                [self presentViewController:tabBar
                                   animated:YES
                                 completion:nil];
            
        }
        
    }
    
    else
    {
        
        //本地获取access_token成功，跳转到首页
        TabbarViewController * tabBar = [TabbarViewController new];
        tabBar.access_token = token;
        [tabBar init_View];
        
        [self presentViewController:tabBar
                           animated:YES
                         completion:nil];
        
    }
    
    return YES;
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    NSData * data = [NSData dataWithContentsOfURL:webView.request.URL];
////    NSLog(@"%@",data);
////    NSLog(@"%@",[[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
//    NSArray * str = [[[[[NSMutableString alloc]initWithData:data encoding:NSUTF8StringEncoding]componentsSeparatedByString:@"<video src=\""]lastObject]componentsSeparatedByString:@"\""];
//    NSLog(@"%@\t",str[0]);
//}

@end
