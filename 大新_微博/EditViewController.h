#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController < UITextViewDelegate , UINavigationControllerDelegate , UIImagePickerControllerDelegate >

@property (nonatomic, strong)NSString * type; //判断是转发，发送，分享还是评论
@property (nonatomic, strong)NSString * name; //用户名
@property (nonatomic, strong)NSDictionary * source; //数据源
@property (nonatomic, strong)UIButton * limitButton; //分享范围按钮
@property (nonatomic, strong)NSString * access_token; //用户授权码
@property (nonatomic, strong)NSMutableArray * picName; //表情

@end
