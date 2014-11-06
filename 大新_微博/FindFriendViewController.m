#import "FindFriendViewController.h"
#import "Factory.h"
#import "JSKit.h"

@interface FindFriendViewController ()
{
    NSArray * _source;
    NSMutableArray * _user_Pic;
    int _width;
    int _high;
}
@end

@implementation FindFriendViewController

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
    self.navigationItem.hidesBackButton = YES;
    
    [NavigationControllerCustomer createBackButtonForViewController:self hideOldBackButtonOfNavigationItem:YES withTag:1 andImage:[UIImage imageNamed:@"toolbar_leftarrow@2x.png"] orTitile:nil andType:UIButtonTypeCustom];
    [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:nil andImage:[UIImage imageNamed:@"navigationbar_more@2x.png"] andType:UIButtonTypeCustom];
    [NavigationControllerCustomer setTitle:@"好友推荐" withColor:[UIColor blackColor] forViewController:self];
    
    UIButton * back = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * share = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    
    _source = [MicroBlogOperateForSina getSuggestedUserWithAccessToken:_access_token andCategory:nil];
    
    _user_Pic = [NSMutableArray new];
    for (int i = 0; i < _source.count; i++)
    {
        [_user_Pic addObject:[UIImage imageNamed:@"avatar_default_big@2x.png"]];
    }
    
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    UITableView * table_View = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _high) style:UITableViewStyleGrouped];
    table_View.showsHorizontalScrollIndicator = 0;
    table_View.showsVerticalScrollIndicator = 0;
    table_View.dataSource = self;
    table_View.delegate = self;
    table_View.bounces = 0;
    [self.view addSubview:table_View];
   
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"_cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"_cell"];
    }
    else
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    UIView * bG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 70)];
    [cell.contentView addSubview:bG];
    
    UIImageView * userImage = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 60, 60)];
    userImage.image = _user_Pic[indexPath.row];
    [bG addSubview:userImage];

    if ([_user_Pic[indexPath.row] isEqual:[UIImage imageNamed:@"avatar_default_big@2x.png"]])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_source[indexPath.row][@"avatar_hd"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                    _user_Pic[indexPath.row] = [UIImage imageWithData:data];
                    userImage.image = [UIImage imageWithData:data];
            });
        });
    }
    
    UILabel * user_Name = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, _width-115, 30)];
    user_Name.text = _source[indexPath.row][@"name"];
    [bG addSubview:user_Name];
    
    if ([_source[indexPath.row][@"verified"] intValue] == 1)
    {
        user_Name.textColor = [UIColor orangeColor];
    }
    
    UILabel * introduce = [[UILabel alloc]initWithFrame:CGRectMake(70, 35, _width-115, 30)];
    introduce.numberOfLines = 2;
    introduce.font = [UIFont systemFontOfSize:10];
    introduce.textColor = [UIColor darkGrayColor];
    introduce.text = _source[indexPath.row][@"description"];
    [bG addSubview:introduce];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(_width-35, 20, 30, 30);
    button.selected = YES;
    button.tag = indexPath.row+1;
    [button addTarget:self action:@selector(click_Button:) forControlEvents:UIControlEventTouchUpInside];
    [bG addSubview:button];
    
    [button setImage:[UIImage imageNamed:@"card_icon_addattention@2x.png"] forState:UIControlStateNormal];
    if ([_source[indexPath.row][@"following"] intValue] == 1)
    {
        [button setImage:[UIImage imageNamed:@"card_icon_unfollow@2x.png"] forState:UIControlStateNormal];
        if ([_source[indexPath.row][@"follow_me"] intValue] == 1)
        {
            [button setImage:[UIImage imageNamed:@"card_icon_arrow@2x.png"] forState:UIControlStateNormal];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [UIView new];
    
    UILabel * seperateLine = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _width, 5)];
    seperateLine.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:seperateLine];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_profile_selected@2x.png"]];
    imageView.frame = CGRectMake(5, 5, 25, 25);
    [view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, _width, 25)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"大新微博为您精心推荐:";
    label.textColor = [UIColor redColor];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (void)click_Button:(UIButton *)sender
{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"card_icon_addattention@2x.png"]])
    {
        [sender setImage:[UIImage imageNamed:@"card_icon_unfollow@2x.png"] forState:UIControlStateNormal];
        [MicroBlogOperateForSina followUserWithAccessToken:_access_token andName:_source[sender.tag-1][@"name"]];
        if ([_source[sender.tag-1][@"follow_me"] intValue] == 1)
        {
            [sender setImage:[UIImage imageNamed:@"card_icon_arrow@2x.png"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"card_icon_addattention@2x.png"] forState:UIControlStateNormal];
        [MicroBlogOperateForSina destroyFollowingWithAcccessToken:_access_token iD:[_source[sender.tag-1][@"id"] integerValue]];
    }
}

- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)share
{
    
}

@end
