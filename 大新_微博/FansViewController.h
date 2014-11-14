//
//  FansViewController.h
//  大新_微博
//
//  Created by YF01-D05 on 14-11-10.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FansViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate>
@property(nonatomic,strong)NSString * acctoken;
@property(nonatomic,strong)NSString * username;

@end
