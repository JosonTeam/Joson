#import <UIKit/UIKit.h>

@class EditViewController;

@interface LimitViewController : UIViewController < UITableViewDataSource , UITableViewDelegate >

@property (nonatomic,strong)EditViewController * edit; //编辑界面

@end
