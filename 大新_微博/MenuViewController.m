#import <AVFoundation/AVFoundation.h>
#import "TabbarViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#import "Factory.h"

@interface MenuViewController ()
{
    UIScrollView * _s;
    AVAudioPlayer * _player;
    BOOL _autoBack;
    int _high;
    int _width;
}
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = 1;
    if (_autoBack)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSArray * highAndWidth = [Factory getHeigtAndWidthOfDevice];
    _width = [highAndWidth[0] intValue];
    _high = [highAndWidth[1] intValue];
    
    _autoBack = 0;
    
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"composer_close" ofType:@"wav"]] error:nil];
    [_player prepareToPlay];
    
    NSArray * label_Name = @[@[@"文字",@"相册",@"拍摄",@"签到",@"点评",@"更多"],@[@"好友圈",@"秒拍",@"音乐",@"长微博",@"收款"]];
    NSArray * pic = @[@[@"tabbar_compose_idea.png",@"tabbar_compose_photo@2x.png",@"tabbar_compose_camera@2x.png",@"tabbar_compose_lbs@2x.png",@"tabbar_compose_review@2x.png",@"tabbar_compose_more@2x.png"],@[@"tabbar_compose_friend@2x.png",@"tabbar_compose_shooting@2x.png",@"tabbar_compose_music@2x.png",@"tabbar_compose_weibo@2x.png",@"tabbar_compose_envelope@2x.png"]];
    
    UIImageView * im = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _high)];
    im.image = [UIImage imageNamed:@"Default-568h@2x2.png"];
    im.userInteractionEnabled = 1;
    
    UITapGestureRecognizer * bg_Tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [im addGestureRecognizer:bg_Tap];
    
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(go)];
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [im addGestureRecognizer:swipe];
    
    _s = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _high-320, _width, _high-240)];
    _s.contentSize = CGSizeMake(_width*2, _high-240);
    _s.scrollEnabled = NO;
    [im addSubview:_s];
    
    UIView * first = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _high-240)];
    UIView * second = [[UIView alloc]initWithFrame:CGRectMake(_width, 0, _width, _high-240)];
    
    for (int i = 0; i < [label_Name[0] count]; i++)
    {
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(35+95*(i%3), 20+110*(i/3), 60, 60)];
        imageview.image = [UIImage imageNamed:pic[0][i]];
        imageview.userInteractionEnabled = 1;
        imageview.tag = 1000+i;
        [first addSubview:imageview];

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [imageview addGestureRecognizer:tap];
                
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(35+95*(i%3), 90+100*(i/3), 60, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = label_Name[0][i];
        [first addSubview:label];
    }
    [_s addSubview:first];
    
    for (int i = 0; i < [label_Name[1] count]; i++)
    {
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(35+95*(i%3), 20+110*(i/3), 60, 60)];
        imageview.image = [UIImage imageNamed:pic[1][i]];
        imageview.userInteractionEnabled = 1;
         imageview.tag = 1007+i;
        [second addSubview:imageview];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click:)];
        [imageview addGestureRecognizer:tap];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(35+95*(i%3), 90+100*(i/3), 60, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = label_Name[1][i];
        [second addSubview:label];
    }
    [_s addSubview:second];
    
    UIButton * back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setImage:[UIImage imageNamed:@"tabbar_compose_background_icon_close@2x.png"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    back.backgroundColor = [UIColor whiteColor];
    back.frame = CGRectMake(0, _high-60, _width, 40);
    [im addSubview:back];
    [self.view addSubview:im];
}

- (void)click:(UITapGestureRecognizer *)sender
{
    UIViewController * viewController;
    switch (sender.view.tag-1000)
    {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        case 5:
            [_s scrollRectToVisible:CGRectMake(_width, _high-320, _width, _high-240) animated:YES];
            break;
        case 7:
            break;
        case 8:
            break;
        case 9:
            break;
        case 10:
            break;
        case 11:
            break;
    }
    
    if (sender.view.tag-1000 != 5)
    {
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

- (void)go
{
    [_s scrollRectToVisible:CGRectMake(0, _high-320, _width, _high) animated:YES];
}

- (void)back
{
    [_player play];
    AppDelegate * dele = [UIApplication sharedApplication].delegate;
    TabbarViewController * tabBar = (TabbarViewController *)dele.window.rootViewController;
    tabBar.selectedIndex = _identifier;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
