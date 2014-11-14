#import "FindFriendViewController.h"
#import "EditViewController.h"
#import <ShareSDK/ShareSDK.h>
//#import <RennSDK/RennSDK.h>
#import "AAShareBubbles.h"
//#import "YXApi.h"

@interface FindFriendViewController ()
{
    AAShareBubbles * _shareBubbles; //分享平台
    NSMutableArray * _user_Pic; //用户头像
    NSArray * _source; //数据源
    int _width; //屏幕宽度
    int _high; //屏幕高度
    int _hide; //判断分享平台是否要出现
}

@end

@implementation FindFriendViewController

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
    [self init_View];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark 初始化界面
- (void)init_View
{
    self.navigationItem.hidesBackButton = YES;
    
    //为navigationBar设置标题，并添加返回按钮和右侧按钮
    [NavigationControllerCustomer createBackButtonForViewController:self
                                  hideOldBackButtonOfNavigationItem:YES
                                                            withTag:1
                                                          andImage : [UIImage imageNamed:@"toolbar_leftarrow@2x.png"]
                                                           orTitile:nil
                                                           andType : UIButtonTypeCustom];
    
    [NavigationControllerCustomer createRightBarButtonItemForViewController:self
                                                                    withTag:2
                                                                   andTitle:nil
                                                                  andImage : [UIImage imageNamed:@"navigationbar_more@2x.png"]
                                                                   andType : UIButtonTypeCustom];
    
    [NavigationControllerCustomer setTitle:@"好友推荐"
                                withColor : [UIColor blackColor]
                         forViewController:self];
    
    //获取屏幕尺寸
     NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    //请求推荐用户
    _source = [MicroBlogOperateForSina getSuggestedUserWithAccessToken:_access_token
                                                           andCategory:nil];

    _user_Pic = [NSMutableArray new];
    
    //获取用户头像
    for (int i = 0; i < _source.count; i++)
    {
        [_user_Pic addObject : [UIImage imageNamed:@"avatar_default_big@2x.png"]];
    }
    
    //设置分享平台
    _shareBubbles = [[AAShareBubbles alloc] initWithPoint : CGPointMake(_width/2, _high/2)
                                                    radius:160
                                                    inView:self.view];
    
    _shareBubbles.showTencentMicroblogBubble = 1;
    _shareBubbles.showSinaMicroblogBubble = 1;
    _shareBubbles.showMingdaoBubble = 1;
    _shareBubbles.showDouBanBubble = 1;
    _shareBubbles.showKaixinBubble = 1;
    _shareBubbles.showRenRenBubble = 1;
    _shareBubbles.showWangyiBubble = 1;
    _shareBubbles.showYixinBubble = 1;
    _shareBubbles.showMailBubble = 1;
    
    //为返回按钮添加方法
    UIButton * back = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    
    [back addTarget:self
             action:@selector(back)
  forControlEvents : UIControlEventTouchUpInside];
    
    //为右侧按钮添加方法
    UIButton * share = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    
    [share addTarget:self
              action:@selector(share)
   forControlEvents : UIControlEventTouchUpInside];
    
    //添加tableView
    UITableView * table_View = [[UITableView alloc] initWithFrame : CGRectMake(0, 0, _width, _high)
                                                            style : UITableViewStyleGrouped];
    
    table_View.showsHorizontalScrollIndicator = 0;
    table_View.showsVerticalScrollIndicator = 0;
    table_View.dataSource = self;
    table_View.delegate = self;
    table_View.bounces = 0;
    [self.view addSubview:table_View];
   
}

#pragma mark 返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return _source.count;
}

#pragma mark 创建cell
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"_cell"];
    
    if (!cell)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle : UITableViewCellStyleDefault
                                       reuseIdentifier:@"_cell"];
        
    }
    
    else
    {
        
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
        
    }
    
    UIView * bG = [[UIView alloc] initWithFrame : CGRectMake(0, 0, _width, 70)];
    [cell.contentView addSubview:bG];
    
    //显示用户头像
    UIImageView * userImage = [[UIImageView alloc] initWithFrame : CGRectMake(5, 5, 60, 60)];
    userImage.image = _user_Pic[indexPath.row];

    //当数组中指定位置不是网络下载的图片时，下载图片
    if ([_user_Pic[indexPath.row] isEqual : [UIImage imageNamed:@"avatar_default_big@2x.png"]])
    {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
        NSData * data = [[NSData alloc] initWithContentsOfURL : [NSURL URLWithString:_source[indexPath.row][@"avatar_hd"]]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                    _user_Pic[indexPath.row] = [UIImage imageWithData:data];
                    userImage.image = [UIImage imageWithData:data];
                
            });
        });
        
    }
    
    [bG addSubview:userImage];
    
    //添加用户名
    UILabel * user_Name = [[UILabel alloc] initWithFrame : CGRectMake(70, 5, _width-115, 30)];
    user_Name.text = _source[indexPath.row][@"name"];
    [bG addSubview:user_Name];
    
    //当用户是微博会员时，名字为橙色
    if ([_source[indexPath.row][@"verified"] intValue] == 1)
    {
        user_Name.textColor = [UIColor orangeColor];
    }
    
    //添加用户的自我介绍
    UILabel * introduce = [[UILabel alloc] initWithFrame : CGRectMake(70, 35, _width-115, 30)];
    introduce.text = _source[indexPath.row][@"description"];
    introduce.font = [UIFont systemFontOfSize:10];
    introduce.textColor = [UIColor darkGrayColor];
    introduce.numberOfLines = 2;
    [bG addSubview:introduce];
    
    //添加关系按钮
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(_width-35, 20, 30, 30);
    button.tag = indexPath.row+1;
    button.selected = YES;
    
    [button addTarget:self
               action:@selector(click_Button:)
    forControlEvents : UIControlEventTouchUpInside];
    
    [button setImage : [UIImage imageNamed:@"card_icon_addattention@2x.png"]
            forState : UIControlStateNormal];
    
    //当用户为我的关注好友时，显示删除关注
    if ([_source[indexPath.row][@"following"] intValue] == 1)
    {
        
        [button setImage : [UIImage imageNamed:@"card_icon_unfollow@2x.png"]
                forState : UIControlStateNormal];
        
        //当用户既是我的关注好友也是我的微博粉丝时，显示共同关注
        if ([_source[indexPath.row][@"follow_me"] intValue] == 1)
        {
            
            [button setImage : [UIImage imageNamed:@"card_icon_arrow@2x.png"]
                    forState : UIControlStateNormal];
            
        }
        
    }
    
    [bG addSubview:button];
    
    return cell;
}

#pragma mark 设置行高
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark 设置headerView高度
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

#pragma mark 创建headerView
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [UIView new];
    
    //分割线
    UILabel * seperateLine = [[UILabel alloc] initWithFrame : CGRectMake(0, 0, _width, 5)];
    seperateLine.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:seperateLine];
    
    UIImageView * imageView = [[UIImageView alloc] initWithImage : [UIImage imageNamed:@"tabbar_profile_selected@2x.png"]];
    imageView.frame = CGRectMake(5, 5, 25, 25);
    [view addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(35, 5, _width, 25)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"大新微博为您精心推荐:";
    label.textColor = [UIColor redColor];
    [view addSubview:label];
    
    return view;
}

#pragma mark 点击关系按钮
- (void)click_Button:(UIButton *)sender
{
    //点击按钮，更换相反关系的按钮
    if ([sender.imageView.image isEqual : [UIImage imageNamed:@"card_icon_addattention@2x.png"]])
    {
        
        [sender setImage : [UIImage imageNamed:@"card_icon_unfollow@2x.png"]
                forState : UIControlStateNormal];
        
        //点击添加关注，关注用户
        [MicroBlogOperateForSina followUserWithAccessToken:_access_token
                                                   andName:_source[sender.tag-1][@"name"]];
        
        if ([_source[sender.tag-1][@"follow_me"] intValue] == 1)
        {
            
            [sender setImage : [UIImage imageNamed:@"card_icon_arrow@2x.png"]
                    forState : UIControlStateNormal];
            
        }
        
    }
    
    else
    {
        
        [sender setImage : [UIImage imageNamed:@"card_icon_addattention@2x.png"]
                forState : UIControlStateNormal];
        
        //点击取消关注，删除用户
        [MicroBlogOperateForSina destroyFollowingWithAcccessToken:_access_token
                                                               iD:[_source[sender.tag-1][@"id"] integerValue]];
        
    }
    
}

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
        edit.name = _name;
        
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
//        [ShareSDK connectYiXinTimelineWithAppId:AppIdForYiXin
//                                       yixinCls:[YXApi class]];
        
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
//        [ShareSDK connectRenRenWithAppId:AppidForRenRen
//                                  appKey:AppkeyForRenRen
//                               appSecret:SecretkeyForRenRen
//                       renrenClientClass:[RennService class]];

    }
    
    if (buttonType == AAShareBubbleTypeYoutube)
    {
        
        //开心网
        [ShareSDK connectKaiXinWithAppKey:ApikeyForKaiXin
                                appSecret:SecretkeyForKaixin
                              redirectUri:RedirectURL];
        
    }
    
    [_shareBubbles shareButtonTappedWithType:buttonType];
    
}

#pragma mark 分享平台出现
- (void)share
{
    if (_hide == 1)
    {
        
        [_shareBubbles hide];
        
        //设置分享平台
        _shareBubbles = [[AAShareBubbles alloc] initWithPoint : CGPointMake(_width/2, _high/2)
                                                        radius:160
                                                        inView:self.view];
        _shareBubbles.showTencentMicroblogBubble = 1;
        _shareBubbles.showSinaMicroblogBubble = 1;
        _shareBubbles.showMingdaoBubble = 1;
        _shareBubbles.showDouBanBubble = 1;
        _shareBubbles.showKaixinBubble = 1;
        _shareBubbles.showRenRenBubble = 1;
        _shareBubbles.showWangyiBubble = 1;
        _shareBubbles.showYixinBubble = 1;
        _shareBubbles.showMailBubble = 1;
        _hide = 0;
        
    }
    
    else
    {
        
        [_shareBubbles show:self];
        _hide = 1;
        
    }
}

#pragma mark 返回上一个界面
- (void)back
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
