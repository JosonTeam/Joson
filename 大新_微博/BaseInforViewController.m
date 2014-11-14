//
//  BaseInforViewController.m
//  大新_微博
//
//  Created by YF01-D05 on 14-11-14.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import "BaseInforViewController.h"

@interface BaseInforViewController ()
{
    NSDictionary * baseData;
}
@end

@implementation BaseInforViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    UIButton * backBtn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    NSDictionary * iD = [MicroBlogOperateForSina getIdWithAccessToken:_acc_token];
    
    baseData = [MicroBlogOperateForSina getDetailOfUserWithAccessToken:_acc_token name:_username orId:iD[@"uid"]];
    NSLog(@"baseData = %@",baseData);
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
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
    
    NSArray * str = [[NSArray alloc]initWithObjects:@"昵称",@"性别",@"所在地",@"简介", nil];
    cell.textLabel.text = str[indexPath.row];
    cell.textLabel.alpha = 0.8;
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(75, 5, 240, 30)];
    switch (indexPath.row)
    {
        case 0:
            label.text = baseData[@"name"];
            break;
        case 1:
            if ([baseData[@"gender"] isEqualToString:@"m"])
            {
                label.text = @"男";
            }
            else
            {
                label.text = @"女";
            }
            break;
        case 2:
            label.text = baseData[@"location"];
            break;
        case 3:
            label.text = baseData[@"description"];
            break;
            
            
        default:
            break;
    }
    
    
    
    [cell addSubview:label];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//返回键,返回上一个页面
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
