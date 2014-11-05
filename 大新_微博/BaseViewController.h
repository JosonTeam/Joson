#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController < UITableViewDataSource , UITableViewDelegate >

@property (nonatomic ,assign)int identifier;
@property (nonatomic ,assign)int count;
@property (nonatomic ,assign)int se_index;
@property (nonatomic ,strong)NSString * access_token;
@property (nonatomic ,strong)NSMutableArray * source;
@property (nonatomic ,strong)NSMutableArray * name;;
@property (nonatomic ,strong)NSString * userLoginName;

- (void)init_View;

- (void)getAppearSource;

@end
