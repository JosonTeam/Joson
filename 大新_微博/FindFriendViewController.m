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
    
//    [NavigationControllerCustomer cr]
    
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

    if ([_user_Pic[indexPath.row] isEqual:@"avatar_default_big@2x.png"])
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_source[indexPath.row][@"avatar_hd"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                    _user_Pic[indexPath.row] = [UIImage imageWithData:data];
                    userImage.image = [UIImage imageWithData:data];
            });
        });
    }
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(70, 5, _width-40, 30)];
    label.text = _source[indexPath.row][@"name"];
    [bG addSubview:label];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

@end
