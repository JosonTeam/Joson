//
//  MyView.h
//  大新_微博
//
//  Created by YF01-D05 on 14-11-6.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyView : UIView<UITableViewDataSource,UITableViewDelegate>
-(void)createMe:(UIViewController *)sender;
@property(nonatomic,strong)NSMutableDictionary * dataText;
@property(nonatomic,strong)NSString * username;//用户名
@property(nonatomic,strong)NSArray * uids;//用户uid
@property(nonatomic,strong)NSString * acc_token;//_access_token值
@property(nonatomic,strong)UITableView * tableview;//我的微博tableview
@end
