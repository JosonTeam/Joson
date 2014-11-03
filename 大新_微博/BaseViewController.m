#import <AVFoundation/AVFoundation.h>
#import "BaseViewController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#import "Factory.h"
#import "JSKit.h"

@interface BaseViewController ()
{
    int _high;
    int _width;
    AVAudioPlayer * _player;
}
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)init_View
{
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    switch (_identifier)
    {
        case 0:
        {
            AppDelegate * dele = [UIApplication sharedApplication].delegate;
            NSLog(@"%@",dele.access_token);
            [NavigationControllerCustomer createLeftBarButtonItemForViewController:self withTag:1 andTitle:nil andImage:[UIImage imageNamed:@"navigationbar_friendsearch@2x.png"] andType:UIButtonTypeCustom];
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:nil andImage:[UIImage imageNamed:@"navigationbar_pop@2x.png"] andType:UIButtonTypeCustom];
        }
            break;
        case 1:
        {
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:@"发起聊天" andImage:nil andType:UIButtonTypeCustom];
        }
            break;
        case 2:
        {
            UIImageView * bg_Image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _high)];
            bg_Image.image = [UIImage imageNamed:@"Default-568h@2x2.png"];
            [self.view addSubview:bg_Image];
            
            _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"composer_open" ofType:@"wav"]] error:nil];
            [_player prepareToPlay];
        }
            break;
        case 3:
        {
            [NavigationControllerCustomer createSearchBarWithViewController:self withTag:1 needRecorderButton:1 andTitle:Nil andImage:[UIImage imageNamed:@"message_voice_background@2x.png"] andType:UIButtonTypeCustom withButtonTag:2];
            
        }
            break;
        case 4:
        {
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:@"设置" andImage:nil andType:UIButtonTypeCustom];
        }
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (_identifier == 2)
    {
        [_player play];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
