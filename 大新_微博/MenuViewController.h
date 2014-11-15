#import <UIKit/UIKit.h>

@class TabbarViewController;

@interface MenuViewController : UIViewController

@property (nonatomic, assign)int identifier; //跳转到改界面前，tabBarController选择的items
@property (nonatomic, strong)NSString * userLoginName; //用户名
@property (nonatomic, strong)TabbarViewController * tabbar; //tabBarController

@end
