//
//  MoreViewController.m
//  大新_微博
//
//  Created by YF01-D05 on 14-11-10.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import "MoreViewController.h"
#import "FansViewController.h"
@interface MoreViewController ()
{
    
}
@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UITableView * tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate  = self;
    [self.view addSubview:tableView];

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indetity = @"_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indetity];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetity];
    }
    if (indexPath.section == 1)
    {
        cell.imageView.image = [UIImage imageNamed:@"message_choosegroup@2x"];
        cell.textLabel.text = @"查看所有的粉丝";
      
    }
    if (indexPath.section == 2)
    {
        NSArray * interUid = [MicroBlogOperateForSina getSuggestedUserByMayInterestedWithAccessToken:_acctoken];
        NSMutableArray * arr = [NSMutableArray new];
        for (int i = 0; i < 3; i++)
        {
            NSDictionary * interData = [MicroBlogOperateForSina getDetailOfUserWithAccessToken:_acctoken name:nil orId:interUid[0][@"reason"][@"h"][@"uid"][i]];
            
            [arr addObject:interData];
        }
        cell.imageView.image = [UIImage imageNamed:@"sign-up_avatar_default@2x"];
        cell.textLabel.text = arr[indexPath.row][@"name"];
        
        UIButton * attBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, 5, 40, 40)];
        //选中后图片变色的的地址 : navigationbar_friendsearch@2x
        [attBtn setImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted@2x"] forState:UIControlStateNormal];
        [cell addSubview:attBtn];

        
        //GCD图片下载
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:arr[indexPath.row][@"avatar_hd"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = [UIImage imageWithData:data];
                
            });
        });

    }
    
    if (indexPath.section == 3)
    {
        NSDictionary * uidDic = [MicroBlogOperateForSina getIdWithAccessToken:_acctoken];
        
        NSDictionary * togetherData = [MicroBlogOperateForSina getsFollowTogetherWithAccessToken:_acctoken andUid:uidDic[@"uid"]];
        NSLog(@"togetherData = %@",togetherData);
        
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        FansViewController * fvc = [FansViewController new];
        fvc.acctoken = _acctoken;
        fvc.username = _username;
        [self presentViewController:fvc animated:YES completion:nil];
    }
}








-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    if (section == 1)
    {
        return 1;
    }
    return 3;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//    int num;
//    switch (_flag)
//    {
//        case 0:
//            num = 3;
//            break;
//            
//        default:
//            break;
//    }
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 50;
    }
    return 15;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [UIView new];
    
    if (section == 0)
    {
        UIButton * backBtn = [[UIButton alloc]initWithFrame:CGRectMake(5, 10, 30, 30)];
        [backBtn setImage:[UIImage imageNamed:@"userinfo_tabicon_back@2x"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:backBtn];
        
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 10, 100, 30)];
        titleLabel.text  = _titleText;
        [view addSubview:titleLabel];
        
        UIButton * moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(285, 10, 30, 30)];
        [moreBtn setImage:[UIImage imageNamed:@"userinfo_tabicon_more@2x"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(clickdian) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moreBtn];
    }
    if (section == 1)
    {
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, -10, 100, 20)];
        label1.text = @"新粉丝";
        label1.font = [UIFont systemFontOfSize:10];
        [view addSubview:label1];
    }
    if (section == 2)
    {
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, -10, 100, 20)];
        label1.text = @"可能感兴趣的人";
        label1.font = [UIFont systemFontOfSize:10];
        [view addSubview:label1];
    }
    if (section == 3)
    {
        UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, -10, 100, 20)];
        label1.text = @"粉丝中可能认识的人";
        label1.font = [UIFont systemFontOfSize:10];
        [view addSubview:label1];
    }
    
    return view;
}






-(void)clickdian
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"刷新",@"返回首页", nil];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    NSLog(@"**********");
    [actionSheet showInView:self.view];
}


//返回键,返回上一个页面
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
