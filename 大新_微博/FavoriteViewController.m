//
//  FavoriteViewController.m
//  大新_微博
//
//  Created by YF01-D05 on 14-11-11.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import "FavoriteViewController.h"

@interface FavoriteViewController ()
{
    NSMutableArray * favoData;
}
@end

@implementation FavoriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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
    
    NSDictionary * favoIdData = [MicroBlogOperateForSina getIdOfFavoriteOfUserWithAccessToken:_acctoken];
    for (int i = 0; i < [favoIdData[@"favorites"] count]; i++)
    {
        NSDictionary * datas = [MicroBlogOperateForSina getDetaileOfFavoriteWithAccessToken:_acctoken andId:[favoIdData[@"favorites"][i][@"status"] integerValue]];
        NSLog(@"datas = %@",datas);
        [favoData addObject:datas];
        
    }
    NSLog(@"favoData = %@",favoData);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 20;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    
    
    
    return cell;
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

    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 50;
    }
    return 1;
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
