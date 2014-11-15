#import <UIKit/UIKit.h>

@interface FindFriendAndWeiboDetaileViewController : UIViewController < UITableViewDataSource , UITableViewDelegate >

@property(nonatomic,strong)NSMutableDictionary * bubbleIndexTypes; //分享平台类别
@property(nonatomic,strong)NSString * access_token; //用户授权码
@property(nonatomic,strong)NSString * name; //用户名
@property(nonatomic,strong)NSString * type;
@property(nonatomic,strong)NSDictionary * weiboSource;

- (void)init_View;

@end
