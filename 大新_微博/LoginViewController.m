#import "TabbarViewController.h"
#import "LoginViewController.h"
#import "AlartViewController.h"

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

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    AlartViewController * alar = [AlartViewController new];
    [alar showView:self];
    
}

- (void)positiveButtonAction
{
    
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL : [NSURL URLWithString : InterfaceForSinaToGetCode(AppkeyForSinaMicroblog)]];//@"http://t.cn/zR7wYV8"]];
    [request setHTTPMethod:@"POST"];
    [_webview loadRequest:request];
    
}

- (void)negativeButtonAction
{
    exit(0);
}

- (void)closeButtonAction
{
    
}

- (void)welcome:(NSDictionary *)dic
{
    
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    int _width = [widthAndHigh[0] intValue];
    
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    [imageView setImage : [UIImage imageNamed:@"Default-568h@2x.png"]];
    
    UIImageView * TXimage = [[UIImageView alloc] initWithFrame : CGRectMake(_width-200, 80, 70, 70)];
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:dic[@"avatar_hd"]]] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         
         [TXimage setImage:[UIImage imageWithData:data]];
         
     }];
    
    TXimage.layer.masksToBounds = YES;
    TXimage.layer.cornerRadius = 35;
    [imageView addSubview:TXimage];
    
    UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(0, 160, _width, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = dic[@"name"];
    [imageView addSubview:label];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame : CGRectMake(0, 200, _width, 50)];
    label1.text = @"欢迎回来";
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont systemFontOfSize:30];
    [imageView addSubview:label1];
    
    [self.view addSubview:imageView];

}

#pragma mark 加载页面
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{

#pragma mark 获取access_token
    NSString * token = [GetDataOfLocalFile getContentOfTxtFileAtParh : NSDocumentDirectory
                                                          ForFileName:@"AT"];
    
    NSDictionary * dic1;
    
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
            
                dic1 = [MicroBlogOperateForSina getDetailOfUserWithAccessToken:dic[@"access_token"]
                                                                          name:nil
                                                                         orId : [MicroBlogOperateForSina getIdWithAccessToken:dic[@"access_token"]][@"uid"]];
            
            
                [self welcome:dic1];

                TabbarViewController * tabBar = [TabbarViewController new];
                tabBar.access_token = dic[@"access_token"];
                [tabBar init_View];
            
                NSString * str = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                NSString * path = [NSString stringWithFormat:@"%@/AT.txt",str];
            
                //把access_token保存到本地，方便下次登录
                [dic[@"access_token"] writeToFile:path
                                       atomically:YES
                                        encoding : NSUTF8StringEncoding
                                            error:nil];
            
                [self presentViewController:tabBar
                                   animated:YES
                                 completion:nil];
            
        }
        
    }
    
    else
    {
        
        dic1 = [MicroBlogOperateForSina getDetailOfUserWithAccessToken:token
                                                                  name:nil
                                                                 orId : [MicroBlogOperateForSina getIdWithAccessToken:token][@"uid"]];
        
        [self welcome:dic1];
        
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
