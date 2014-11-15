#import "NavigationControllerCustomer.h"

@implementation NavigationControllerCustomer


#pragma mark 为标题栏添加返回按钮,并按要求隐藏系统默认返回按钮,用户可根据需要选择按钮样式和图片
/*
 其中:
 vc ---当前需添加按钮的视图控制器
 YOrN ---是否隐藏系统按钮,默认为No
 tag ---按钮在navigationController上得tag值
 image ---按钮以图片形式显示，可为nil
 title ---按钮标题
 type ---按钮样式
 */
+ (void)createBackButtonForViewController:(UIViewController *)vc
        hideOldBackButtonOfNavigationItem:(BOOL)YOrN
                                  withTag:(int)tag
                                 andImage:(UIImage *)image
                                 orTitile:(NSString *)title
                                  andType:(UIButtonType)type
{
    if (YOrN == YES)
    {
        vc.navigationItem.hidesBackButton = YES;
    }
    
    UIButton * button = [UIButton buttonWithType:type];
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 25, 25);
    button.tag = tag;
    
    if (title)
    {
        
        [button setTitleColor : [UIColor orangeColor]
                     forState : UIControlStateNormal];
        
        [button setTitle:title
               forState : UIControlStateSelected];
        
        button.frame = CGRectMake(0, 0, 20*title.length, 25);
        button.selected = YES;
    }
    
    if (image)
    {
        
        [button setImage:image
               forState : UIControlStateNormal];
        
        button.selected = YES;
    }
    
    if (vc.navigationItem.leftBarButtonItem)
    {
        vc.navigationItem.leftBarButtonItems = @[barbutton , vc.navigationItem.leftBarButtonItems];
    }
    else
    {
        vc.navigationItem.leftBarButtonItem = barbutton;
    }
}


#pragma mark 为标题栏左侧添加按钮,该方法不覆盖已存在的按钮,用户可根据需要选择按钮样式和图片
/*
 其中:
 vc ---当前需添加按钮的视图控制器
 tag ---按钮在navigationController上得tag值
 title ---标题，可为空
 image ---按钮以图片形式显示，可为nil
 type ---按钮样式
 */
+ (void)createLeftBarButtonItemForViewController:(UIViewController *)vc
                                         withTag:(int)tag
                                        andTitle:(NSString *)title
                                        andImage:(UIImage *)image
                                         andType:(UIButtonType)type
{
    
    UIButton * button = [UIButton buttonWithType:type];
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 25, 25);
    button.tag = tag;
    
    if (title)
    {
        
        [button setTitleColor : [UIColor orangeColor]
                     forState : UIControlStateNormal];
        
        [button setTitle:title
               forState : UIControlStateSelected];
        
        button.selected = YES;
    }
    
    if (image)
    {
        
        [button setImage:image
               forState : UIControlStateNormal];
        
        button.selected = YES;
    }
    
    if (vc.navigationItem.leftBarButtonItem)
    {
        vc.navigationItem.leftBarButtonItems = @[vc.navigationItem.leftBarButtonItem , barbutton];
    }
    
    else
    {
        vc.navigationItem.leftBarButtonItem = barbutton;
    }
    
}


#pragma mark 为标题栏右侧添加按钮,该方法不覆盖已存在的按钮, 用户可根据需要选择按钮样式和图片
/*
 其中:
 vc ---当前需添加按钮的视图控制器
 tag ---按钮在navigationController上得tag值
 title ---标题，可为空
 image ---按钮以图片形式显示，可为nil
 type ---按钮样式
 */
+ (void)createRightBarButtonItemForViewController:(UIViewController *)vc
                                          withTag:(int)tag
                                         andTitle:(NSString *)title
                                         andImage:(UIImage *)image
                                          andType:(UIButtonType)type
{
    
    UIButton * button = [UIButton buttonWithType:type];
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 25, 25);
    button.tag = tag;
    
    if (title)
    {
        
        [button setTitleColor : [UIColor orangeColor]
                     forState : UIControlStateNormal];
        
        [button setTitle:title
               forState : UIControlStateSelected];
        
        button.frame = CGRectMake(0, 0, 20*title.length, 25);
        button.selected = YES;
    }
    
    if (image)
    {
        
        [button setImage:image
               forState : UIControlStateNormal];
        
        button.selected = YES;
    }
    
    if (vc.navigationItem.rightBarButtonItem)
    {
        vc.navigationItem.rightBarButtonItems = @[vc.navigationItem.rightBarButtonItem , barbutton];
    }
    
    else
    {
        vc.navigationItem.rightBarButtonItem = barbutton;
    }
    
}


#pragma mark 为标题栏添加标题,可选择标题显示颜色
/*
 其中:
 title ---要显示的标题文字
 color ---标题颜色
 vc ---当前需添加标题的视图控制器
 */
+ (void)setTitle:(NSString *)title
       withColor:(UIColor *)color
forViewController:(UIViewController *)vc
{
    
    UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(0, 0, 18 * title.length, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = color;
    vc.navigationItem.titleView = label;
    
}


#pragma mark 为标题栏添加标题,可选择标题显示颜色
/*
 其中:
 title ---要显示的标题文字
 subTitle ---要显示的小标题文字
 color ---标题颜色
 vc ---当前需添加标题的视图控制器
 */
+ (void)setTitle:(NSString *)title
     andSubtitle:(NSString *)subTitle
       withColor:(UIColor*)color
forViewController:(UIViewController *)vc
{
    
    NSInteger i = 18*title.length;
    
    if (subTitle.length*18 > i)
    {
        i = subTitle.length*18;
    }
    
    UIView * view = [[UIView alloc] initWithFrame : CGRectMake(0, 0, i, 45)];
    
    UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(0, 0, i, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = color;
    [view addSubview:label];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame : CGRectMake(0, 20, i, 25)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.text = subTitle;
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = color;
    [view addSubview:label1];
    
    vc.navigationItem.titleView = view;
    
}


#pragma mark 为标题栏添加搜索控件
/*
 其中:
 vc ---当前需添加标题的视图控制器
 tag ---控件在navigationController上得tag值
 answer ---需要或不需要录音按钮
 若answer为0，以下设置不生效
 title ---按钮的标题
 image ---按钮的图片
 type ---按钮的样式
 buttpn_Tag ---按钮的tag值
 */
+ (void)createSearchBarWithViewController:(UIViewController *)vc
                                  withTag:(int)tag
                       needRecorderButton:(BOOL)answer
                                 andTitle:(NSString *)title
                                 andImage:(UIImage *)image
                                  andType:(UIButtonType)type
                            withButtonTag:(int)button_Tag
{
    
    UIView * view = [[UIView alloc] initWithFrame : CGRectMake(0, 20, CGRectGetWidth(vc.view.frame), 44)];
    vc.navigationItem.titleView = view;

    UISearchBar * search = [[UISearchBar alloc] initWithFrame : CGRectMake(0, 10, CGRectGetWidth(view.frame)-15, 30)];
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.tag = tag;
    [view addSubview:search];
    
    if (answer)
    {
        
        search.frame = CGRectMake(0, 10, CGRectGetWidth(view.frame)-40, 30);
        
        UIButton * button = [UIButton buttonWithType:type];
        button.frame = CGRectMake(CGRectGetWidth(view.frame)-40, 12, 25, 25);
        button.tag = button_Tag;
        button.selected = YES;
        [view addSubview:button];
        
        if (title)
        {
            
            [button setTitle:title
                   forState : UIControlStateSelected];
            
        }
        
        if (image)
        {
            
            [button setImage:image
                   forState : UIControlStateSelected];
            
        }
        
    }
    
}


#pragma mark 添加navigationController
/*
 其中:
 vc ---当前需添加标题栏的视图控制器
 */
+ (UINavigationController *)createNavigationControllerWithViewController:(UIViewController *)vc
{
    
    UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:vc];
    navigation.navigationBar.barStyle = UIBarStyleDefault;
    navigation.navigationBar.backgroundColor = [UIColor colorWithPatternImage : [UIImage imageNamed:@"navigationbar_background_landscape@2x.png"]];
   
    return navigation;
}


@end
