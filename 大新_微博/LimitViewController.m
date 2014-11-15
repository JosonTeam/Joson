#import "LimitViewController.h"
#import "EditViewController.h"

@interface LimitViewController ()
{
    UITableView * _table; //tableView
    NSArray * _cellName; //cell的名字
    int _width; //窗口宽度
    int _high; //窗口高度
}

@end

@implementation LimitViewController

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
    
    //设置navigationBar的标题并添加返回按钮
    [NavigationControllerCustomer setTitle:@"选择分享范围"
                                withColor : [UIColor blackColor]
                         forViewController:self];
    
    [NavigationControllerCustomer createBackButtonForViewController:self
                                  hideOldBackButtonOfNavigationItem:YES
                                                            withTag:1
                                                          andImage : [UIImage imageNamed:@"toolbar_leftarrow@2x.png"]
                                                           orTitile:nil
                                                           andType : UIButtonTypeCustom];
    
    //为返回按钮添加方法
    UIButton * back = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    
    [back addTarget:self
             action:@selector(back)
     
   forControlEvents : UIControlEventTouchUpInside];
    
    //获取屏幕尺寸
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    _cellName = @[@[@"公开",@"好友圈",@"仅自己可见"] , @[@"新建群"]];
    
    //添加tableView
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _high)
                                         style:UITableViewStyleGrouped];
    
    _table.showsHorizontalScrollIndicator = 0;
    _table.showsVerticalScrollIndicator = 0;
    _table.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _table.dataSource = self;
    _table.delegate = self;
    _table.bounces = 0;
    [self.view addSubview:_table];
    
}

#pragma mark 返回区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark 返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 3;
    }
    return 1;
}

#pragma mark 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"_cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle : UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"_cell"];
    }
    cell.textLabel.text = _cellName[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"message_group_creat_check_default@2x.png"];
    
    if (indexPath.section == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"compose_pic_big_add_highlighted@2x.png"];
    }
    
    return cell;
}

#pragma mark 设置headerView高度
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

#pragma mark 设置footerView高度
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    return 30;
}

#pragma mark 创建footerView
- (UIView *)tableView:(UITableView *)tableView
viewForFooterInSection:(NSInteger)section
{
    UIView * view = [UIView new];
    
    UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(5, 0, _width, 30)];
    label.text = @"新建一个群，把微博只发给一些指定的朋友看";
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    if (section == 0)
    {
        label.text = @"我的群";
    }
    
    return view;
}

#pragma mark 选择cell
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    if (indexPath.section == 0)
    {
        
        //点击按钮，更换图片，并保持选中图片只出现一张
        switch (indexPath.row)
        {
                
            case 0:
            {
                
                NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:1
                                                             inSection : indexPath.section];
                
                NSIndexPath * indexPath3 = [NSIndexPath indexPathForRow:2
                                                             inSection : indexPath.section];
                
                UITableViewCell * cell1 = [_table cellForRowAtIndexPath:indexPath];
                UITableViewCell * cell2 = [_table cellForRowAtIndexPath:indexPath2];
                UITableViewCell * cell3 = [_table cellForRowAtIndexPath:indexPath3];
                
                [_edit.limitButton setTitleColor : [UIColor colorWithRed:0
                                                                   green:0
                                                                    blue:0.5
                                                                   alpha:0.8]
                                        forState : UIControlStateNormal];
                
                [_edit.limitButton setTitle : cell1.textLabel.text
                                   forState : UIControlStateNormal];
                
                [_edit.limitButton setImage : [UIImage imageNamed:@"compose_publicbutton_background@2x.png"]
                                   forState : UIControlStateNormal];
                
                cell1.imageView.image = [UIImage imageNamed:@"message_group_creat_check@2x.png"];
                cell2.imageView.image = [UIImage imageNamed:@"message_group_creat_check_default@2x.png"];
                cell3.imageView.image = [UIImage imageNamed:@"message_group_creat_check_default@2x.png"];
                
            }
                break;
                
            case 1:
            {
                
                NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:0
                                                             inSection : indexPath.section];
                
                NSIndexPath * indexPath3 = [NSIndexPath indexPathForRow:2
                                                             inSection : indexPath.section];
                
                UITableViewCell * cell1 = [_table cellForRowAtIndexPath:indexPath1];
                UITableViewCell * cell2 = [_table cellForRowAtIndexPath:indexPath];
                UITableViewCell * cell3 = [_table cellForRowAtIndexPath:indexPath3];
                
                [_edit.limitButton setTitleColor : [UIColor colorWithRed:0.5
                                                                   green:0
                                                                    blue:0
                                                                   alpha:0.8]
                                        forState : UIControlStateNormal];
                
                [_edit.limitButton setTitle : cell2.textLabel.text
                                   forState : UIControlStateNormal];
                
                [_edit.limitButton setImage : [UIImage imageNamed:@"compose_publicbutton_background@2x.png"]
                                   forState : UIControlStateNormal];
                

                cell1.imageView.image = [UIImage imageNamed:@"message_group_creat_check_default@2x.png"];
                cell2.imageView.image = [UIImage imageNamed:@"message_group_creat_check@2x.png"];
                cell3.imageView.image = [UIImage imageNamed:@"message_group_creat_check_default@2x.png"];
                
            }
                break;
                
            case 2:
            {
                
                NSIndexPath * indexPath1 = [NSIndexPath indexPathForRow:0
                                                             inSection : indexPath.section];
                NSIndexPath * indexPath2 = [NSIndexPath indexPathForRow:1
                                                             inSection : indexPath.section];
                
                UITableViewCell * cell1 = [_table cellForRowAtIndexPath:indexPath1];
                UITableViewCell * cell2 = [_table cellForRowAtIndexPath:indexPath2];
                UITableViewCell * cell3 = [_table cellForRowAtIndexPath:indexPath];
                
                [_edit.limitButton setTitleColor : [UIColor colorWithRed:0
                                                                   green:0
                                                                    blue:0.5
                                                                   alpha:0.8]
                                        forState : UIControlStateNormal];
                
                [_edit.limitButton setTitle : cell3.textLabel.text
                                   forState : UIControlStateNormal];
                
                [_edit.limitButton setImage : [UIImage imageNamed:@"compose_publicbutton_background@2x.png"]
                                   forState : UIControlStateNormal];
                
                cell1.imageView.image = [UIImage imageNamed:@"message_group_creat_check_default@2x.png"];
                cell2.imageView.image = [UIImage imageNamed:@"message_group_creat_check_default@2x.png"];
                cell3.imageView.image = [UIImage imageNamed:@"message_group_creat_check@2x.png"];
                
            }
                break;
                
        }
        
    }
    
}

#pragma mark 返回上一个页面
- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
