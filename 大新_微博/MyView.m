//
//  MyView.m
//  大新_微博
//
//  Created by YF01-D05 on 14-11-6.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import "MyView.h"
#import "PopoverView.h"
#import "PhotoTableView.h"
#import "Factory.h"
#import "JSKit.h"
#import "TabbarViewController.h"
@implementation MyView
{
    int _width;
    int _high;
    PhotoTableView * photoTableView;//相册tableview
    UITableView * tableview;//我的微博tableview
    UIView * meView;//表头
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

#pragma mark 我那一页的界面创建


-(void)createMe:(UIViewController *)sender
{
    
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, _width, _high) style:UITableViewStyleGrouped];
    tableview.showsHorizontalScrollIndicator = NO;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.bounces = YES;
    
    
    
    meView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _width, _high-308)];
    meView.backgroundColor = [UIColor whiteColor];
    meView.userInteractionEnabled = YES;
    
    
    NSArray * arr = [[NSArray alloc]initWithObjects:@"主页",@"微博",@"相册",@"更多", nil];
    
    for (int i = 0; i < arr.count; i++)
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i * 50 + 55, _high-338, 50, 40)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:sender action:@selector(clickSection:) forControlEvents:UIControlEventTouchUpInside];
        [meView addSubview:btn];
    }
    
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    UIImageView * headImageView = [[UIImageView alloc]init];
    headImageView.frame = CGRectMake(0, 0, _width, _high-398);
    headImageView.image = [UIImage imageNamed:@"login_introduce_bg4.jpg"];
    headImageView.userInteractionEnabled = YES;
    [meView addSubview:headImageView];
    
    UIButton * shareBtn = [UIButton new];
    shareBtn.frame = CGRectMake(_width-40, 5, 30, 30);
    [shareBtn setImage:[UIImage imageNamed:@"userinfo_navigationbar_more@2x"] forState:UIControlStateNormal];
    shareBtn.backgroundColor = [UIColor blackColor];
    shareBtn.alpha = 0.7;
    shareBtn.tag = 99;
    [shareBtn addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
    [headImageView addSubview:shareBtn];
    
    UIButton * search = [[UIButton alloc]initWithFrame:CGRectMake(_width-80, 5, 35, 30)];
    [search setImage:[UIImage imageNamed:@"userinfo_navigationbar_search@2x"] forState:UIControlStateNormal];
    search.backgroundColor = [UIColor blackColor];
    search.alpha = 0.7;
    [headImageView addSubview:search];
    
    UIView * view = [UIView new];
    view.frame = CGRectMake(_width-205, 25, 80, 80);
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.6;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 40;
    [headImageView addSubview:view];
    
#pragma 用户头像
    UIImageView * TXimage = [[UIImageView alloc]initWithFrame:CGRectMake(_width-200, 30, 70, 70)];
    TXimage.layer.masksToBounds = YES;
    TXimage.layer.cornerRadius = 35;
    
    //图片下载
    NSURLRequest * request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:_dataText[@"statuses"][0][@"user"][@"avatar_hd"]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData * data, NSError *connectionError)
     {
         TXimage.image = [UIImage imageWithData:data];
     }];
    
    
    
    [headImageView addSubview:TXimage];
#pragma 用户名字
    UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(105, 105, 200, 30)];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = _username;
    nameLabel.font = [UIFont systemFontOfSize:20];
    [headImageView addSubview:nameLabel];
#pragma 用户关注数粉丝数
    UILabel * fanLabel = [[UILabel alloc]initWithFrame:CGRectMake(70, 130, 200, 30)];
    fanLabel.textColor = [UIColor whiteColor];
//    fanLabel.text = @"关注 300 | 粉丝 150";
    fanLabel.font = [UIFont systemFontOfSize:20];
    
    //获取access_token和 uid 然后获取粉丝数和关注数
    NSDictionary * iddata = [MicroBlogOperateForSina getIdWithAccessToken:_acc_token];
    NSArray * AFdata = [MicroBlogOperateForSina getCountOfAllWithAccessToken:_acc_token andUid:@[[NSString stringWithFormat:@"%@",iddata[@"uid"]]]];
    NSLog(@"AFdata = %@",AFdata);
    fanLabel.text = [[NSString alloc]initWithFormat:@"关注 %@ | 粉丝 %@",AFdata[0][@"friends_count"],AFdata[0][@"followers_count"]];
    
    
    [headImageView addSubview:fanLabel];
    
    UILabel * introView = [[UILabel alloc]initWithFrame:CGRectMake(105, 170, 100, 30)];
    introView.text = @"简介:暂无简介";
    introView.font = [UIFont systemFontOfSize:15];
    [meView addSubview:introView];
    
    UIButton * editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake(105, 200, 100, 30);
    editBtn.layer.cornerRadius = 5;
    editBtn.layer.borderColor = [UIColor blackColor].CGColor;
    editBtn.layer.borderWidth = 1.0;
    editBtn.alpha = 0.7;
    
    [meView addSubview:editBtn];
    
    
    //navigationbar_account_edit@2x
    UIImageView * editImg = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
    editImg.image = [UIImage imageNamed:@"navigationbar_account_edit@2x"];
    [editBtn addSubview:editImg];
    
    UILabel * editlabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 70, 30)];
    editlabel.text = @"编辑资料";
    [editBtn addSubview:editlabel];
    
    tableview.tableHeaderView = meView;
    
    [self addSubview:tableview];
    [sender.view addSubview:self];
    
}

-(void)clickShare:(UIButton *)sender
{
    UIButton * shareBtn = (UIButton *)[self viewWithTag:99];
    [shareBtn setImage:[UIImage imageNamed:@"userinfo_navigationbar_more_highlighted@2x"] forState:UIControlStateNormal];
}


-(void)clickSection:(UIButton *)sender
{
//    if (sender.tag == 4)
//    {
//        
//        //sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height
//        CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height);
//        NSArray * titles = @[@"新的好友",@"我的收藏",@"赞",@"微博支付",@"个性化",@"我的名片"];
//        NSArray * images =@[@"",@"",@"",@"",@"",@""];
//        PopoverView * pop = [[PopoverView alloc]initWithPoint:point titles:titles images:images];
//        pop.selectRowAtIndex = ^(NSInteger index){
//            NSLog(@"你选中了%@",titles[index]);
//        };
//        [pop show];
//        
//        
//    }
//    if (sender.tag == 2)
//    {
//        [photoTableView removeFromSuperview];
//        tableview.tableHeaderView = meView;
//        [self addSubview:tableview];
//        
//        
//    }
//    if (sender.tag == 1)
//    {
//        
//        
//    }
//    
//    if (sender.tag == 3)
//    {
//        [tableview removeFromSuperview];
//        photoTableView = [PhotoTableView new];
//        photoTableView.frame = CGRectMake(0, 0, 320, 568);
//        photoTableView.tableHeaderView = meView;
//        [self addSubview:photoTableView];
//    }
}




//返回section的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

//返回cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * content = _dataText[@"statuses"][indexPath.section][@"text"];
    CGFloat h = [Factory contentHeight:content];
    
    
    NSString * picStr = _dataText[@"statuses"][indexPath.section][@"bmiddle_pic"];
    
    NSArray * arr = [_dataText[@"statuses"][indexPath.section] allKeys];
    if ([arr containsObject:@"retweeted_status"])
    {
        NSString * reContent = _dataText[@"statuses"][indexPath.section][@"retweeted_status"][@"text"];
        CGFloat h1 = [Factory contentHeight:reContent];
        return 2 * h + h1 + 95;//有转发的返回这高度
    }
    
    
    if (picStr != nil)
    {
        return h + 165;//判断有图片的返回高度
    }
    
    return h + 80;//按照只有文本返回的高度
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[dataText[@"statuses"] count]
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray * arr =_dataText[@"statuses"];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString * indetity = @"_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indetity];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetity];
    }
    else
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    //发表人名字的label
    UILabel * nameLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 20)];
    nameLable.font = [UIFont systemFontOfSize:15];
    nameLable.text = _dataText[@"statuses"][indexPath.section][@"user"][@"name"];
    [cell.contentView addSubview:nameLable];
    
    NSString * time = [Factory getDateWithSourceDate:_dataText[@"statuses"][indexPath.section][@"created_at"]
                                         andSysDate : [NSString stringWithFormat:@"%@", [NSDate dateWithTimeIntervalSinceNow:8*3600]]];
    
    //时间的label
    UILabel * timeLbel = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, time.length*10, 10)];
    timeLbel.font = [UIFont systemFontOfSize:10];
    timeLbel.text = time;
    timeLbel.textColor = [UIColor grayColor];
    [cell.contentView addSubview:timeLbel];
    
    if ([time isEqualToString:@"刚刚"])
    {
        timeLbel.textColor = [UIColor orangeColor];
    }

    
    //来自什么客户端的label
    //把来自的文本接下来并分离出需要的
    NSString * fromStr = _dataText[@"statuses"][indexPath.section][@"source"];
    NSArray * a = [fromStr componentsSeparatedByString:@">"];
    NSArray * b = [a[1] componentsSeparatedByString:@"<"];
    fromStr = b[0];
    
    UILabel * fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(15+time.length*10, 30, (fromStr.length + 2)*18, 10)];
    fromLabel.font = [UIFont systemFontOfSize:10];
    fromLabel.textColor = [UIColor grayColor];
    fromLabel.text = [[NSString alloc]initWithFormat:@"来自%@",fromStr];
    [cell.contentView addSubview:fromLabel];
    
    
    
    //求高度设置
    NSString * content = _dataText[@"statuses"][indexPath.section][@"text"];
    CGFloat h = [Factory contentHeight:content];
    
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 40 , _width-20, h)];
    label.text = _dataText[@"statuses"][indexPath.section][@"text"];
    
    //自动换行设置
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    
    NSString * picStr = _dataText[@"statuses"][indexPath.section][@"bmiddle_pic"];
    if (picStr != nil)
    {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, h + 50, 70, 70)];
        
        //图片下载
        NSURLRequest * request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:_dataText[@"statuses"][indexPath.section][@"bmiddle_pic"]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
        [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData * data, NSError *connectionError)
        {
            imageView.image = [UIImage imageWithData:data];
        }];
        [cell.contentView addSubview:imageView];
    }
    
    //有转发的cell布局
    NSArray * arr = [_dataText[@"statuses"][indexPath.section] allKeys];
    if ([arr containsObject:@"retweeted_status"])
    {
        NSString * reContent = _dataText[@"statuses"][indexPath.section][@"retweeted_status"][@"text"];
        CGFloat h1 = [Factory contentHeight:reContent];
        
        
        UIView * view = [UIView new];
        view.frame = CGRectMake(10, h + 40, _width-20, h1 + h );
        view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        
        UILabel * reLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, view.frame.size.width - 10, view.frame.size.height)];
        reLabel.text = [[NSString alloc]initWithFormat:@"@%@:%@",_dataText[@"statuses"][indexPath.section][@"retweeted_status"][@"user"][@"name"],reContent ];
        
        reLabel.lineBreakMode = NSLineBreakByCharWrapping;
        reLabel.numberOfLines = 0;
        [view addSubview:reLabel];
        
#warning 转发下的图片
        //转发的图片
        //        NSArray * arrPic = dataText[@"statuses"][indexPath.row][@"retweeted_status"][@"pic_urls"];
        //        for (int i = 0; i < arrPic.count ; i++)
        //        {
        //            UIImageView * imgView = [UIImageView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, h1 + h + 20, <#CGFloat width#>, <#CGFloat height#>)
        //        }
        
        
        
        [cell.contentView addSubview:view];
    }
    
#pragma 功能button 转发评论赞
//        NSArray * arrtitle = @[@"转发",@"评论",@"赞"];
//        NSArray * arrpic = @[@"statusdetail_icon_retweet@2x.png",@"statusdetail_icon_comment@2x.png",@"statusdetail_comment_icon_like@2x.png",@"statusdetail_comment_icon_like_highlighted@2x.png"];
//    for (int i = 0; i < arrtitle.count; i++)
//    {
//        UIButton * btn1 = [[UIButton alloc]initWithFrame:CGRectMake(1+i*_width/3, 0, _width/3-1, 25)];
//        [btn1 setTitle:arrtitle[i] forState:UIControlStateNormal];
//        [btn1 setImage:[UIImage imageNamed:arrpic[i]] forState:UIControlStateNormal];
//        btn1.titleLabel.font = [UIFont systemFontOfSize:12];
//        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        btn1.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
//        [cell.contentView addSubview:btn1];
//    }
    
    [cell.contentView addSubview:label];
    return cell;
}




@end
