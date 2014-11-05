#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController < UITableViewDataSource , UITableViewDelegate >

@property (nonatomic ,assign)int identifier;
@property (nonatomic ,assign)int count;
@property (nonatomic ,strong)NSString * access_token;
@property (nonatomic ,strong)NSMutableArray * source;

- (void)init_View;

- (void)getAppearSource;

@end
