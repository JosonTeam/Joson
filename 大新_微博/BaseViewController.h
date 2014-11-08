#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController < UITableViewDataSource , UITableViewDelegate >

@property (nonatomic ,assign)int count; //cell的个数
@property (nonatomic ,assign)int identifier; //界面身份标识
@property (nonatomic ,strong)NSMutableArray * name; //所转发原微博博主用户名
@property (nonatomic ,strong)NSString * access_token; //用户授权码
@property (nonatomic ,strong)NSMutableArray * source; //数据源
@property (nonatomic ,strong)NSString * userLoginName; //用户名

//初始化界面
- (void)init_View;

//获取显示资源
- (void)getAppearSource;

@end
