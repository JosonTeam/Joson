#import "FindFriendAndWeiboDetaileViewController.h"
#import "EditViewController.h"
#import <ShareSDK/ShareSDK.h>
//#import <RennSDK/RennClient.h>
#import "AAShareBubbles.h"
//#import "YXApi.h"

@interface FindFriendAndWeiboDetaileViewController ()
{
    AAShareBubbles * _shareBubbles; //分享平台
    NSMutableArray * _user_Pic; //用户头像
    UIImage * _userPic_Source;
    NSMutableArray * _weiboContentPic;
    NSArray * _button_Image;
    NSArray * _source; //数据源
    int _width; //屏幕宽度
    int _high; //屏幕高度
    int _hide; //判断分享平台是否要出现
}

@end

@implementation FindFriendAndWeiboDetaileViewController

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

#pragma mark 初始化界面
- (void)init_View
{
    self.navigationItem.hidesBackButton = YES;
    
    //获取屏幕尺寸
     NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    UITableView * table_View = [[UITableView alloc] initWithFrame : CGRectMake(0, 0, _width, _high)
                                                            style : UITableViewStyleGrouped];
    
    if ([_type isEqualToString:@"findFriend"])
    {
        [NavigationControllerCustomer setTitle:@"好友推荐"
                                withColor : [UIColor blackColor]
                         forViewController:self];
        
        //请求推荐用户
        _source = [MicroBlogOperateForSina getSuggestedUserWithAccessToken:_access_token
                                                               andCategory:nil];

        _user_Pic = [NSMutableArray new];
        
        //获取用户头像
        for (int i = 0; i < _source.count; i++)
        {
            [_user_Pic addObject : [UIImage imageNamed:@"avatar_default_big@2x.png"]];
        }

    }
    
    if ([_type isEqualToString:@"weiboDetaile"])
    {
        [NavigationControllerCustomer setTitle:@"微博正文"
                                    withColor : [UIColor blackColor]
                             forViewController:self];
        
        //功能按钮
        NSArray * button_Name = @[@"转发" , @"评论" , @"赞"];
        _button_Image = @[@"statusdetail_icon_retweet@2x.png" , @"statusdetail_icon_comment@2x.png" , @"statusdetail_comment_icon_like@2x.png" , @"statusdetail_comment_icon_like_highlighted@2x.png"];
        
        table_View.frame = CGRectMake(0, 64, _width, _high-94);
        
        _weiboContentPic = [NSMutableArray new];
        
        _userPic_Source = [UIImage imageNamed:@"tabbar_profile@2x.png"];
        
        //下载用户头像
        if ([_userPic_Source isEqual : [UIImage imageNamed:@"tabbar_profile@2x.png"]])
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSData * data = [[NSData alloc] initWithContentsOfURL : [NSURL URLWithString:_weiboSource[@"user"][@"avatar_large"]]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    _userPic_Source = [UIImage imageWithData:data];
                    
                    NSIndexPath * index = [NSIndexPath indexPathForRow:0 inSection:0];
                    
                    [table_View reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
                    
                });
                
            });
            
        }
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, _high - 30, _width, 30)];
        [self.view addSubview:view];
        
        for (int i = 0; i < 3; i++)
        {
            
            UIButton * button = [UIButton buttonWithType : UIButtonTypeCustom];
            button.frame = CGRectMake(1+i*_width/3, 2, _width/3-1, 25);
            
            [button setImage : [UIImage imageNamed:_button_Image[i]]
                    forState : UIControlStateNormal];
            
            [button setTitleColor : [UIColor blackColor]
                         forState : UIControlStateNormal];
            
            [button setTitle:button_Name[i]
                   forState : UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:12];
            button.backgroundColor = [UIColor whiteColor];
            button.tag = 1 + i;
            button.selected = YES;
            [view addSubview:button];
            
            switch (button.tag - 1)
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
    
        
    //设置分享平台
    _shareBubbles = [[AAShareBubbles alloc] initWithPoint : CGPointMake(_width/2, _high/2)
                                                    radius:160
                                                    inView:self.view];

    _shareBubbles.type = _type;
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
    table_View.showsHorizontalScrollIndicator = 0;
    table_View.showsVerticalScrollIndicator = 0;
    table_View.dataSource = self;
    table_View.delegate = self;
    table_View.bounces = 0;
    [self.view addSubview:table_View];
   
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_type isEqualToString:@"weiboDetaile"])
    {
        return 2;
    }
    return 1;
}

#pragma mark 返回行数
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if ([_type isEqualToString:@"weiboDetaile"])
    {
        return 1;
    }
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
    
    if ([_type isEqualToString:@"findFriend"])
    {
        
        [self findFriendInitCell:cell
                    andIndexPath:indexPath];
        
    }
    if ([_type isEqualToString:@"weiboDetaile"])
    {
        
        [self weiboDetaileInitCell:cell
                    andIndexPath:indexPath];
        
    }
    
    return cell;
}

- (void)weiboDetaileInitCell:(UITableViewCell *)cell
              andIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section)
    {
            
        case 0:
        {
            int button_y;

            //获得发布微博的时间和当前时间的差值
            NSString * time = [Factory getDateWithSourceDate:_weiboSource[@"created_at"]
                                                 andSysDate : [NSString stringWithFormat:@"%@", [NSDate dateWithTimeIntervalSinceNow:8*3600]] andType:@"weiboDetaile"];

            NSString * state = [@"来自" stringByAppendingString:[ [ [ [_weiboSource[@"source"] componentsSeparatedByString:@">"] objectAtIndex:1] componentsSeparatedByString:@"<"]  objectAtIndex:0]];

            int viewWidth = 40+[Factory contentWidth:_weiboSource[@"user"][@"name"] height:20 fontSize:20] > 45 + [Factory contentWidth:time height:10 fontSize:10]+[Factory contentWidth:state height:10 fontSize:10] ? 40+[Factory contentWidth:_weiboSource[@"user"][@"name"] height:20 fontSize:20] : [Factory contentWidth:time height:10 fontSize:10]+[Factory contentWidth:state height:10 fontSize:10];
            
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
            UIImageView * user_Image = [[UIImageView alloc] initWithImage:_userPic_Source];
            user_Image.frame = CGRectMake(5, 5, 30, 30);
            [view addSubview:user_Image];

            //用户名
            UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(40, 2, [Factory contentWidth:_weiboSource[@"user"][@"name"] height:20 fontSize:20], 20)];
            label.font = [UIFont systemFontOfSize:20.0f];
            label.text = _weiboSource[@"user"][@"name"];
            [view addSubview:label];

            //当用户是微博会员时，名字为橙色
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

            NSArray * content_Pic = _weiboSource[@"pic_urls"];

            //微博底层view
            UIView * content_View = [[UIView alloc] initWithFrame : CGRectMake(0, 35, _width, [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + ceil(content_Pic.count/3.0) * 70 + 5)];
            content_View.backgroundColor = [UIColor whiteColor];
            content_View.userInteractionEnabled = 1;
            [cell.contentView addSubview:content_View];

            //为cell添加长按手势
            UILongPressGestureRecognizer * press = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                                 action:@selector(viewAppearance:)];

            [cell addGestureRecognizer:press];

            //微博内容
            UITextView * text = [[UITextView alloc] initWithFrame : CGRectMake(5, 5, _width-10, [Factory contentHeight:_weiboSource[@"text"] width:_width-10])];
            text.text = _weiboSource[@"text"];

            text.userInteractionEnabled = 1;

            text.font = [UIFont fontWithName:nil
                                        size:15];

            text.scrollEnabled = NO;
            text.selectable = NO;
            text.editable = NO;
            [content_View addSubview:text];

            NSArray * arr = [_weiboSource allKeys];

            if ([arr containsObject:@"retweeted_status"])
            {

                NSArray * content_Pic1 = _weiboSource[@"retweeted_status"][@"pic_urls"];

                //转发的微博的底层view
                UIView * content_View1 = [[UIView alloc] initWithFrame : CGRectMake(0, text.frame.origin.y + 5 + CGRectGetHeight(text.frame), _width, [Factory contentHeight:_weiboSource[@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 70 + 10)];
                content_View1.userInteractionEnabled = 1;

                content_View1.backgroundColor = [UIColor colorWithWhite:0.9
                                                                  alpha:1];
            
                UITapGestureRecognizer * reportWeiboTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickReportContentView:)];
                [content_View1 addGestureRecognizer:reportWeiboTap];
                
                
                content_View.frame = CGRectMake(0, 35, _width, [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + [Factory contentHeight:_weiboSource[@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 60);

                //转发的微博内容
                UITextView * text1 = [[UITextView alloc] initWithFrame : CGRectMake(5, 5, _width-10, [Factory contentHeight:_weiboSource[@"retweeted_status"][@"text"] width:_width-10])];
                text1.text = [NSString stringWithFormat:@"@%@ :%@",_weiboSource[@"retweeted_status"][@"user"][@"name"] , _weiboSource[@"retweeted_status"][@"text"]];

                text1.font = [UIFont fontWithName:nil
                                             size:15];

                text1.backgroundColor = content_View1.backgroundColor;
                text1.scrollEnabled = NO;
                text1.selectable = NO;
                text1.editable = NO;
                [content_View1 addSubview:text1];
                
                UILabel * user_Name_Label = [[UILabel alloc] initWithFrame : CGRectMake(10, 10, [Factory contentWidth:[NSString stringWithFormat:@"@%@",_weiboSource[@"retweeted_status"][@"user"][@"name"]] height:20 fontSize:15], 20)];
                user_Name_Label.text = [NSString stringWithFormat:@"@%@",_weiboSource[@"retweeted_status"][@"user"][@"name"]];
                user_Name_Label.backgroundColor = content_View1.backgroundColor;
                user_Name_Label.userInteractionEnabled = 1;

                user_Name_Label.font = [UIFont fontWithName:nil
                                                       size:15.0f];
                
                user_Name_Label.textColor = [UIColor blueColor];
                [content_View1 addSubview:user_Name_Label];
                
                UITapGestureRecognizer * userNameTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickUserNameLabel:)];
                [user_Name_Label addGestureRecognizer:userNameTap];
                
                //转发的微博的配图
                
                for (int i = 0; i < content_Pic1.count; i++)
                {

                    [_weiboContentPic addObject : [UIImage imageNamed:@"message_placeholder_picture@2x.png"]];
                    UIImageView * image1 = [[UIImageView alloc] initWithFrame : CGRectMake(5 + (i%3)*_width/3, text1.frame.origin.y + 5 + CGRectGetHeight(text1.frame) + (i/3)*_width/3, _width/3-10, _width/3-10)];

                    if (content_Pic1.count == 4)
                    {
                        image1.frame = CGRectMake(5 + (i%2)*70, text1.frame.origin.y + 5 + CGRectGetHeight(text1.frame) + (i/2)*70, 60, 60);
                    }
                    
                    if (content_Pic1.count == 1)
                    {
                        image1.frame = CGRectMake(5, text1.frame.origin.y + 5 + CGRectGetHeight(text1.frame), _width - 10, _width - 10);
                    }
                    
                    image1.userInteractionEnabled = 1;
                    image1.tag = indexPath.section*100 + i;
                    image1.image =_weiboContentPic[i];
                    
                    if ([_weiboContentPic[i] isEqual : [UIImage imageNamed:@"message_placeholder_picture@2x.png"]])
                    {

                        //下载转发的微博配图
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                            
                            NSData * data1 = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_weiboSource[@"retweeted_status"][@"pic_urls"][i][@"thumbnail_pic"]]];
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                _weiboContentPic[i] = [UIImage imageWithData:data1];
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
                button_y = [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + 52 + [Factory contentHeight:_weiboSource[@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 70;

            }

            else
            {

                //原创微博配图
                
                for (int i = 0; i < content_Pic.count; i++)
                {

                    [_weiboContentPic addObject:[UIImage imageNamed:@"message_placeholder_picture@2x.png"]];
                    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(5 + (i%3)*70, text.frame.origin.y + 5+ CGRectGetHeight(text.frame) + (i/3)*70, 60, 60)];

                    if (content_Pic.count == 4)
                    {
                        image.frame = CGRectMake(5 + (i%2)*70, text.frame.origin.y + 5 + CGRectGetHeight(text.frame) + (i/2)*70, 60, 60);
                    }
                    
                    if (content_Pic.count == 1)
                    {
                        image.frame = CGRectMake(5, text.frame.origin.y + 5 + CGRectGetHeight(text.frame), _width - 10, _width - 10);
                    }

                    image.userInteractionEnabled = 1;
                    image.tag = indexPath.section*100+i;
                    image.image = _weiboContentPic[i];

                    if ([_weiboContentPic[i] isEqual : [UIImage imageNamed:@"message_placeholder_picture@2x.png"]])
                    {

                        //下载原创的微博配图
                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

                            NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:content_Pic[i][@"thumbnail_pic"]]];

                            dispatch_async(dispatch_get_main_queue(), ^{

                                _weiboContentPic[i] = [UIImage imageWithData:data];
                                image.image = [UIImage imageWithData:data];

                            });

                        });

                    }

                    [content_View addSubview:image];
                
                    UITapGestureRecognizer * tapToTouchPhoto = [[UITapGestureRecognizer alloc]initWithTarget:self.tabBarController
                                                                                                      action:@selector(getBigImage:)];

                    [image addGestureRecognizer:tapToTouchPhoto];
                
                }
            
                button_y = ceil(content_Pic.count/3.0) * 70 + [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + 42;
                
            }

        }
            break;
            
        case 1:
            
            break;
            
    }
    
}

- (void)findFriendInitCell:(UITableViewCell *)cell
              andIndexPath:(NSIndexPath *)indexPath
{
    
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
    
    if ([_source[indexPath.section][@"user"][@"verified"] intValue] == 1 && [_source[indexPath.section][@"user"][@"verified_type"] intValue] != -1)
    {
        
        UIImageView * verified_typeImage = [[UIImageView alloc] initWithFrame : CGRectMake(15, 15, 15, 15) ];
        [userImage addSubview:verified_typeImage];
        
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
    
}

#pragma mark 设置行高
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_type isEqualToString:@"weiboDetaile"])
    {
        
        switch (indexPath.section)
        {
            case 0:
            {
                NSArray * content_Pic = _weiboSource[@"pic_urls"];
                
                if (_weiboSource[@"retweeted_status"])
                {
                    
                    NSArray * content_Pic1 = _weiboSource[@"retweeted_status"][@"pic_urls"];
                    
                    if (content_Pic1.count == 1)
                    {
                        
                        return [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + [Factory contentHeight:_weiboSource[@"retweeted_status"][@"text"] width:_width-10] + 50+_width;

                    }
                    
                    return [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + [Factory contentHeight:_weiboSource[@"retweeted_status"][@"text"] width:_width-10] + ceil(content_Pic1.count/3.0) * 70 + 60;
                    
                }
                
                else
                {
                    
                    if (content_Pic.count == 1)
                    {
                        
                        return  [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + 40 + _width;
                        
                    }
                    
                    return ceil(content_Pic.count/3.0) * 70 + [Factory contentHeight:_weiboSource[@"text"] width:_width-10] + 50;
                }

            }
                break;
                
            case 1:
                
                break;
        }
        
    }
    
    return 70;
}

#pragma mark 设置headerView高度
- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    
    if ([_type isEqualToString:@"weiboDetaile"])
    {
        return 5;
    }
    
    return 35;
}

#pragma mark 创建headerView
- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView * view;
    
    if ([_type isEqualToString:@"findFriend"])
    {
        
        view = [UIView new];
        
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
    
    }
    
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

#pragma mark 分享平台出现
- (void)share
{
    if (_hide == 1)
    {
        [_shareBubbles hide:nil];
        
        //设置分享平台
        _shareBubbles = [[AAShareBubbles alloc] initWithPoint : CGPointMake(_width/2, _high/2)
                                                        radius:160
                                                        inView:self.view];
    
        _shareBubbles.type = _type;
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
