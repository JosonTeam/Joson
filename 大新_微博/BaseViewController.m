#import <AVFoundation/AVFoundation.h>
#import "FindFriendViewController.h"
#import "BaseViewController.h"
#import "MenuViewController.h"
#import "EditViewController.h"
#import "PopoverView.h"
#import "JHRefresh.h"
#import "Factory.h"
#import "JSKit.h"

@interface BaseViewController ()
{
    int _high;
    int _width;
    AVAudioPlayer * _player;
    NSMutableArray * _userPic_Source;
    UITableView * _tableView;
    NSMutableArray * _weibo_Content_Pic;
    NSMutableArray * _weibo_Content_Pic1;
    NSArray * _button_Image;
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
            [NavigationControllerCustomer createLeftBarButtonItemForViewController:self withTag:1 andTitle:nil andImage:[UIImage imageNamed:@"navigationbar_friendsearch@2x.png"] andType:UIButtonTypeCustom];
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:nil andImage:[UIImage imageNamed:@"navigationbar_pop@2x.png"] andType:UIButtonTypeCustom];
            
            [self initFirstPage];
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

- (void)refreshPhoto:(NSNumber *)sender
{
    int i = [sender intValue];
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  _count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * content_Pic = _source[indexPath.section][@"pic_urls"];
    if (_source[indexPath.section][@"retweeted_status"])
    {
         NSArray * content_Pic1 = _source[indexPath.section][@"retweeted_status"][@"pic_urls"];

        return [Factory contentHeight:_source[indexPath.section][@"text"]]+55+[Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]]+ceil(content_Pic1.count/3.0) * 70+25;
    }
    return ceil(content_Pic.count/3.0) * 70 + [Factory contentHeight:_source[indexPath.section][@"text"]]+70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    else
    {
        for (UIView * v in cell.contentView.subviews)
        {
            [v removeFromSuperview];
        }
    }
    
    [self initCellForPageFirst:cell andIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)initFirstPage
{
    
    UIButton * menuButton = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [menuButton addTarget:self action:@selector(getView:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * findFriends = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [findFriends addTarget:self action:@selector(findFriends:) forControlEvents:UIControlEventTouchUpInside];
    
    _count = 20;
    _name = [NSMutableArray new];
    _weibo_Content_Pic = [NSMutableArray new];
    _weibo_Content_Pic1 = [NSMutableArray new];
    
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"]] error:nil];
    [_player prepareToPlay];
    
    [NavigationControllerCustomer setTitle:_userLoginName withColor:[UIColor blackColor] forViewController:self];
    
    NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token andtype:WeiboTypeAll];
    
//    NSDictionary * dic11 = [GetDataOfLocalFile getContentOfPlistFileAtBundleWithFileName:@"File"];
    _source = [dic11[@"statuses"] mutableCopy];
    
    _userPic_Source = [NSMutableArray new];
    
    [self getAppearSource];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _high-10) style:UITableViewStyleGrouped];
    _tableView.showsHorizontalScrollIndicator = 0;
    _tableView.showsVerticalScrollIndicator = 0;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = YES;
    [self.view addSubview:_tableView];
    
    
    __weak UITableView * tableview = _tableView;
    [tableview addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        //延时隐藏refreshView;
        double delayInSeconds = 2.0;
        //创建延期的时间 2S
        dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        //延期执行
        dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
            self.count = 20;
            
            NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token andtype:WeiboTypeAll];
            
            _source = [dic11[@"statuses"] mutableCopy];
            _weibo_Content_Pic = [NSMutableArray new];
            _weibo_Content_Pic1 = [NSMutableArray new];
            _name = [NSMutableArray new];
            [self getAppearSource];
            
            [tableview reloadData];
            
            //事情做完了别忘了结束刷新动画~~~
            [tableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
            [_player play];

        });
    }];
    
    [tableview addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        //延时隐藏refreshView;
        double delayInSeconds = 2.0;
        //创建延期的时间 2S
        dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        //延期执行
        dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
            if (self.count != _source.count-_source.count%20)
            {
                self.count += 20;
            }
            else if (_source.count%20 != 0)
            {
                self.count += _source.count%20;
            }
            
            
            [tableview reloadData];
            
            //事情做完了别忘了结束刷新动画~~~
            [tableview footerEndRefreshing];
        });
        
    }];
}

- (void)getView:(UIButton *)sender
{
    PopoverView * popover = [PopoverView new];
    popover.table = _tableView;
    popover.player = _player;
    popover.count = _count;
    popover.base = self;
    popover = [popover initWithPoint:CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height+15) titles:@[@"扫一扫",@"刷新"] images:@[@"navigationbar_pop1.png",@"navigationbar_refresh@2x.png"]];
    [popover show];
}

- (void)findFriends:(UIButton *)sender
{
    FindFriendViewController * find = [FindFriendViewController new];
    find.access_token = _access_token;
    find.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:find animated:YES];
}

- (void)initCellForPageFirst:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    int button_y;
    cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0];
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 35)];
    view.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:view];
    
    UIButton * listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    listButton.frame = CGRectMake(_width-35, 5, 30, 30);
    [listButton setImage:[UIImage imageNamed:@"preview_icon_hidden_highlighted@2x.png"] forState:UIControlStateNormal];
    [listButton addTarget:self.tabBarController action:@selector(viewAppear) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:listButton];
    
    UIImageView * user_Image = [[UIImageView alloc]initWithImage:_userPic_Source[indexPath.section]];
    user_Image.frame = CGRectMake(5, 5, 30, 30);
    [view addSubview:user_Image];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 2, _width-40, 20)];
    label.text = _source[indexPath.section][@"user"][@"name"];
    [view addSubview:label];
    
    NSString * time = [Factory getDateWithSourceDate:_source[indexPath.section][@"created_at"] andSysDate:[NSString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSinceNow:8*3600]]];
    
    NSString * state = [[[[_source[indexPath.section][@"source"] componentsSeparatedByString:@">"]objectAtIndex:1] componentsSeparatedByString:@"<"] objectAtIndex:0];
    
    UILabel * time_Label = [[UILabel alloc]initWithFrame:CGRectMake(40, 22, time.length*10, 10)];
    time_Label.font = [UIFont fontWithName:Nil size:10];
    time_Label.text = time;
    if ([time isEqualToString:@"刚刚"])
    {
        time_Label.textColor = [UIColor orangeColor];
    }
    [view addSubview:time_Label];
    
    UILabel * state_Label = [[UILabel alloc]initWithFrame:CGRectMake(45+time.length*10, 22, (state.length+2)*18, 10)];
    state_Label.text = [NSString stringWithFormat:@"来自%@",state];
    state_Label.font = [UIFont systemFontOfSize:10];
    [view addSubview:state_Label];
    
    NSArray * content_Pic = _source[indexPath.section][@"pic_urls"];
    UIView * content_View = [[UIView alloc]initWithFrame:CGRectMake(0, 35, _width, [Factory contentHeight:_source[indexPath.section][@"text"]]+ceil(content_Pic.count/3.0) * 70+5)];
    content_View.backgroundColor = [UIColor whiteColor];
    content_View.userInteractionEnabled = 1;
    [cell.contentView addSubview:content_View];
    
    UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc]initWithTarget:self.tabBarController action:@selector(viewAppearance:)];
    [cell addGestureRecognizer:press];
    
    UITextView * text = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, _width-10, [Factory contentHeight:_source[indexPath.section][@"text"]])];
    text.text = _source[indexPath.section][@"text"];
    text.font = [UIFont fontWithName:nil size:15];
    text.scrollEnabled = NO;
    text.selectable = NO;
    text.editable = NO;
    [content_View addSubview:text];
    
    NSArray * arr = [_source[indexPath.section] allKeys];
    
    if ([arr containsObject:@"retweeted_status"])
    {
        NSArray * content_Pic1 = _source[indexPath.section][@"retweeted_status"][@"pic_urls"];
        UIView * content_View1 = [[UIView alloc]initWithFrame:CGRectMake(0, text.frame.origin.y+5+CGRectGetHeight(text.frame), _width, [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]]+ceil(content_Pic1.count/3.0) * 70+10)];
        content_View1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        content_View.frame = CGRectMake(0, 35, _width, [Factory contentHeight:_source[indexPath.section][@"text"]]+[Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]]+ceil(content_Pic1.count/3.0) * 60);
        
        UITextView * text1 = [[UITextView alloc]initWithFrame:CGRectMake(5, 5, _width-10, [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]])];
        text1.text = [NSString stringWithFormat:@"@%@ :%@",_name[indexPath.section],_source[indexPath.section][@"retweeted_status"][@"text"]];
        text1.font = [UIFont fontWithName:nil size:15];
        text1.backgroundColor = content_View1.backgroundColor;
        text1.scrollEnabled = NO;
        text1.selectable = NO;
        text1.editable = NO;
        [content_View1 addSubview:text1];
       
#warning ....
//        UILabel * user_Name_Label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, [_name[indexPath.section] length]*18, 20)];
//        user_Name_Label.text = [NSString stringWithFormat:@"@%@",_name[indexPath.section]];
//        user_Name_Label.backgroundColor = content_View1.backgroundColor;
//        user_Name_Label.font = [UIFont fontWithName:nil size:15];
//        user_Name_Label.textColor = [UIColor blueColor];
//        [content_View1 addSubview:user_Name_Label];
        
        NSMutableArray * pic_Array1 = _weibo_Content_Pic1[indexPath.section];
        for (int i = 0; i < content_Pic1.count; i++)
        {
            [pic_Array1 addObject:[UIImage imageNamed:@"message_placeholder_picture@2x.png"]];
            UIImageView * image1 = [[UIImageView alloc]initWithFrame:CGRectMake(5+(i%3)*70, text1.frame.origin.y+5+CGRectGetHeight(text1.frame)+(i/3)*70, 60, 60)];
            image1.image = _weibo_Content_Pic1[indexPath.section][i];
            if ([_weibo_Content_Pic1[indexPath.section][i] isEqual:[UIImage imageNamed:@"message_placeholder_picture@2x.png"]])
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSData * data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:content_Pic1[i][@"thumbnail_pic"]]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _weibo_Content_Pic1[indexPath.section][i] = [UIImage imageWithData:data1];
                        image1.image = [UIImage imageWithData:data1];
                    });
                });
            }
            [content_View1 addSubview:image1];
        }
        [content_View addSubview:content_View1];
        button_y = [Factory contentHeight:_source[indexPath.section][@"text"]]+52+[Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]]+ceil(content_Pic1.count/3.0) * 70;
    }
    else
    {
        NSMutableArray * pic_Array = _weibo_Content_Pic[indexPath.section];
        for (int i = 0; i < content_Pic.count; i++)
        {
            [pic_Array addObject:[UIImage imageNamed:@"message_placeholder_picture@2x.png"]];
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(5+(i%3)*70, text.frame.origin.y+5+CGRectGetHeight(text.frame)+(i/3)*70, 60, 60)];
            image.image = _weibo_Content_Pic[indexPath.section][i];
            if ([_weibo_Content_Pic[indexPath.section][i] isEqual:[UIImage imageNamed:@"message_placeholder_picture@2x.png"]])
            {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:content_Pic[i][@"thumbnail_pic"]]];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        _weibo_Content_Pic[indexPath.section][i] = [UIImage imageWithData:data];
                        image.image = [UIImage imageWithData:data];
                    });
                });
            }
            [content_View addSubview:image];
        }
        button_y = ceil(content_Pic.count/3.0) * 70 + [Factory contentHeight:_source[indexPath.section][@"text"]]+42;
    }
    
    NSArray * button_Name = @[@"转发",@"评论",@"赞"];
    _button_Image = @[@"statusdetail_icon_retweet@2x.png",@"statusdetail_icon_comment@2x.png",@"statusdetail_comment_icon_like@2x.png",@"statusdetail_comment_icon_like_highlighted@2x.png"];
    for (int i = 0; i < 3; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(1+i*_width/3, button_y, _width/3-1, 25);
        [button setImage:[UIImage imageNamed:_button_Image[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:button_Name[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = (indexPath.section+5)*10000+i;
        button.selected = YES;
        [cell.contentView addSubview:button];
        
        switch (button.tag-(indexPath.section+5)*10000)
        {
            case 1:
            case 0:
                [button addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchUpInside];
                break;
            case 2:
                [button addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventTouchUpInside];
                break;
        }
    }
}

- (void)pushViewController:(UIButton *)sender
{
    EditViewController * edit = [EditViewController new];
    edit.hidesBottomBarWhenPushed = YES;
    edit.name = _userLoginName;
    edit.access_token = _access_token;
    switch (sender.tag%10000)
    {
        case 0:
            edit.type = @"report";
            edit.source = _source[sender.tag/10000-5];
            break;
        case 1:
            edit.type = @"comment";
            edit.source = _source[(sender.tag-1)/10000-5];
            break;
    }
    [self.navigationController pushViewController:edit animated:YES];
}

- (void)changeColor:(UIButton *)sender
{
    if ([sender.imageView.image isEqual:[UIImage imageNamed:_button_Image[2]]])
    {
        [sender setImage:[UIImage imageNamed:_button_Image[3]] forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:_button_Image[2]] forState:UIControlStateNormal];
    }
}

- (void)getAppearSource
{
    for (int i = 0; i < _source.count; i ++)
    {
        NSMutableArray * pic_Array = [NSMutableArray new];
        [_weibo_Content_Pic addObject:pic_Array];
        
        if (_source[i][@"retweeted_status"])
        {
            [_name addObject:_source[i][@"retweeted_status"][@"user"][@"name"]];
        }
        else
        {
            [_name addObject:@" "];
        }
        
        if (!_userPic_Source)
        {
            [_userPic_Source addObject:[UIImage imageNamed:@"tabbar_profile@2x.png"]];
        }
        else
        {
            [_userPic_Source setObject:[UIImage imageNamed:@"tabbar_profile@2x.png"] atIndexedSubscript:i];
        }
        if ([_userPic_Source[i] isEqual:[UIImage imageNamed:@"tabbar_profile@2x.png"]])
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_source[i][@"user"][@"avatar_large"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _userPic_Source[i] = [UIImage imageWithData:data];
                    
                    [self performSelectorOnMainThread:@selector(refreshPhoto:) withObject:[NSNumber numberWithInteger:i] waitUntilDone:YES];
                });
            });
        }
        if (_source[i][@"retweeted_status"])
        {
            NSDictionary * dic = _source[i][@"retweeted_status"];
            for (int j = 0; j < [dic count]; j ++)
            {
                NSMutableArray * pic_Array1 = [NSMutableArray new];
                [_weibo_Content_Pic1 addObject:pic_Array1];
            }
        }
    }
}

@end
