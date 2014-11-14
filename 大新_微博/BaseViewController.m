#import <AVFoundation/AVFoundation.h>
#import "FindFriendAndWeiboDetaileViewController.h"
#import "TabbarViewController.h"
#import "BaseViewController.h"
#import "MenuViewController.h"
#import "EditViewController.h"
#import <ShareSDK/ShareSDK.h>
//#import <RennSDK/RennSDK.h>
#import "AAShareBubbles.h"
#import "PhotoTableView.h"
#import "PopoverView.h"
#import "JHRefresh.h"
#import "MyView.h"
<<<<<<< Updated upstream
//#import "YXApi.h"

=======
#import "MoreViewController.h"
#import "FavoriteViewController.h"
#import "BgPicViewController.h"
#import "BaseInforViewController.h"
#import "EditTableViewController.h"
>>>>>>> Stashed changes
@interface BaseViewController ()
{
    
    NSMutableArray * _weibo_Content_Pic1; //转发微博配图
    NSMutableArray * _weibo_Content_Pic; //原创微博配图
    NSMutableArray * _userPic_Source; //用户头像
    UITableView * _tableView; //tableView
    AVAudioPlayer * _player; //音频播放器
    NSArray * _button_Image; //转发，评论和赞按钮的图片
    PhotoTableView * pt; //创建我页面相册
    NSString * max_id; //更新微博的起始代号
    NSString * _path; //文件路径
    MyView * mv; //创建我页面的view全局变量
    int _width; //屏幕宽度
    int _high; //屏幕高度
}

@end

@implementation BaseViewController

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

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#warning mark 下拉刷新出新问题
- (void)viewDidAppear:(BOOL)animated
{

    if (_identifier == 0)
    {
        
        //准备下拉刷新
        __weak UITableView * tableview = _tableView;
        
        [tableview addRefreshHeaderViewWithAniViewClass : [JHRefreshCommonAniView class]
                                           beginRefresh : ^{
                                               
           //延时隐藏refreshView;
           double delayInSeconds = 2.0;
           //创建延期的时间 2S
           dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
           //延期执行
           
           dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
               
               
               
               NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token
                                                                                           andtype:WeiboTypeAll
                                                                                         andMax_id:@"0"];
               
               NSData * data = [NSJSONSerialization dataWithJSONObject:dic11
                                                               options:NSJSONWritingPrettyPrinted
                                                                 error:nil];
               
               [data writeToFile:_path
                      atomically:YES];
               
               
               max_id = dic11[@"max_id"];
               
               _source = [dic11[@"statuses"] mutableCopy];
               _weibo_Content_Pic1 = [NSMutableArray new];
               _weibo_Content_Pic = [NSMutableArray new];
               _name = [NSMutableArray new];
               [self getAppearSource];
               self.count = 20;
               [tableview reloadData];
               
               //事情做完了别忘了结束刷新动画~~~
               [tableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
               [_player play];
               
           });
           
        }];
        
        //准备上拉加载
        [tableview addRefreshFooterViewWithAniViewClass : [JHRefreshCommonAniView class]
                                           beginRefresh : ^{
                                               
               //延时隐藏refreshView;
               double delayInSeconds = 2.0;
               //创建延期的时间 2S
               dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
               
               //延期执行
               dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
                   //            if (self.count == _source.count-_source.count%20)
                   //            {
                   
                   //            }
                   //            else if (_source.count%20 == 0)
                   //            {
                   //                self.count += _source.count%20;
                   //            }
                   
                   //获取最新微博
                   NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token
                                                                                               andtype:WeiboTypeAll
                                                                                             andMax_id:max_id];
                   max_id = dic11[@"max_id"];
                   
                   NSArray * status = dic11[@"statuses"];
                   
                   for (int i = 0; i < status.count; i++)
                   {
                       [_source addObject:status[i]];
                   }
                   
                   [self getAppearSource];
                   self.count += 20;
                   
                   [tableview reloadData];
                   
                   //事情做完了别忘了结束刷新动画~~~
                   [tableview footerEndRefreshing];
                   
               });
               
           }];
        
    }
        
}

#pragma mark 初始化界面
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
            [NavigationControllerCustomer createLeftBarButtonItemForViewController:self
                                                                           withTag:1
                                                                          andTitle:nil
                                                                         andImage : [UIImage imageNamed:@"navigationbar_friendsearch@2x.png"]
                                                                          andType : UIButtonTypeCustom];
            
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self
                                                                            withTag:2
                                                                           andTitle:nil
                                                                          andImage : [UIImage imageNamed:@"navigationbar_pop@2x.png"]
                                                                           andType : UIButtonTypeCustom];
            //初始化首页
            [self initFirstPage];

        }
            break;
            
        case 1:
        {
            
            //添加标题栏的右侧按钮
            [NavigationControllerCustomer createRightBarButtonItemForViewController:self
                                                                            withTag:2
                                                                           andTitle:@"发起聊天"
                                                                           andImage:nil
                                                                           andType : UIButtonTypeCustom];
            
        }
            break;
            
        case 2:
        {
            
            //为"+"界面添加背景
            UIImageView * bg_Image = [[UIImageView alloc] initWithFrame : CGRectMake(0, 0, _width, _high)];
            bg_Image.image = [UIImage imageNamed:@"Default-568h@2x2.png"];
            [self.view addSubview:bg_Image];
            
            //准备声音
            _player = [[AVAudioPlayer alloc] initWithContentsOfURL : [NSURL fileURLWithPath : [[NSBundle mainBundle] pathForResource:@"composer_open"
                                                                                               
                                                                                                                              ofType:@"wav"]]
                                                              error:nil];
            
            [_player prepareToPlay];
            
        }
            break;
            
        case 3:
        {
            //在标题栏上添加搜索栏和录音按钮
            [NavigationControllerCustomer createSearchBarWithViewController:self
                                                                    withTag:1
                                                         needRecorderButton:1
                                                                   andTitle:Nil
                                                                  andImage : [UIImage imageNamed:@"message_voice_background@2x.png"]
                                                                   andType : UIButtonTypeCustom
                                                              withButtonTag:2];
            
            [self createGround];
            
        }
            break;
            
        case 4:
        {
            
<<<<<<< Updated upstream
            //添加标题栏右侧按钮
//            [NavigationControllerCustomer createRightBarButtonItemForViewController:self
//                                                                            withTag:2
//                                                                           andTitle:@"设置"
//                                                                           andImage:nil
//                                                                           andType : UIButtonTypeCustom];
          
            max_id = @"0";
=======
            
>>>>>>> Stashed changes
            
            mv = [[MyView alloc]initWithFrame:self.view.frame];
            
            NSDictionary * data = [MicroBlogOperateForSina getWeiboOfUserWithAccessToken:_access_token
                                                                                    name:_userLoginName
<<<<<<< Updated upstream
                                                                                 andtype:WeiboTypeAll
                                                                                   andId:@"0"];
            
            max_id = data[@"max_id"];
            mv.dataText = data.mutableCopy;
=======
                                                                                 andtype:WeiboTypeAll];
            mv.dataText = data;
>>>>>>> Stashed changes
            mv.username = _userLoginName;
            mv.acc_token = _access_token;

            [mv createMe:self];
<<<<<<< Updated upstream
            
            __weak UITableView * tableview = mv.tableview;
            
            //准备上拉加载
            [tableview addRefreshFooterViewWithAniViewClass : [JHRefreshCommonAniView class]
                                               beginRefresh : ^{
                                                   
               //延时隐藏refreshView;
               double delayInSeconds = 2.0;
               //创建延期的时间 2S
               dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
               
               //延期执行
               dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
                   
                   //获取最新微博
                   NSDictionary * data = [MicroBlogOperateForSina getWeiboOfUserWithAccessToken:_access_token
                                                                                           name:_userLoginName
                                                                                        andtype:WeiboTypeAll
                                                                                          andId:max_id];
                   
                   max_id = data[@"max_id"];
                   
                   NSArray * status = data[@"statuses"];
                   
                   NSMutableArray * statuses = [mv.dataText[@"statuses"] mutableCopy];
                   
                   for (int i = 0; i < status.count; i++)
                   {
                       [statuses addObject:status[i]];
                   }
                   
                   [mv.dataText setObject:statuses forKey:@"statuses"];
                   
                   [tableview reloadData];
                   
                   //事情做完了别忘了结束刷新动画~~~
                   [tableview footerEndRefreshing];
                   
               });
               
           }];

            
=======
>>>>>>> Stashed changes
        }
            break;
    }
    
}

#pragma mark 初始化首页
- (void)initFirstPage
{
    
    //添加navigation左右两侧按钮的点击方法
    UIButton * menuButton = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    
    [menuButton addTarget:self
                   action:@selector(getView:)
        forControlEvents : UIControlEventTouchUpInside];
    
    UIButton * findFriends = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    
    [findFriends addTarget:self
                    action:@selector(findFriends:)
         forControlEvents : UIControlEventTouchUpInside];
    
    //初始化数据
    _count = 20;
    _name = [NSMutableArray new];
    _weibo_Content_Pic = [NSMutableArray new];
    _weibo_Content_Pic1 = [NSMutableArray new];
    
    //准备播放器
    _player = [[AVAudioPlayer alloc] initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"msgcome" ofType:@"wav"]] error:nil];
    
    [_player prepareToPlay];
    
    //为标题栏添加标题
    [NavigationControllerCustomer setTitle:_userLoginName
                                withColor : [UIColor blackColor]
                         forViewController:self];
    
    //读取本地缓存数据
    NSString * str = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    _path = [NSString stringWithFormat:@"%@/Source.json",str];
    
    if (![[NSFileManager defaultManager]fileExistsAtPath:_path isDirectory:nil])
    {
        [[NSFileManager defaultManager] copyItemAtPath: [[NSBundle mainBundle] pathForResource:@"Source"
                                                                                        ofType:@"json"]
                                                toPath:_path
                                                 error:nil];
    }
    
    NSDictionary * dic11 = [GetDataOfLocalFile getContentOfJsonFileAtParh:NSCachesDirectory
                                                             WithFileName:@"Source"];
    
    max_id = @"0";
    
    //读取失败，进行数据请求
    if (dic11.count == 0)
    {
        
        dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token
                                                                     andtype:WeiboTypeAll
                                                                   andMax_id:@"0"];
        
        max_id = dic11[@"max_id"];
        
        NSData * data = [NSJSONSerialization dataWithJSONObject:dic11
                                                        options:NSJSONWritingPrettyPrinted
                                                          error:nil];
<<<<<<< Updated upstream
        if (dic11.count != 3)
        {
            [data writeToFile:_path
=======
        
        [data writeToFile:_path
>>>>>>> Stashed changes
                atomically:YES];
        }
        
    }
    
    //准备数据源
    _source = [dic11[@"statuses"] mutableCopy];

    _userPic_Source = [NSMutableArray new];
    
    //获得显示数据
    [self getAppearSource];
    
    //添加tableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _high-10)
                                             style:UITableViewStyleGrouped];
    
    _tableView.showsHorizontalScrollIndicator = 0;
    _tableView.showsVerticalScrollIndicator = 0;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.bounces = YES;
    [self.view addSubview:_tableView];
<<<<<<< Updated upstream
    
    //准备下拉刷新
    __weak UITableView * tableview = _tableView;
    
    [tableview addRefreshHeaderViewWithAniViewClass : [JHRefreshCommonAniView class]
                                       beginRefresh : ^{
                                           
       //延时隐藏refreshView;
       double delayInSeconds = 2.0;
       //创建延期的时间 2S
       dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
       //延期执行
       
       dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
           
           NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token
                                                                                       andtype:WeiboTypeAll
                                                                                     andMax_id:@"0"];
           
           NSData * data = [NSJSONSerialization dataWithJSONObject:dic11
                                                           options:NSJSONWritingPrettyPrinted
                                                             error:nil];
           
           if (dic11.count != 3)
           {
               [data writeToFile:_path
                      atomically:YES];
           }

           
           max_id = dic11[@"max_id"];
           
           _source = [dic11[@"statuses"] mutableCopy];
           _weibo_Content_Pic1 = [NSMutableArray new];
           _weibo_Content_Pic = [NSMutableArray new];
           _name = [NSMutableArray new];
           
           self.count = 20;
           
           [self getAppearSource];
           
           [tableview reloadData];
           
           //事情做完了别忘了结束刷新动画~~~
           [tableview headerEndRefreshingWithResult:JHRefreshResultSuccess];
           
           [_player play];
           
       });
       
   }];
    
    //准备上拉加载
    [tableview addRefreshFooterViewWithAniViewClass : [JHRefreshCommonAniView class]
                                       beginRefresh : ^{
                                           
       //延时隐藏refreshView;
       double delayInSeconds = 2.0;
       //创建延期的时间 2S
       dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
       
       //延期执行
       dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
                      
           //获取最新微博
           NSDictionary * dic11 = [MicroBlogOperateForSina getRecentWeiboOfUserWithAccessToken:self.access_token
                                                                                       andtype:WeiboTypeAll
                                                                                     andMax_id:max_id];
           max_id = dic11[@"max_id"];
         
           NSArray * status = dic11[@"statuses"];
           _name = [NSMutableArray new];
           
           for (int i = 0; i < status.count; i++)
           {
               [_source addObject:status[i]];
           }
           
            self.count += 20;
           
           [self getAppearSource];
           
           [tableview reloadData];
           
           //事情做完了别忘了结束刷新动画~~~
           [tableview footerEndRefreshing];
           
       });
       
   }];
    
=======
>>>>>>> Stashed changes
}

#pragma mark 创建广场那一页
-(void)createGround
{
    UITableView * groundTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _high)];
    
    [self.view addSubview:groundTable];
}

#pragma mark 获取显示资源
- (void)getAppearSource
{
    
    for (int i = 0; i < _source.count; i ++)
    {
        
        NSMutableArray * pic_Array = [NSMutableArray new];
        [_weibo_Content_Pic addObject:pic_Array];
        
        //如果是转发的微博，则添加原博主的用户名
        if (_source[i][@"retweeted_status"])
        {
            
            [_name addObject:_source[i][@"retweeted_status"][@"user"][@"name"]];
            
        }
        
        else
        {
            
            [_name addObject:@" "];
            
        }
        
        //设置默认图片
        if (!_userPic_Source)
        {
            
            [_userPic_Source addObject : [UIImage imageNamed:@"tabbar_profile@2x.png"]];
            
        }
        
        else
        {
            
            [_userPic_Source setObject : [UIImage imageNamed:@"tabbar_profile@2x.png"]
                     atIndexedSubscript:i];
            
        }
        
        //下载用户头像
        if ([_userPic_Source[i] isEqual : [UIImage imageNamed:@"tabbar_profile@2x.png"]])
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSData * data = [[NSData alloc] initWithContentsOfURL : [NSURL URLWithString:_source[i][@"user"][@"avatar_large"]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _userPic_Source[i] = [UIImage imageWithData:data];
                    
                    [self performSelectorOnMainThread:@selector(refreshPhoto:)
                                          withObject : [NSNumber numberWithInteger:i]
                                        waitUntilDone:YES];
                    
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
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0
                                                 inSection:i];
    
    [_tableView reloadRowsAtIndexPaths:@[indexPath]
                     withRowAnimation : UITableViewRowAnimationAutomatic];
    
}

#pragma mark 设置区域数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    int num = 0;
    
    switch (_identifier)
    {
            
        case 0:
            
            num = _count;
            
            break;
            
    }
    
    return  num;
}

#pragma mark 设置各区域行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    
    int num = 0;
    
    switch (_identifier)
    {
            
        case 0:
            
            num = 1;
            
            break;
            
    }
    
    return num;
    
}

#pragma mark 设置headerView高度
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    
    float num = 0.0;
    
    switch (_identifier)
    {
            
        case 0:
            
            num = 5.0;
            
            break;
            
    }
    
    return num;
}

#pragma mark 设置footerView高度
- (CGFloat)tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section
{
    
    float num = 0.0;
    
    switch (_identifier)
    {
            
        case 0:
            
            num = 0.1;
            
            break;
            
    }
    
    return num;
}

#pragma mark 设置每行cell的高度
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
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
                
                return [Factory contentHeight:_source[indexPath.section][@"text"] width:_width-10] + [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 70 + 80;
                
            }
            
            else
            {
               return ceil(content_Pic.count/3.0) * 70 + [Factory contentHeight:_source[indexPath.section][@"text"] width:_width-10] + 70;
            }
            
        }
            break;
            
    }
    
    return num;
}

#pragma mark 返回 cell
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    
    if(cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle : UITableViewCellStyleDefault
                                       reuseIdentifier:@"reuseIdentifier"];
        
    }
    
    else
    {
        
        for (UIView * v in cell.contentView.subviews)
        {
            [v removeFromSuperview];
        }
        
    }
    
    //初始化自定义 cell
    [self initCellForPageFirst:cell
                  andIndexPath:indexPath];
    
    return cell;
}

#pragma mark 自定义cell
- (void)initCellForPageFirst:(UITableViewCell *)cell
                andIndexPath:(NSIndexPath *)indexPath
{
    int button_y;
    
//    cell.backgroundColor = [UIColor colorWithWhite:0.9
//                                             alpha:0];
    
    //获得发布微博的时间和当前时间的差值
    NSString * time = [Factory getDateWithSourceDate:_source[indexPath.section][@"created_at"]
                                         andSysDate : [NSString stringWithFormat:@"%@", [NSDate dateWithTimeIntervalSinceNow:8*3600]] andType:nil];
    
    NSString * state = [@"来自" stringByAppendingString:[ [ [ [_source[indexPath.section][@"source"] componentsSeparatedByString:@">"] objectAtIndex:1] componentsSeparatedByString:@"<"]  objectAtIndex:0]];
    
    int viewWidth = 40+[Factory contentWidth:_source[indexPath.section][@"user"][@"name"] height:20 fontSize:20] > 45 + [Factory contentWidth:time height:10 fontSize:10]+[Factory contentWidth:state height:10 fontSize:10] ? 40+[Factory contentWidth:_source[indexPath.section][@"user"][@"name"] height:20 fontSize:20] : [Factory contentWidth:time height:10 fontSize:10]+[Factory contentWidth:state height:10 fontSize:10];
    
    //用户名，时间和发布平台的底层view
    UIView * view = [[UIView alloc] initWithFrame : CGRectMake(0, 0, viewWidth, 35)];
    view.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:view];
    
    UITapGestureRecognizer * weiboTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserView:)];
    [view addGestureRecognizer:weiboTap];
    
    //倒三角按钮
    UIButton * listButton = [UIButton buttonWithType : UIButtonTypeCustom];
    listButton.frame = CGRectMake(_width-35, 5, 30, 30);
    listButton.tag = 10 + indexPath.section;
    
    [listButton setImage : [UIImage imageNamed:@"preview_icon_hidden_highlighted@2x.png"]
                forState : UIControlStateNormal];
    
    [listButton addTarget:self
                   action:@selector(viewAppear:)
        forControlEvents : UIControlEventTouchUpInside];
    
    [cell.contentView addSubview:listButton];
    
    //用户头像
    UIImageView * user_Image = [[UIImageView alloc] initWithImage:_userPic_Source[indexPath.section]];
    user_Image.frame = CGRectMake(5, 5, 30, 30);
    [view addSubview:user_Image];
    
    //用户名
    UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(40, 2, [Factory contentWidth:_source[indexPath.section][@"user"][@"name"] height:20 fontSize:20], 20)];
    label.font = [UIFont systemFontOfSize:20.0f];
    label.text = _source[indexPath.section][@"user"][@"name"];
    [view addSubview:label];
    
    
    if ([_source[indexPath.section][@"user"][@"verified"] intValue] == 1 && [_source[indexPath.section][@"user"][@"verified_type"] intValue] != -1)
    {
        
        UIImageView * verified_typeImage = [[UIImageView alloc] initWithFrame : CGRectMake(15, 15, 15, 15) ];
        [user_Image addSubview:verified_typeImage];
        
        switch ([_source[indexPath.section][@"user"][@"verified_type"] intValue])
        {
                
            case 0:
                
                [verified_typeImage setImage : [UIImage imageNamed:@"avatar_vip@2x.png"]];
                
                break;
                
            case 220:
                
                [verified_typeImage setImage : [UIImage imageNamed:@"avatar_grassroot@2x.png"]];
                
                break;
                
            default:
                
                [verified_typeImage setImage : [UIImage imageNamed:@"avatar_enterprise_vip@2x.png"]];
                
                break;
                
        }
        
    }
    
    //发布时间
    UILabel * time_Label = [[UILabel alloc] initWithFrame : CGRectMake(40, 25, [Factory contentWidth:time height:10 fontSize:10], 10)];
    
    time_Label.font = [UIFont fontWithName:Nil
                                      size:10];
    
    time_Label.text = time;
    
    if ([time isEqualToString:@"刚刚"])
    {
        time_Label.textColor = [UIColor orangeColor];
    }
    
    [view addSubview:time_Label];
    
    //发布平台
    UILabel * state_Label = [[UILabel alloc] initWithFrame : CGRectMake(45 + [Factory contentWidth:time height:10 fontSize:10], 25, [Factory contentWidth:state height:10 fontSize:10], 10)];
    state_Label.text = state;
    state_Label.font = [UIFont systemFontOfSize:10];
    [view addSubview:state_Label];
    
    NSArray * content_Pic = _source[indexPath.section][@"pic_urls"];
    
    //微博底层view
    UIView * content_View = [[UIView alloc] initWithFrame : CGRectMake(0, 35, _width, [Factory contentHeight:_source[indexPath.section][@"text"] width:_width-10] + ceil(content_Pic.count/3.0) * 70 + 5)];
    content_View.backgroundColor = [UIColor whiteColor];
    content_View.userInteractionEnabled = 1;
    [cell.contentView addSubview:content_View];
    
    //为cell添加长按手势
    UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                         action:@selector(viewAppearance:)];
    
    [cell addGestureRecognizer:press];
    
    //微博内容
    UITextView * text = [[UITextView alloc] initWithFrame : CGRectMake(5, 5, _width-10, [Factory contentHeight:_source[indexPath.section][@"text"] width:_width-10])];
    text.text = _source[indexPath.section][@"text"];
    
    text.userInteractionEnabled = 1;
    
    text.font = [UIFont fontWithName:nil
                                size:15];
    
    text.scrollEnabled = NO;
    text.selectable = NO;
    text.editable = NO;
    [content_View addSubview:text];
    
    NSArray * arr = [_source[indexPath.section] allKeys];
    
    if ([arr containsObject:@"retweeted_status"])
    {
        
        NSArray * content_Pic1 = _source[indexPath.section][@"retweeted_status"][@"pic_urls"];
        
        //转发的微博的底层view
        UIView * content_View1 = [[UIView alloc] initWithFrame : CGRectMake(0, text.frame.origin.y + 5 + CGRectGetHeight(text.frame), _width, [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 70 + 10)];
        content_View1.userInteractionEnabled = 1;
        
        content_View1.backgroundColor = [UIColor colorWithWhite:0.9
                                                          alpha:1];
        
        UITapGestureRecognizer * reportWeiboTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickReportContentView:)];
        [content_View1 addGestureRecognizer:reportWeiboTap];

        
        content_View.frame = CGRectMake(0, 35, _width, [Factory contentHeight:_source[indexPath.section][@"text"] width:_width-10] + [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 60);
        
        //转发的微博内容
        UITextView * text1 = [[UITextView alloc] initWithFrame : CGRectMake(5, 5, _width-10, [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"] width:_width-10])];
        text1.text = [NSString stringWithFormat:@"@%@ :%@",_name[indexPath.section] , _source[indexPath.section][@"retweeted_status"][@"text"]];
        
        text1.font = [UIFont fontWithName:nil
                                     size:15];
        
        text1.backgroundColor = content_View1.backgroundColor;
        text1.scrollEnabled = NO;
        text1.selectable = NO;
        text1.editable = NO;
        [content_View1 addSubview:text1];
       
        UILabel * user_Name_Label = [[UILabel alloc] initWithFrame : CGRectMake(10, 10, [Factory contentWidth:[NSString stringWithFormat:@"@%@",_name[indexPath.section]] height:20 fontSize:15], 20)];
        user_Name_Label.text = [NSString stringWithFormat:@"@%@",_name[indexPath.section]];
        user_Name_Label.backgroundColor = content_View1.backgroundColor;
        user_Name_Label.userInteractionEnabled = 1;
        
        user_Name_Label.font = [UIFont fontWithName:nil
                                               size:15.0f];
        
        user_Name_Label.textColor = [UIColor blueColor];
        [content_View1 addSubview:user_Name_Label];
        
        UITapGestureRecognizer * userNameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserNameLabel:)];
        [user_Name_Label addGestureRecognizer:userNameTap];
        
        //转发的微博的配图
        NSMutableArray * pic_Array1 = _weibo_Content_Pic1[indexPath.section];
        
        for (int i = 0; i < content_Pic1.count; i++)
        {
            
            [pic_Array1 addObject : [UIImage imageNamed:@"message_placeholder_picture@2x.png"]];
            UIImageView * image1 = [[UIImageView alloc] initWithFrame : CGRectMake(5 + (i%3)*70, text1.frame.origin.y + 5 + CGRectGetHeight(text1.frame) + (i/3)*70, 60, 60)];
            
            if (content_Pic1.count == 4)
            {
                image1.frame = CGRectMake(5 + (i%2)*70, text1.frame.origin.y + 5 + CGRectGetHeight(text1.frame) + (i/2)*70, 60, 60);
            }
            
            image1.userInteractionEnabled = 1;
            image1.tag = indexPath.section*100 + i;
            image1.image = _weibo_Content_Pic1[indexPath.section][i];
            
            if ([_weibo_Content_Pic1[indexPath.section][i] isEqual : [UIImage imageNamed:@"message_placeholder_picture@2x.png"]])
            {
                
                //下载转发的微博配图
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSData * data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:content_Pic1[i][@"thumbnail_pic"]]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _weibo_Content_Pic1[indexPath.section][i] = [UIImage imageWithData:data1];
                        image1.image = [UIImage imageWithData:data1];
                        
                    });
                    
                });
                
            }
            [content_View1 addSubview:image1];
            
            UITapGestureRecognizer * tapToTouchPhoto = [[UITapGestureRecognizer alloc]initWithTarget:self.tabBarController
                                                                                              action:@selector(getBigImage:)];
            
            [image1 addGestureRecognizer:tapToTouchPhoto];
            
        }
        
        [content_View addSubview:content_View1];
        button_y = [Factory contentHeight:_source[indexPath.section][@"text"] width:_width-10] + 52 + [Factory contentHeight:_source[indexPath.section][@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 70;
        
    }
    
    else
    {
        
        //原创微博配图
        NSMutableArray * pic_Array = _weibo_Content_Pic[indexPath.section];
        
        for (int i = 0; i < content_Pic.count; i++)
        {
            
            [pic_Array addObject:[UIImage imageNamed:@"message_placeholder_picture@2x.png"]];
            UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(5 + (i%3)*70, text.frame.origin.y + 5+ CGRectGetHeight(text.frame) + (i/3)*70, 60, 60)];
            
            if (content_Pic.count == 4)
            {
                image.frame = CGRectMake(5 + (i%2)*70, text.frame.origin.y + 5 + CGRectGetHeight(text.frame) + (i/2)*70, 60, 60);
            }
            
            image.userInteractionEnabled = 1;
            image.tag = indexPath.section*100+i;
            image.image = _weibo_Content_Pic[indexPath.section][i];
            
            if ([_weibo_Content_Pic[indexPath.section][i] isEqual : [UIImage imageNamed:@"message_placeholder_picture@2x.png"]])
            {
                
                //下载原创的微博配图
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:content_Pic[i][@"thumbnail_pic"]]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _weibo_Content_Pic[indexPath.section][i] = [UIImage imageWithData:data];
                        image.image = [UIImage imageWithData:data];
                        
                    });
                    
                });
                
            }
            
            [content_View addSubview:image];
            
            UITapGestureRecognizer * tapToTouchPhoto = [[UITapGestureRecognizer alloc]initWithTarget:self.tabBarController
                                                                                              action:@selector(getBigImage:)];
            
            [image addGestureRecognizer:tapToTouchPhoto];
            
        }
        
        button_y = ceil(content_Pic.count/3.0) * 70 + [Factory contentHeight:_source[indexPath.section][@"text"] width:_width-10] + 42;
        
    }
    
    //功能按钮
    NSArray * button_Name = @[@"转发" , @"评论" , @"赞"];
    _button_Image = @[@"statusdetail_icon_retweet@2x.png" , @"statusdetail_icon_comment@2x.png" , @"statusdetail_comment_icon_like@2x.png" , @"statusdetail_comment_icon_like_highlighted@2x.png"];
    
    for (int i = 0; i < 3; i++)
    {
        
        UIButton * button = [UIButton buttonWithType : UIButtonTypeCustom];
        button.frame = CGRectMake(1+i*_width/3, button_y, _width/3-1, 25);
        
        [button setImage : [UIImage imageNamed:_button_Image[i]]
                forState : UIControlStateNormal];
        
        [button setTitleColor : [UIColor blackColor]
                     forState : UIControlStateNormal];
        
        [button setTitle:button_Name[i]
               forState : UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = (indexPath.section+5)*10000 + i;
        button.selected = YES;
        [cell.contentView addSubview:button];
        
        switch (button.tag - (indexPath.section + 5)*10000)
        {
                
            case 1:
            case 0:
                
                [button addTarget:self
                           action:@selector(pushViewController:)
                forControlEvents : UIControlEventTouchUpInside];
                
                break;
                
            case 2:
                
                [button addTarget:self
                           action:@selector(changeColor:)
                forControlEvents : UIControlEventTouchUpInside];
                
                break;
                
        }
        
    }
    
}

#warning ...
- (void)clickUserView:(UITapGestureRecognizer *)sender
{
    
}

- (void)clickReportContentView:(UITapGestureRecognizer *)sender
{
    
}

- (void)clickUserNameLabel:(UITapGestureRecognizer *)sender
{
    
    UILabel * label = (UILabel *)sender.view;
    NSString * str = [[label.text componentsSeparatedByString:@"@"]lastObject];
    
    NSDictionary * dic = [MicroBlogOperateForSina getDetailOfUserWithAccessToken:_access_token name:nil orId:@"3270561561"];
    NSLog(@"%@",dic);
    
    BaseViewController * userDetaileViewController = [BaseViewController new];
    userDetaileViewController.access_token = _access_token;
    userDetaileViewController.userLoginName = str;
    userDetaileViewController.identifier = 4;
    [userDetaileViewController init_View];
    [self.navigationController pushViewController:userDetaileViewController animated:YES];
    
    
}

#pragma mark 选择cell
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    FindFriendAndWeiboDetaileViewController * weiboDetaile = [FindFriendAndWeiboDetaileViewController new];
    weiboDetaile.weiboSource = [MicroBlogOperateForSina getDetaileOfWeiboWithAccessToken:_access_token andId:_source[indexPath.section][@"id"]];//_source[indexPath.section];
    NSLog(@"%@",weiboDetaile.weiboSource);
    weiboDetaile.hidesBottomBarWhenPushed = YES;
    weiboDetaile.access_token = _access_token;
    weiboDetaile.type = @"weiboDetaile";
    weiboDetaile.name = _userLoginName;
    [weiboDetaile init_View];
    [self.navigationController pushViewController:weiboDetaile animated:YES];
    
}

#pragma mark 弹出选项列表
- (void)getView:(UIButton *)sender
{
    
    PopoverView * popover = [PopoverView new];
    popover.player = _player;

    //设置弹出位置和显示内容
    popover = [popover initWithPoint:CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height+15)
                              titles:@[@"扫一扫",@"刷新"]
                              images:@[@"navigationbar_pop1.png",@"navigationbar_refresh@2x.png"]];
   
    popover.selectRowAtIndex = ^(NSInteger index)
    {
        switch (index)
        {
            case 0:
                
                break;
            case 1:
            {
                
                
                [_tableView reloadData];
            }
                break;
        }
    };
    
    [popover show];
    
}

#pragma mark navigation左侧按钮点击方法
- (void)findFriends:(UIButton *)sender
{
    
    FindFriendAndWeiboDetaileViewController * find = [FindFriendAndWeiboDetaileViewController new];
    find.access_token = _access_token;
    find.name = _userLoginName;
    find.type = @"findFriend";
    [find init_View];
    find.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:find
                                         animated:YES];
    
}

#pragma mark 评论或转发
- (void)pushViewController:(UIButton *)sender
{
    EditViewController * edit = [EditViewController new];
    edit.hidesBottomBarWhenPushed = YES;
    edit.name = _userLoginName;
    edit.access_token = _access_token;
    
    switch (sender.tag % 10000)
    {
            
        case 0:
            
            edit.type = @"report";
            edit.source = _source[sender.tag/10000 - 5];
            
            break;
            
        case 1:
            
            edit.type = @"comment";
            edit.source = _source[(sender.tag-1)/10000 - 5];
            
            break;
            
    }
    
    [self.navigationController pushViewController:edit
                                         animated:YES];
    
}

#pragma mark 赞
- (void)changeColor:(UIButton *)sender
{
    
    if ([sender.imageView.image isEqual : [UIImage imageNamed:_button_Image[2]]])
    {
        
        [sender setImage : [UIImage imageNamed:_button_Image[3]]
                forState : UIControlStateNormal];
        
    }
    
    else
    {
        
        [sender setImage : [UIImage imageNamed:_button_Image[2]]
                forState : UIControlStateNormal];
        
    }
    
}

#pragma mark 点击了微博的倒三角按钮
- (void)viewAppear:(UIButton *)sender
{
    
    __weak TabbarViewController * tabBar = (TabbarViewController *)self.tabBarController;
    
    tabBar.cellName = @[@"收藏",@"取消关注",@"屏蔽",@"举报"];
    
    if ([_source[sender.tag-10][@"user"][@"name"] isEqualToString:_userLoginName])
    {
        tabBar.cellName = @[@"收藏" , @"推广" , @"删除"];
        
        tabBar.selectRowAtIndex = ^(NSInteger index)
        {
            switch (index)
            {
                    
                case 0:
                    
                    [MicroBlogOperateForSina createFavoriteWithAccessToken:_access_token
                                                                     andId:[_source[sender.tag-10][@"id"] integerValue]];
                    
                    break;
                    
                case 1:
#warning ...
                    break;
                    
                case 2:
                    
                    [MicroBlogOperateForSina destroyWeiBoWithAcccessToken:_access_token
                                                                       iD:[_source[sender.tag-10][@"id"] integerValue]];
                    
                    break;
                    
            }
            
            [tabBar viewDisappear];
            
        };
        
    }
    
    else
    {
    
        tabBar.selectRowAtIndex = ^(NSInteger index)
        {
            
            switch (index)
            {
                    
                case 0:
                    
                    [MicroBlogOperateForSina createFavoriteWithAccessToken:_access_token
                                                                     andId:[_source[sender.tag-10][@"user"][@"id"] integerValue]];
                    
                    break;
                    
                case 1:
                    
                    [MicroBlogOperateForSina destroyFollowingWithAcccessToken:_access_token
                                                                           iD:[_source[sender.tag-10][@"user"][@"id"] integerValue]];
                    
                    break;
                    
                case 2:
                    
                    [MicroBlogOperateForSina setUserUninterestedWithAccessToken:_access_token
                                                                          andId:[_source[sender.tag-10][@"user"][@"id"] integerValue]];
                    
                    break;
                    
                case 3:
                    
                    break;
                    
            }
            
        };
   
    }
    
    [tabBar.table_View reloadData];
    
    [UIView animateWithDuration:0.5
                    animations : ^{
                        
                        tabBar.hide_View.frame = CGRectMake(0, 0, _width, _high);
                        tabBar.table_View.frame = CGRectMake(10, _high/2-100, _width-20, tabBar.cellName.count*50);
                        
                    }];
    
}

#pragma mark 对首页的cell进行长按
- (void)viewAppearance:(UILongPressGestureRecognizer *)sender
{
    
    __weak TabbarViewController * tabBar = (TabbarViewController *)self.tabBarController;
    
    UITableViewCell * cell = (UITableViewCell *)sender.view;
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];

    if(_source[indexPath.section][@"retweeted_status"])
    {
        
        if ([_source[indexPath.section][@"user"][@"name"] isEqualToString:_userLoginName])
        {
            
            tabBar.cellName = @[@"转发" , @"评论" , @"收藏" , @"删除" , @"转发原微博"];
            
            tabBar.selectRowAtIndex = ^(NSInteger index)
            {
                switch (index)
                {
                        
                    case 0:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"report";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 1:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"comment";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 2:
                        
                        [MicroBlogOperateForSina createFavoriteWithAccessToken:_access_token
                                                                         andId:[_source[indexPath.section][@"id"] integerValue]];
                        
                        break;
                        
                    case 3:
                        
                        [MicroBlogOperateForSina destroyWeiBoWithAcccessToken:_access_token
                                                                           iD:[_source[indexPath.section][@"id"] integerValue]];
                        
                        break;
                        
                    case 4:
                    {
                        
                        if (_source[indexPath.section][@"retweeted_status"])
                        {
                            
                            EditViewController * edit = [EditViewController new];
                            edit.source = _source[indexPath.section][@"retweeted_status"];
                            edit.access_token = _access_token;
                            edit.name = _userLoginName;
                            edit.type = @"report";
                            
                            [self.navigationController pushViewController:edit
                                                                 animated:YES];
                            
                        }
                        
                    }
                        break;
                        
                }
                
                [tabBar viewDisappear];
                
            };

        }
        
        else
        {
            
            tabBar.cellName = @[@"转发" , @"评论" , @"收藏" , @"转发原微博"];
            
            tabBar.selectRowAtIndex = ^(NSInteger index)
            {
                
                switch (index)
                {
                        
                    case 0:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"report";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 1:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"comment";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 2:
                    {
                        
                        [MicroBlogOperateForSina createFavoriteWithAccessToken:_access_token
                                                                         andId:[_source[indexPath.section][@"id"] integerValue]];
                        
                    }
                        break;
                        
                    case 3:
                    {
                        
                        if (_source[indexPath.section][@"retweeted_status"])
                        {
                            
                            EditViewController * edit = [EditViewController new];
                            edit.source = _source[indexPath.section][@"retweeted_status"];
                            edit.access_token = _access_token;
                            edit.name = _userLoginName;
                            edit.type = @"report";
                            
                            [self.navigationController pushViewController:edit
                                                                 animated:YES];
                            
                        }
                        
                    }
                        break;
                        
                }
                
                [tabBar viewDisappear];
                
            };
            
        }
        
    }
    
    else
    {
        
        if ([_source[indexPath.section][@"user"][@"name"] isEqualToString:_userLoginName])
        {
            tabBar.cellName = @[@"转发" , @"评论" , @"收藏" , @"删除"];
            
            tabBar.selectRowAtIndex = ^(NSInteger index)
            {
                switch (index)
                {
                        
                    case 0:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"report";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 1:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"comment";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 2:
                        
                        [MicroBlogOperateForSina createFavoriteWithAccessToken:_access_token
                                                                         andId:[_source[indexPath.section][@"id"] integerValue]];
                        
                        break;
                        
                    case 3:
                        
                        [MicroBlogOperateForSina destroyWeiBoWithAcccessToken:_access_token
                                                                           iD:[_source[indexPath.section][@"id"] integerValue]];
                        
                        break;
                        
                }
                
                [tabBar viewDisappear];
                
            };
            
        }
        
        else
        {
            
            tabBar.cellName = @[@"转发" , @"评论" , @"收藏"];
            
            tabBar.selectRowAtIndex = ^(NSInteger index)
            {
                
                switch (index)
                {
                        
                    case 0:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"report";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 1:
                    {
                        
                        EditViewController * edit = [EditViewController new];
                        edit.source = _source[indexPath.section];
                        edit.access_token = _access_token;
                        edit.name = _userLoginName;
                        edit.type = @"comment";
                        
                        [self.navigationController pushViewController:edit
                                                             animated:YES];
                        
                    }
                        break;
                        
                    case 2:
                    {
                        
                        [MicroBlogOperateForSina createFavoriteWithAccessToken:_access_token
                                                                         andId:[_source[indexPath.section][@"id"] integerValue]];
                        
                    }
                        break;
                        
                }
                
                [tabBar viewDisappear];
                
            };
            
        }
        
    }
    
    [tabBar.table_View reloadData];
    
    [UIView animateWithDuration:0.5
                    animations : ^{
                        
                        tabBar.hide_View.frame = CGRectMake(0, 0, _width, _high);
                        tabBar.table_View.frame = CGRectMake(10, _high/2-100, _width-20, tabBar.cellName.count*50);
                        
                    }];
    
}

#pragma 我页面下:主页,微博,相册,更多之间的跳转
-(void)clickSection:(UIButton *)sender
{
    
    if (sender.tag == 1)
    {
        
        if (pt)
        {
            pt = nil;
            [pt removeFromSuperview];
        }
        
        if (mv)
        {
            mv = nil;
            [mv removeFromSuperview];
        }
<<<<<<< Updated upstream
        
        if (pt)
        {
            pt = nil;
            [pt removeFromSuperview];
        }
=======

      
>>>>>>> Stashed changes
        
        NSDictionary * data = [MicroBlogOperateForSina getWeiboOfUserWithAccessToken:_access_token
                                                                                name:_userLoginName
                                                                             andtype:WeiboTypeAll
                                                                               andId:@"0"];
        max_id = data[@"max_id"];
        
        mv = [[MyView alloc] initWithFrame:self.view.frame];
        mv.dataText = data.mutableCopy;
        mv.username = _userLoginName;
        mv.acc_token = _access_token;

        
        [mv createMe:self];
        
        __weak UITableView * tableview = mv.tableview;
        
        //准备上拉加载
        [tableview addRefreshFooterViewWithAniViewClass : [JHRefreshCommonAniView class]
                                           beginRefresh : ^{
                                               
           //延时隐藏refreshView;
           double delayInSeconds = 2.0;
           //创建延期的时间 2S
           dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
           
           //延期执行
           dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
               
               //获取最新微博
               NSDictionary * data = [MicroBlogOperateForSina getWeiboOfUserWithAccessToken:_access_token
                                                                                       name:_userLoginName
                                                                                    andtype:WeiboTypeAll
                                                                                      andId:max_id];
               
               max_id = data[@"max_id"];
               
               NSArray * status = data[@"statuses"];
               
               NSMutableArray * statuses = [mv.dataText[@"statuses"] mutableCopy];
               
               for (int i = 0; i < status.count; i++)
               {
                   [statuses addObject:status[i]];
               }
               
               [mv.dataText setObject:statuses forKey:@"statuses"];
               
               [tableview reloadData];
               
               //事情做完了别忘了结束刷新动画~~~
               [tableview footerEndRefreshing];
               
           });
           
       }];

        
    }
    
    if (sender.tag == 2)
    {
<<<<<<< Updated upstream
=======
        
        if (pt)
        {
            pt = nil;
            [pt removeFromSuperview];
        }
        
        if (mv)
        {
            mv = nil;
            [mv removeFromSuperview];
        }

>>>>>>> Stashed changes
        
        if (mv)
        {
            mv = nil;
            [mv removeFromSuperview];
        }
        
        if (pt)
        {
            pt = nil;
            [pt removeFromSuperview];
        }
                
        
        
        NSDictionary * data = [MicroBlogOperateForSina getPicListWithAccessToken:_access_token
                                                                           andId:[[MicroBlogOperateForSina getIdWithAccessToken:_access_token][@"uid"] integerValue]];
        
        NSLog(@"%@",data);
        
        pt = [[PhotoTableView alloc] initWithFrame:self.view.frame];
        pt.username = _userLoginName;
        pt.acc_token = _access_token;

        pt.dataText = data.mutableCopy;
        
        [pt createMe:self];
        
        
        __weak UITableView * tableview = pt.tableview;
        
        //准备上拉加载
        [tableview addRefreshFooterViewWithAniViewClass : [JHRefreshCommonAniView class]
                                           beginRefresh : ^{
                                               
           //延时隐藏refreshView;
           double delayInSeconds = 2.0;
           //创建延期的时间 2S
           dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
           
           //延期执行
           dispatch_after(delayInNanoSeconds, dispatch_get_main_queue(), ^{
               
               //获取最新微博
               NSDictionary * data = [MicroBlogOperateForSina getPicListWithAccessToken:_access_token
                                                                                  andId:[[MicroBlogOperateForSina getIdWithAccessToken:_access_token][@"uid"] integerValue]];
               
               
               NSArray * status = data[@"statuses"];
               
               NSMutableArray * statuses = [pt.dataText[@"statuses"] mutableCopy];
               
               for (int i = 0; i < status.count; i++)
               {
                   [statuses addObject:status[i]];
               }
               
               [pt.dataText setObject:statuses forKey:@"statuses"];
               
               [tableview reloadData];
               
               //事情做完了别忘了结束刷新动画~~~
               [tableview footerEndRefreshing];
               
           });
           
       }];

        
    }
    
    if (sender.tag == 3)
    {
        
        //sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height
        CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height);
        NSArray * titles = @[@"新的好友",@"我的收藏",@"微博支付",@"个性化",@"我的名片",@"设置"];
//        NSArray * images =@[@"poi_icon_myplace@2x",@"tabbar_compose_photo@2x",@"messagescenter_good@2x",@"tabbar_compose_envelope@2x.png",@"findfriend_icon_star@2x",@"qrcode_tabbar_icon_qrcode_highlighted@2x"];
        
        PopoverView * pop = [[PopoverView alloc] initWithPoint:point
                                                        titles:titles
                                                        images:nil];
        
        pop.selectRowAtIndex = ^(NSInteger index)
        {
            switch (index)
            {
                case 0:
                {
                    MoreViewController * mvc = [MoreViewController new];
                    
                    mvc.flag = index;
                    mvc.titleText = titles[index];
                    
                    mvc.acctoken = _access_token;
                    mvc.username = _userLoginName;
                    NSLog(@"你选中了%@",titles[index]);
                    [self presentViewController:mvc animated:YES completion:nil];

                }
                    break;
                    
                case 1:
                {
                    FavoriteViewController * fvc = [FavoriteViewController new];
                    fvc.acctoken = _access_token;
                    fvc.username = _userLoginName;
                    fvc.titleText = titles[index];
                    
                    [self presentViewController:fvc animated:YES completion:nil];
                
                    NSLog(@"你选中了%@",titles[index]);
                }
                    
                    break;
                case 2:
                    NSLog(@"你选中了%@",titles[index]);
                    break;
                case 3:
                {
                    BgPicViewController * bvc = [BgPicViewController new];
                    
                    
                    [NavigationControllerCustomer setTitle:titles[index] withColor:[UIColor blackColor] forViewController:bvc];
                    [NavigationControllerCustomer createBackButtonForViewController:bvc hideOldBackButtonOfNavigationItem:YES withTag:1 andImage:nil orTitile:@"返回" andType:UIButtonTypeCustom];
                    [NavigationControllerCustomer createRightBarButtonItemForViewController:bvc withTag:2 andTitle:nil andImage:[UIImage imageNamed:@"userinfo_tabicon_more@2x"] andType:UIButtonTypeCustom];
                    
                    
                    UINavigationController * navi =  [NavigationControllerCustomer createNavigationControllerWithViewController:bvc];
                    NSLog(@"你选中了%@",titles[index]);
                    [self presentViewController:navi animated:YES completion:nil];
                }
                    
                    break;
                case 4:
         
                    NSLog(@"你选中了%@",titles[index]);
                    break;
                
                case 5:
                {
                    EditTableViewController * etvc = [EditTableViewController new];
                    
                    
                    [NavigationControllerCustomer setTitle:@"设置" withColor:[UIColor blackColor] forViewController:etvc];
                    [NavigationControllerCustomer createBackButtonForViewController:etvc hideOldBackButtonOfNavigationItem:YES withTag:1 andImage:[UIImage imageNamed:@"userinfo_tabicon_back@2x"] orTitile:nil andType:UIButtonTypeCustom];
                    
                    
                    UINavigationController * navi =  [NavigationControllerCustomer createNavigationControllerWithViewController:etvc];
                    
                    [self presentViewController:navi animated:YES completion:nil];

                }
                    break;
                    
                    
                default:
                    break;
            }
            
                    };
        [pop show];
        
    }
    
    
}

<<<<<<< Updated upstream
#pragma mark 选择分享平台
-(void)buttonWasTapped:(UIButton *)button
{
    AAShareBubbleType buttonType = (AAShareBubbleType)[_bubbleIndexTypes[@(button.tag)] intValue];
    
    //选择平台
    if (buttonType == AAShareBubbleTypeFacebook)
    {
        
        //新浪微博
        [ShareSDK connectSinaWeiboWithAppKey:AppkeyForSinaMicroblog
                                   appSecret:AppsecretForSinaMicroblog
                                 redirectUri:RedirectURL];
        
        EditViewController * edit = [EditViewController new];
        edit.type = @"share";
        edit.name = _userLoginName;
        
        [self.navigationController pushViewController:edit
                                             animated:YES];
        
    }
    
    if (buttonType == AAShareBubbleTypeTwitter)
    {
        
        //腾讯微博
        [ShareSDK connectTencentWeiboWithAppKey:AppkeyForTencentMicroblog
                                      appSecret:AppsecretForTencentMicroblog
                                    redirectUri:RedirectURL];
        
    }
    
    if (buttonType == AAShareBubbleTypeGooglePlus)
    {
        
        //易信
        [ShareSDK connectYiXinTimelineWithAppId:AppIdForYiXin
                                       yixinCls:nil];
        
    }
    
    if (buttonType == AAShareBubbleTypeTumblr)
    {
        
        //明道
        [ShareSDK connectMingDaoWithAppKey:AppkeyForMingDao
                                 appSecret:AppsecretForMingDao
                               redirectUri:RedirectURL];
        
    }
    
    if (buttonType == AAShareBubbleTypeMail)
    {
        
        //邮件
        [ShareSDK connectMail];
        
    }
    
    if (buttonType == AAShareBubbleTypeVk)
    {
        
        //网易微博
        [ShareSDK connect163WeiboWithAppKey:ConsumerkeyForWangYi
                                  appSecret:ConsumersecretForWangyi
                                redirectUri:RedirectURL];
        
    }
    
    if (buttonType == AAShareBubbleTypeLinkedIn)
    {
        
        //豆瓣
        [ShareSDK connectDoubanWithAppKey:ApikeyforDouBan
                                appSecret:AppsecretForDouBan
                              redirectUri:RedirectURL];
        
    }
    
    if (buttonType == AAShareBubbleTypePinterest)
    {
        
        //人人
        [ShareSDK connectRenRenWithAppId:AppidForRenRen
                                  appKey:AppkeyForRenRen
                               appSecret:SecretkeyForRenRen
                       renrenClientClass:nil];
        
    }
    
    if (buttonType == AAShareBubbleTypeYoutube)
    {
        
        //开心网
        [ShareSDK connectKaiXinWithAppKey:ApikeyForKaiXin
                                appSecret:SecretkeyForKaixin
                              redirectUri:RedirectURL];
        
    }
    
    //    [_shareBubbles shareButtonTappedWithType:buttonType];
    
}

=======
-(void)clickEdit:(UIButton *)sender
{
    BaseInforViewController * bivc = [BaseInforViewController new];
    bivc.acc_token = _access_token;
    bivc.username  = _userLoginName;
    
    
    [NavigationControllerCustomer setTitle:@"基本信息" withColor:[UIColor blackColor] forViewController:bivc];
    [NavigationControllerCustomer createBackButtonForViewController:bivc hideOldBackButtonOfNavigationItem:YES withTag:1 andImage:[UIImage imageNamed:@"userinfo_tabicon_back@2x"] orTitile:nil andType:UIButtonTypeCustom];
    
    
    UINavigationController * navi =  [NavigationControllerCustomer createNavigationControllerWithViewController:bivc];

    [self presentViewController:navi animated:YES completion:nil];
    
}


>>>>>>> Stashed changes
@end
