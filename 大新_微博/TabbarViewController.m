#import "TabbarViewController.h"
#import "BaseViewController.h"
#import "MenuViewController.h"
#import "JSKit.h"

@interface TabbarViewController ()
{
    int _seleted_Item;
}
@end

@implementation TabbarViewController

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
    [self init_View];
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)init_View
{
    BaseViewController * v1 = [BaseViewController new];
    BaseViewController * v2 = [BaseViewController new];
    BaseViewController * v3 = [BaseViewController new];
    BaseViewController * v4 = [BaseViewController new];
    BaseViewController * v5 = [BaseViewController new];
    
    v1.identifier = 0;
    v2.identifier = 1;
    v3.identifier = 2;
    v4.identifier = 3;
    v5.identifier = 4;
    
    [v1 init_View];
    [v2 init_View];
    [v3 init_View];
    [v4 init_View];
    [v5 init_View];
    
    UINavigationController * n1 = [NavigationControllerCustomer createNavigationControllerWithViewController:v1];
    UINavigationController * n2 = [NavigationControllerCustomer createNavigationControllerWithViewController:v2];
    UINavigationController * n3 = [NavigationControllerCustomer createNavigationControllerWithViewController:v3];
    UINavigationController * n4 = [NavigationControllerCustomer createNavigationControllerWithViewController:v4];
    UINavigationController * n5 = [NavigationControllerCustomer createNavigationControllerWithViewController:v5];
    
    n3.navigationBarHidden = YES;
    
    self.viewControllers = @[n1,n2,n3,n4,n5];
    
    NSArray * arr = @[@"首页",@"消息",@" ",@"发现",@"我"];
    NSArray * nomal = @[@"tabbar_home@2x.png",@"tabbar_message_center@2x.png",@"compose_pic_add_big@2x.png",@"tabbar_discover@2x.png",@"tabbar_profile@2x.png"];
    NSArray * highLight = @[@"tabbar_home@2x_highlighted.png",@"tabbar_message_center@2x_highlighted.png",@"",@"tabbar_discover@2x_highlighted.png",@"tabbar_profile@2x_highlighted.png"];

    for (int i = 0; i < arr.count; i ++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:nomal[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:highLight[i]] forState:UIControlStateHighlighted];
        [button setHighlighted:YES];
        button.tag = i+1;
        [button addTarget:self action:@selector(select_Item:) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(20+62*i, 5, 30, 30);
        [self.tabBar addSubview:button];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15+62*i, 30, 40, 25)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont systemFontOfSize:10];
        [self.tabBar addSubview:label];
        
        if (i == 2)
        {
            button.frame = CGRectMake(20+62*i, 5, 40, 40);
            button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_guide_button_default@2x.png"]];
        }
    }
}

- (void)select_Item:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 1;
    if (sender.tag == 3)
    {
        MenuViewController * menu = [MenuViewController new];
        menu.identifier = _seleted_Item;
        [self presentViewController:menu animated:YES completion:nil];
    }
    else
    {
         _seleted_Item = sender.tag - 1;
    }
}

@end
