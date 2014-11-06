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
    NSString * max_id;
    NSString * _path;
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
#pragma mark 获取窗口的宽度和高度
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    //根据身份标识辨别视图控制器，进行对应操作
    switch (_identifier)
    {
        case 0:
        {
            //添加标题栏左右两侧按钮
            [NavigationControllerCustomer createLeftBarButtonItemForViewController:self withTag:1 andTitle:nil andImage:[UIImage imageNamed:@"navigationbar_friendsearch@2x.png"] andType:UIButtonTypeCustom];
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:nil andImage:[UIImage imageNamed:@"navigationbar_pop@2x.png"] andType:UIButtonTypeCustom];
            
            //初始化首页
            [self initFirstPage];
        }
            break;
        case 1:
        {
            //添加标题栏的右侧按钮
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:@"发起聊天" andImage:nil andType:UIButtonTypeCustom];
        }
            break;
        case 2:
        {
            //为"+"界面添加背景
            UIImageView * bg_Image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _high)];
            bg_Image.image = [UIImage imageNamed:@"Default-568h@2x2.png"];
            [self.view addSubview:bg_Image];
            
            //准备声音
            _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"composer_open" ofType:@"wav"]] error:nil];
            [_player prepareToPlay];
        }
            break;
        case 3:
        {
            //在标题栏上添加搜索栏和录音按钮
            [NavigationControllerCustomer createSearchBarWithViewController:self withTag:1 needRecorderButton:1 andTitle:Nil andImage:[UIImage imageNamed:@"message_voice_background@2x.png"] andType:UIButtonTypeCustom withButtonTag:2];
            
        }
            break;
        case 4:
        {
            //添加标题栏右侧按钮
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:@"设置" andImage:nil andType:UIButtonTypeCustom];
        }
            break;
    }
}

#pragma mark 当“＋”按钮被点击时，播放声音
- (void)viewWillAppear:(BOOL)animated
{
    if (_identifier == 2)
    {
        [_player play];
    }
}

#pragma mark 刷新cell的图片
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

#pragma mark 设置区域数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int num;
    switch (_identifier)
    {
        case 0:
            num = _count;
            break;
    }
    return  num;
}

#pragma mark 设置各区域行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int num;
    switch (_identifier)
    {
        case 0:
            num = 1;
            break;
    }
    return num;
}

#pragma mark 设置headerView高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    float num;
    switch (_identifier)
    {
        case 0:
            num = 5.0;
            break;
    }
    return num;
}

#pragma mark 设置footerView高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    float num;
    switch (_identifier)
    {
        case 0:
            num = 0.1;
            break;
    }
    return 0.1;
}

#pragma mark 设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float num;
    switch (_identifier)
    {
        case 0:
        {
            NSArray * content_Pic = _source[indexPath.section][@"pic_urls"];
            if (_source[indexPath.section][@"retweeted_status"])
            {
                NSArray * content_Pic1 = _source[indexPath.section][@"retweeted_status"][@"pic_urls"];
                
                return [Factory contentHeight:_source[indexPath.section][@"text"]]+55+[Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]]+ceil(content_Pic1.count/3.0) * 70+25;
            }
            else
            {
               return ceil(content_Pic.count/3.0) * 70 + [Factory contentHeight:_source[indexPath.section][@"text"]]+70;
            }
        }
            break;
    }
    
    return num;
}

#pragma mark 返回 cell
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
    
    //初始化自定义 cell
    [self initCellForPageFirst:cell andIndexPath:indexPath];
    
    return cell;
}

#pragma mark 选择cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 初始化首页
- (void)initFirstPage
{
    //添加navigation左右两侧按钮的点击方法
    UIButton * menuButton = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [menuButton addTarget:self action:@selector(getView:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * findFriends = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [findFriends addTarget:self action:@selector(findFriends:) forControlEvents:UIControlEventTouchUpInside];
    
    //初始化数据
    _count = 20;
    _name = [NSMutableArray new];
    _weibo_Content_Pic = [NSMutableArray new];
    _weibo_Content_Pic1 = [NSMutableArray new];
    
    //准备播放器
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"msgcome" ofType:@"wav"]] error:nil];
    [_player prepareToPlay];
    
    //为标题栏添加标题
    [NavigationControllerCustomer setTitle:_userLoginName withColor:[UIColor blackColor] forViewController:self];
    
    //读取本地缓存数据
    NSString * str = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    _path = [NSString stringWithFormat:@"%@/Source.plist",str];
    if (![[NSFileManager defaultManager]fileExistsAtPath:_path isDirectory:nil])
    {
        [[NSFileManager defaultManager]copyItemAtPath:_path toPath:[[NSBundle mainBundle]pathForResource:@"Source" ofType:@"plist"] error:nil];
    }
    NSDictionary * dic11 = [GetDataOfLocalFile getContentOfPlistFileAtParh:NSCachesDirectory WithFileName:@"Source"];
    
    //读取失败，进行数据请求
    if (dic11.count == 0)
    {
        dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token andtype:WeiboTypeAll andMax_id:@"0"];
        [dic11 writeToFile:_path atomically:YES];
    }
    
    //准备数据源
    max_id = dic11[@"max_id"];
    NSLog(@"%@",dic11);
//    NSDictionary * dic11 = [GetDataOfLocalFile getContentOfPlistFileAtBundleWithFileName:@"File"];
    _source = [dic11[@"statuses"] mutableCopy];
    
    _userPic_Source = [NSMutableArray new];
    
    //获得显示数据
    [self getAppearSource];
    
    //添加tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _high-10) style:UITableViewStyleGrouped];
    _tableView.showsHorizontalScrollIndicator = 0;
    _tableView.showsVerticalScrollIndicator = 0;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = YES;
    [self.view addSubview:_tableView];
    
    //准备下拉刷新
    __weak UITableView * tableview = _tableView;
    [tableview addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        
        //延时隐藏refreshView;
        double delayInSeconds = 2.0;
        //创建延期的时间 2S
        dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        //延期执行
        dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{

            self.count = 20;
            
            NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token andtype:WeiboTypeAll andMax_id:@"0"];
            [dic11 writeToFile:_path atomically:YES];
            max_id = dic11[@"max_id"];
            
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
    
    //准备上拉加载
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
            
            NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token andtype:WeiboTypeAll andMax_id:max_id];
            max_id = dic11[@"max_id"];
           
            for (int i = 0; i < [dic11[@"statuses"] count]; i++)
            {
                [_source addObject:dic11[@"statuses"][i]];
            }
            [self getAppearSource];
            
            [tableview reloadData];
            
            //事情做完了别忘了结束刷新动画~~~
            [tableview footerEndRefreshing];
        });
        
    }];
}

#pragma mark 弹出选项列表
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

#pragma mark navigation左侧按钮点击方法
- (void)findFriends:(UIButton *)sender
{
    FindFriendViewController * find = [FindFriendViewController new];
    find.access_token = _access_token;
    find.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:find animated:YES];
}

#pragma mark 自定义cell
- (void)initCellForPageFirst:(UITableViewCell *)cell andIndexPath:(NSIndexPath *)indexPath
{
    int button_y;
    cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0];
    
    //用户名，时间和发布平台的底层view
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, 35)];
    view.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:view];
    
    //倒三角按钮
    UIButton * listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    listButton.frame = CGRectMake(_width-35, 5, 30, 30);
    [listButton setImage:[UIImage imageNamed:@"preview_icon_hidden_highlighted@2x.png"] forState:UIControlStateNormal];
    [listButton addTarget:self.tabBarController action:@selector(viewAppear) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:listButton];
    
    //用户头像
    UIImageView * user_Image = [[UIImageView alloc]initWithImage:_userPic_Source[indexPath.section]];
    user_Image.frame = CGRectMake(5, 5, 30, 30);
    [view addSubview:user_Image];
    
    //用户名
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 2, _width-40, 20)];
    label.text = _source[indexPath.section][@"user"][@"name"];
    [view addSubview:label];
    
    
    NSString * time = [Factory getDateWithSourceDate:_source[indexPath.section][@"created_at"] andSysDate:[NSString stringWithFormat:@"%@",[NSDate dateWithTimeIntervalSinceNow:8*3600]]];
    
    NSString * state = [[[[_source[indexPath.section][@"source"] componentsSeparatedByString:@">"]objectAtIndex:1] componentsSeparatedByString:@"<"] objectAtIndex:0];
    
    //发布时间
    UILabel * time_Label = [[UILabel alloc]initWithFrame:CGRectMake(40, 22, time.length*10, 10)];
    time_Label.font = [UIFont fontWithName:Nil size:10];
    time_Label.text = time;
    if ([time isEqualToString:@"刚刚"])
    {
        time_Label.textColor = [UIColor orangeColor];
    }
    [view addSubview:time_Label];
    
    //发布平台
    UILabel * state_Label = [[UILabel alloc]initWithFrame:CGRectMake(45+time.length*10, 22, (state.length+2)*18, 10)];
    state_Label.text = [NSString stringWithFormat:@"来自%@",state];
    state_Label.font = [UIFont systemFontOfSize:10];
    [view addSubview:state_Label];
    
    NSArray * content_Pic = _source[indexPath.section][@"pic_urls"];
    
    //微博底层view
    UIView * content_View = [[UIView alloc]initWithFrame:CGRectMake(0, 35, _width, [Factory contentHeight:_source[indexPath.section][@"text"]]+ceil(content_Pic.count/3.0) * 70+5)];
    content_View.backgroundColor = [UIColor whiteColor];
    content_View.userInteractionEnabled = 1;
    [cell.contentView addSubview:content_View];
    
    //为cell添加长按手势
    UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc]initWithTarget:self.tabBarController action:@selector(viewAppearance:)];
    [cell addGestureRecognizer:press];
    
    //微博内容
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
        
        //转发的微博的底层view
        UIView * content_View1 = [[UIView alloc]initWithFrame:CGRectMake(0, text.frame.origin.y+5+CGRectGetHeight(text.frame), _width, [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]]+ceil(content_Pic1.count/3.0) * 70+10)];
        content_View1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        
        content_View.frame = CGRectMake(0, 35, _width, [Factory contentHeight:_source[indexPath.section][@"text"]]+[Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"]]+ceil(content_Pic1.count/3.0) * 60);
        
        //转发的微博内容
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
        
        //转发的微博的配图
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
        
        //原创微博配图
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
    
    //功能按钮
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

#pragma mark 评论或转发
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

#pragma mark 赞
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

#pragma mark 获取显示资源
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
