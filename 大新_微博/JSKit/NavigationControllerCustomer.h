#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NavigationControllerCustomer : NSObject

/*
 为标题栏添加返回按钮,并按要求隐藏系统默认返回按钮,
 用户可根据需要选择按钮样式和图片
 其中:
 vc ---当前需添加按钮的视图控制器
 YOrN ---是否隐藏系统按钮,默认为No
 tag ---按钮在navigationController上得tag值
 image ---按钮以图片形式显示，可为nil
 type ---按钮样式
 */
+ (void)createBackButtonForViewController:(UIViewController *)vc
        hideOldBackButtonOfNavigationItem:(BOOL)YOrN
                                  withTag:(int)tag
                                 andImage:(UIImage *)image
                                   andType:(UIButtonType)type;


/*
 为标题栏左侧添加按钮,该方法不覆盖已存在的按钮,
 用户可根据需要选择按钮样式和图片
 其中:
 vc ---当前需添加按钮的视图控制器
 tag ---按钮在navigationController上得tag值
 image ---按钮以图片形式显示，可为nil
 type ---按钮样式
 */
+ (void)createLeftBarButtonItemForViewController:(UIViewController *)vc
                                         withTag:(int)tag
                                        andImage:(UIImage *)image
                                         andType:(UIButtonType)type;


/*
 为标题栏右侧添加按钮,该方法不覆盖已存在的按钮,
 用户可根据需要选择按钮样式和图片
 其中:
 vc ---当前需添加按钮的视图控制器
 tag ---按钮在navigationController上得tag值
 image ---按钮以图片形式显示，可为nil
 type ---按钮样式
 */
+ (void)createRightBarButtonItemForViewController:(UIViewController *)vc
                                          withTag:(int)tag
                                         andImage:(UIImage *)image
                                          andType:(UIButtonType)type;


/*
 为标题栏添加标题,可选择标题显示颜色
 其中:
 title ---要显示的标题文字
 color ---标题颜色
 vc ---当前需添加标题的视图控制器
 */
+ (void)setTitle:(NSString *)title
       withColor:(UIColor*)color
forViewController:(UIViewController *)vc;

@end
