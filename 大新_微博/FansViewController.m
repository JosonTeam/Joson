//
//  FansViewController.m
//  大新_微博
//
//  Created by YF01-D05 on 14-11-10.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import "FansViewController.h"

@interface FansViewController ()
{
    NSDictionary * fanData;
    NSMutableArray * arr;
}
@end

@implementation FansViewController

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
    fanData = [MicroBlogOperateForSina getFollowerWithAccessToken:_acctoken name:_username];
    
    arr = [NSMutableArray new];
    
    for (int i = 0;i < [fanData[@"users"] count] ; i++)
    {
        [arr addObject:[UIImage imageNamed:@"sign-up_avatar_default@2x"]];
    }
    
    UITableView * tableview = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate = self;
    [self.view addSubview:tableview];

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indetity = @"_cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indetity];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:indetity];
    }
    else
    {
        for (UIView * view in cell.contentView.subviews)
        {
            [view removeFromSuperview];
        }
    }
    
    cell.textLabel.text = fanData[@"users"][indexPath.row][@"name"];
    cell.detailTextLabel.text = [[NSString alloc]initWithFormat:@"粉丝 : %@",fanData[@"users"][indexPath.row][@"followers_count"] ,nil];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:10];
    cell.imageView.image = arr[indexPath.row];
    
    
    UIButton * attBtn = [[UIButton alloc]initWithFrame:CGRectMake(270, 5, 40, 40)];
    //选中后图片变色的的地址 : navigationbar_friendsearch@2x
    [attBtn setImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted@2x"] forState:UIControlStateNormal];
    [cell addSubview:attBtn];
  
    //GCD图片下载
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:fanData[@"users"][indexPath.row][@"avatar_hd"]]];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:data];
            [arr replaceObjectAtIndex:indexPath.row withObject:[UIImage imageWithData:data]];

        });
    });

    
    return cell;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = fanData[@"users"];
    return arr.count;
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
        titleLabel.text  = @"粉丝";
        [view addSubview:titleLabel];
        
        UIButton * moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(285, 10, 30, 30)];
        [moreBtn setImage:[UIImage imageNamed:@"userinfo_tabicon_more@2x"] forState:UIControlStateNormal];
        [moreBtn addTarget:self action:@selector(clickdian) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:moreBtn];
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
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
