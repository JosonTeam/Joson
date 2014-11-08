#import <AVFoundation/AVFoundation.h>
#import "TabbarViewController.h"
#import "MenuViewController.h"
#import "EditViewController.h"

@interface MenuViewController ()
{
    
    AVAudioPlayer * _player; //音频播放器
    UIScrollView * _s; //滚轴视图
    BOOL _autoBack; //自动返回
    int _width; //屏幕宽度
    int _high; //屏幕高度
    
}
@end

@implementation MenuViewController

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

#pragma mark 设置是否自动返回上一个界面
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = 1;
    
    //是否自动返回上一个界面
    if (_autoBack)
    {
        
        self.view.hidden = 1;
        _tabbar.selectedIndex = _identifier;
        
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
        
    }
    
}

#pragma mark 初始化界面
- (void)viewDidLoad
{
    [super viewDidLoad];
    
#pragma mark 获取窗口的宽度和高度
    NSArray * highAndWidth = [Factory getHeigtAndWidthOfDevice];
    _width = [highAndWidth[0] intValue];
    _high = [highAndWidth[1] intValue];
    
    _autoBack = 0;
    
    //准备声音
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL : [NSURL fileURLWithPath : [[NSBundle mainBundle] pathForResource:@"composer_close"
                                                                                                                      ofType:@"wav"]]
                                                      error:nil];
    
    [_player prepareToPlay];
    
    //准备按钮数据
    NSArray * label_Name = @[@[@"文字" , @"相册" , @"拍摄" , @"签到" , @"点评" , @"更多"] , @[@"好友圈" , @"秒拍" , @"音乐" , @"长微博" , @"收款"]];
    NSArray * pic = @[@[@"tabbar_compose_idea.png" , @"tabbar_compose_photo@2x.png" , @"tabbar_compose_camera@2x.png" , @"tabbar_compose_lbs@2x.png" , @"tabbar_compose_review@2x.png" , @"tabbar_compose_more@2x.png"] , @[@"tabbar_compose_friend@2x.png" , @"tabbar_compose_shooting@2x.png" , @"tabbar_compose_music@2x.png" , @"tabbar_compose_weibo@2x.png" , @"tabbar_compose_envelope@2x.png"]];
    
    //设置背景图片
    UIImageView * im = [[UIImageView alloc] initWithFrame : CGRectMake(0, 0, _width, _high)];
    im.image = [UIImage imageNamed:@"Default-568h@2x2.png"];
    im.userInteractionEnabled = 1;
    
    //为背景添加单击手势
    UITapGestureRecognizer * bg_Tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(back)];
    
    [im addGestureRecognizer:bg_Tap];
    
    //为按钮添加清扫手势，清扫方向为向右
    UISwipeGestureRecognizer * swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(go)];
    
    swipe.direction = UISwipeGestureRecognizerDirectionRight;
    [im addGestureRecognizer:swipe];
    
    //添加scrollView
    _s = [[UIScrollView alloc] initWithFrame : CGRectMake(0, _high-320, _width, _high-240)];
    _s.contentSize = CGSizeMake(_width*2, _high-240);
    _s.scrollEnabled = NO;
    [im addSubview:_s];
    
    //添加按钮
    UIView * first = [[UIView alloc] initWithFrame : CGRectMake(0, 0, _width, _high-240)];
    UIView * second = [[UIView alloc] initWithFrame : CGRectMake(_width, 0, _width, _high-240)];
    
    //添加第一页按钮图片，名字，及设置单击手势
    for (int i = 0; i < [label_Name[0] count]; i++)
    {
        
        UIImageView * imageview = [[UIImageView alloc] initWithFrame : CGRectMake(35+95*(i%3), 20+110*(i/3), 60, 60)];
        imageview.image = [UIImage imageNamed:pic[0][i]];
        imageview.userInteractionEnabled = 1;
        imageview.tag = 1000+i;
        imageview.layer.cornerRadius = 30;
        [first addSubview:imageview];

        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(click:)];
        
        [imageview addGestureRecognizer:tap];
                
        UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(35+95*(i%3), 90+100*(i/3), 60, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = label_Name[0][i];
        label.tag = 1100+i;
        [first addSubview:label];
        
    }
    
    [_s addSubview:first];
    
    //添加第二页按钮图片，名字，及设置单击手势
    for (int i = 0; i < [label_Name[1] count]; i++)
    {
        
        UIImageView * imageview = [[UIImageView alloc] initWithFrame : CGRectMake(35+95*(i%3), 20+110*(i/3), 60, 60)];
        imageview.image = [UIImage imageNamed:pic[1][i]];
        imageview.userInteractionEnabled = 1;
        imageview.tag = 1007+i;
        imageview.layer.cornerRadius = 30;
        [second addSubview:imageview];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(click:)];
        
        [imageview addGestureRecognizer:tap];
        
        UILabel * label = [[UILabel alloc]initWithFrame : CGRectMake(35+95*(i%3), 90+100*(i/3), 60, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = label_Name[1][i];
        label.tag = 1107+i;
        [second addSubview:label];
        
    }
    
    [_s addSubview:second];
    
    //添加返回按钮
    UIButton * back = [UIButton buttonWithType : UIButtonTypeCustom];
    
    [back setImage : [UIImage imageNamed:@"tabbar_compose_background_icon_close@2x.png"]
          forState : UIControlStateNormal];
    
    [back addTarget:self
             action:@selector(back)
  forControlEvents : UIControlEventTouchUpInside];
    
    back.backgroundColor = [UIColor whiteColor];
    back.frame = CGRectMake(0, _high-40, _width, 40);
    [im addSubview:back];
    [self.view addSubview:im];
    
}

#warning 方法未完善
#pragma mark 点击按钮
- (void)click:(UITapGestureRecognizer *)sender
{
    
    UILabel * label = (UILabel *)[self.view viewWithTag:sender.view.tag+100];
    
    [UIView animateWithDuration:1
                    animations : ^{
                        
        sender.view.transform = CGAffineTransformMakeScale(2, 2);
        label.transform = CGAffineTransformMakeScale(2, 2);
                        
    }
                     completion:^(BOOL finished)
    {
        [UIView animateWithDuration:1
                         animations:^{
                             
            sender.view.transform = CGAffineTransformMakeScale(1, 1);
            label.transform = CGAffineTransformMakeScale(1, 1);
                             
        }];
        
    }];
    
    switch (sender.view.tag%1000)
    {
            
        case 0:
        {
            
            EditViewController * edit = [EditViewController new];
            _autoBack = 1;
            edit.type = @"post";
            edit.name = _userLoginName;
            [self.navigationController pushViewController:edit
                                                 animated:YES];
            
        }
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
            [_s scrollRectToVisible : CGRectMake(_width, _high-320, _width, _high-240)
                            animated:YES];
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
    
}

#pragma mark 滚动
- (void)go
{
    [_s scrollRectToVisible : CGRectMake(0, _high-320, _width, _high)
                    animated:YES];
}

#pragma mark 返回
- (void)back
{
    
    [_player play];
    _tabbar.selectedIndex = _identifier;
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    
}

@end
