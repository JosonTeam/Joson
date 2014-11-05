#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController < UITextViewDelegate >

@property (nonatomic, strong)NSString * type;
@property (nonatomic, strong)NSString * name;
@property (nonatomic, strong)NSDictionary * source;
@property (nonatomic, strong)NSString * access_token;

@end
