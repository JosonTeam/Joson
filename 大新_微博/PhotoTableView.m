
#import "PhotoTableView.h"
#import "Factory.h"
#import "JSKit.h"
@implementation PhotoTableView
{
    int _width;
    int _high;
    PhotoTableView * photoTableView;//相册tableview
    UITableView * tableview;//我的微博tableview
    UIView * meView;//表头
    
    NSArray * picUrlArr;
}

-(void)createMe:(UIViewController *)sender
{
    
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568) style:UITableViewStyleGrouped];
    tableview.showsHorizontalScrollIndicator = NO;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.bounces = YES;
    
    
    
    meView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 250)];
    meView.backgroundColor = [UIColor whiteColor];
    meView.userInteractionEnabled = YES;
    
    
    NSArray * arr = [[NSArray alloc]initWithObjects:@"主页",@"微博",@"相册",@"更多", nil];
    
    for (int i = 0; i < arr.count; i++)
    {
        UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(i * 50 + 55, 230, 50, 30)];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = i + 1;
        [btn addTarget:sender action:@selector(clickSection:) forControlEvents:UIControlEventTouchUpInside];
        [meView addSubview:btn];
    }
    
    
    tableview.delegate = self;
    tableview.dataSource = self;
    
    UIImageView * headImageView = [[UIImageView alloc]init];
    headImageView.frame = CGRectMake(0, 0, 320, 170);
    headImageView.image = [UIImage imageNamed:@"login_introduce_bg4.jpg"];
    headImageView.userInteractionEnabled = YES;
    [meView addSubview:headImageView];
    
    UIButton * shareBtn = [UIButton new];
    shareBtn.frame = CGRectMake(280, 5, 30, 30);
    [shareBtn setImage:[UIImage imageNamed:@"userinfo_navigationbar_more@2x"] forState:UIControlStateNormal];
    shareBtn.backgroundColor = [UIColor blackColor];
    shareBtn.alpha = 0.7;
    shareBtn.tag = 99;
    [shareBtn addTarget:self action:@selector(clickShare:) forControlEvents:UIControlEventTouchUpInside];
    [headImageView addSubview:shareBtn];
    
    UIButton * search = [[UIButton alloc]initWithFrame:CGRectMake(240, 5, 35, 30)];
    [search setImage:[UIImage imageNamed:@"userinfo_navigationbar_search@2x"] forState:UIControlStateNormal];
    search.backgroundColor = [UIColor blackColor];
    search.alpha = 0.7;
    [headImageView addSubview:search];
    
    UIView * view = [UIView new];
    view.frame = CGRectMake(115, 25, 80, 80);
    view.backgroundColor = [UIColor whiteColor];
    view.alpha = 0.6;
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 40;
    [headImageView addSubview:view];
    
#pragma 用户头像
    UIImageView * TXimage = [[UIImageView alloc]initWithFrame:CGRectMake(120, 30, 70, 70)];
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
    
    
    NSString *uid = iddata[@"uid"];
    NSInteger t = [uid integerValue];
    
    NSLog(@"_acc_token = %@",_acc_token);
    NSLog(@"%d",t);
    
    NSDictionary * picDic = _dataText;
    NSLog(@"picDic = %@",picDic);
    
    picUrlArr = picDic[@"statuses"];
    
    
    
    
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
    int x = 0;
    int y = 0;
    int count = ceilf(picUrlArr.count / 3);NSLog(@"%@",picUrlArr);
//    count = count + 1;
    static int imgcount = 0;
    NSLog(@"count = %d",count);
    for (int i = 0; i < count; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(x + j * 109, y , 104, 104)];
            
//            imgView.image = picUrlArr[imgcount++];
            [cell.contentView addSubview:imgView];
            
            //GCD图片下载
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:picUrlArr[imgcount++][@"bmiddle_pic"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    imgView.image = [UIImage imageWithData:data];
                    
                    
                });
            });

            
            
            
//            //图片下载
//            NSURLRequest * request1 = [NSURLRequest requestWithURL:[NSURL URLWithString:picUrlArr[imgcount++][@"bmiddle_pic"]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
//            [NSURLConnection sendAsynchronousRequest:request1 queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData * data, NSError *connectionError)
//             {
//                 imgView.image = [UIImage imageWithData:data];
//             }];
            
            
            
            
        }
        x = 0;
        y += 109;
    }
    
    
    
    
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int count = ceilf(picUrlArr.count / 3);
    return count * 109;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
