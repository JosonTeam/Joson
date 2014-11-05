#import "TabbarViewController.h"
#import "BaseViewController.h"
#import "MenuViewController.h"
#import "Factory.h"
#import "JSKit.h"

@interface TabbarViewController ()
{
    BaseViewController * _v1;
    int _seleted_Item;
    int _width;
    int _high;
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
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    _v1 = [BaseViewController new];
    BaseViewController * v2 = [BaseViewController new];
    BaseViewController * v3 = [BaseViewController new];
    BaseViewController * v4 = [BaseViewController new];
    BaseViewController * v5 = [BaseViewController new];
    
    _access_token = @"2.00WZkEoBGfkwgCe225676bb60AP1JZ";
    _v1.userLoginName = [MicroBlogOperateForSina getDetailOfUserWithAccessToken:_access_token name:nil orId:[[MicroBlogOperateForSina getIdWithAccessToken:_access_token][@"uid"] intValue]][@"name"];
    
    _v1.access_token = _access_token;
    v2.access_token = _access_token;
    v3.access_token = _access_token;
    v4.access_token = _access_token;
    v5.access_token = _access_token;
    NSLog(@"%@",_access_token);
    
    _v1.identifier = 0;
    v2.identifier = 1;
    v3.identifier = 2;
    v4.identifier = 3;
    v5.identifier = 4;
    
    [_v1 init_View];
    [v2 init_View];
    [v3 init_View];
    [v4 init_View];
    [v5 init_View];
    
    UINavigationController * n1 = [NavigationControllerCustomer createNavigationControllerWithViewController:_v1];
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
    
    _hide_View = [[UIView alloc]initWithFrame:CGRectMake(0, _high, _width, _high)];
    _hide_View.backgroundColor = [UIColor blackColor];
    _hide_View.alpha = 0.5;
    [self.view addSubview:_hide_View];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewDisappear)];
    [_hide_View addGestureRecognizer:tap];
    
    _table_View = [[UITableView alloc]initWithFrame:CGRectMake(10, _high/2-100+_high, _width-20, 200)];
    _table_View.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _table_View.backgroundColor = [UIColor whiteColor];
    _table_View.showsHorizontalScrollIndicator = NO;
    _table_View.showsVerticalScrollIndicator = NO;
    _table_View.scrollEnabled = NO;
    _table_View.dataSource = self;
    _table_View.delegate = self;
    _table_View.bounces = YES;
    [self.view addSubview:_table_View];
}

- (void)select_Item:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 1;
    if (sender.tag == 3)
    {
        MenuViewController * menu = [MenuViewController new];
        menu.identifier = _seleted_Item;
        menu.tabbar = self;
        [self presentViewController:menu animated:YES completion:nil];
    }
    else
    {
        _seleted_Item = (int)sender.tag - 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"_cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_cell"];
    }
    if (_cellName)
    {
        cell.textLabel.text = _cellName[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)viewAppear
{
    _cellName = @[@"收藏",@"取消关注",@"屏蔽",@"举报"];
    [_table_View reloadData];
    [UIView animateWithDuration:0.5 animations:^{
         _hide_View.frame = CGRectMake(0, 0, _width, _high);
        _table_View.frame = CGRectMake(10, _high/2-100, _width-20, 200);
    }];
}

- (void)viewDisappear
{
    [UIView animateWithDuration:0.5 animations:^{
        _hide_View.frame = CGRectMake(0, _high, _width, _high);
        _table_View.frame = CGRectMake(10, _high/2-100+_high, _width-20, 200);
    }];
}

- (void)viewAppearance:(UILongPressGestureRecognizer *)sender
{
#warning ...
    UITableViewCell * cell = (UITableViewCell *)sender.view;
    NSIndexPath * indexPath = [_table_View indexPathForCell:cell];
    NSLog(@"%@",indexPath);
    _cellName = @[@"转发",@"评论",@"收藏"];
//    if (!_v1.source[indexPath.section][@"retweeted_status"] )
//    {
        _cellName = @[@"转发",@"评论",@"收藏",@"转发原微博"];
//    }
    
    [_table_View reloadData];
    [UIView animateWithDuration:0.5 animations:^{
        _hide_View.frame = CGRectMake(0, 0, _width, _high);
        _table_View.frame = CGRectMake(10, _high/2-100, _width-20, 200);
    }];
}

@end
