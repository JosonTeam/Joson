#import <UIKit/UIKit.h>

@interface TabbarViewController : UITabBarController < UITableViewDataSource , UITableViewDelegate >

@property(nonatomic, strong)NSArray * cellName;
@property(nonatomic, strong)UITableView * table_View;
@property(nonatomic, strong)UIView * hide_View;
@property(nonatomic, strong)NSString * access_token;

- (void)init_View;

@end
