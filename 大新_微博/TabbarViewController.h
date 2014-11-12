#import <UIKit/UIKit.h>

@interface TabbarViewController : UITabBarController < UITableViewDataSource , UITableViewDelegate >

@property(nonatomic, strong)UITableView * table_View; //tableView
@property(nonatomic, strong)NSString * access_token; //用户授权码
@property(nonatomic, strong)UIView * hide_View; //透明层
@property(nonatomic, strong)UIImage * imageURL; //大图图片
@property(nonatomic, strong)NSArray * cellName; //cell的textView上的显示内容

@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);


//初始化界面
- (void)init_View;

- (void)viewDisappear;

@end
