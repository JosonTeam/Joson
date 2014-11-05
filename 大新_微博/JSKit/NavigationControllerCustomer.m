#import "NavigationControllerCustomer.h"

@implementation NavigationControllerCustomer

+ (void)createBackButtonForViewController:(UIViewController *)vc
        hideOldBackButtonOfNavigationItem:(BOOL)YOrN
                                  withTag:(int)tag
                                 andImage:(UIImage *)image
                                  andType:(UIButtonType)type
{
    if (YOrN == YES)
    {
        vc.navigationItem.hidesBackButton = YES;
    }
    
    UIButton * button = [UIButton buttonWithType:type];
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc]initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 25, 25);
    button.tag = tag;
    if (image)
    {
        [button setImage:image forState:UIControlStateSelected];
        button.selected = YES;
    }
    if (vc.navigationItem.leftBarButtonItem)
    {
        vc.navigationItem.leftBarButtonItems = @[barbutton,vc.navigationItem.leftBarButtonItems];
    }
    else
    {
        vc.navigationItem.leftBarButtonItem = barbutton;
    }
}

+ (void)createLeftBarButtonItemForViewController:(UIViewController *)vc
                                         withTag:(int)tag
                                        andTitle:(NSString *)title
                                        andImage:(UIImage *)image
                                         andType:(UIButtonType)type
{
    UIButton * button = [UIButton buttonWithType:type];
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc]initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 25, 25);
    button.tag = tag;
    if (title)
    {
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateSelected];
        button.selected = YES;
    }
    if (image)
    {
        [button setImage:image forState:UIControlStateSelected];
        button.selected = YES;
    }
    if (vc.navigationItem.leftBarButtonItem)
    {
        vc.navigationItem.leftBarButtonItems = @[vc.navigationItem.leftBarButtonItem,barbutton];
    }
    else
    {
        vc.navigationItem.leftBarButtonItem = barbutton;
    }
}

+ (void)createRightBarButtonItemForViewController:(UIViewController *)vc
                                          withTag:(int)tag
                                         andTitle:(NSString *)title
                                         andImage:(UIImage *)image
                                          andType:(UIButtonType)type
{
    UIButton * button = [UIButton buttonWithType:type];
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc]initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 25, 25);
    button.tag = tag;
    if (title)
    {
        [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateSelected];
        button.frame = CGRectMake(0, 0, 20*title.length, 25);
        button.selected = YES;
    }
    if (image)
    {
        [button setImage:image forState:UIControlStateSelected];
        button.selected = YES;
    }
    if (vc.navigationItem.rightBarButtonItem)
    {
        vc.navigationItem.rightBarButtonItems = @[vc.navigationItem.rightBarButtonItem,barbutton];
    }
    else
    {
        vc.navigationItem.rightBarButtonItem = barbutton;
    }
}

+ (void)setTitle:(NSString *)title
       withColor:(UIColor *)color
forViewController:(UIViewController *)vc
{
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 18 * title.length, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = color;
    vc.navigationItem.titleView = label;
}


+ (void)createSearchBarWithViewController:(UIViewController *)vc
                                  withTag:(int)tag
                       needRecorderButton:(BOOL)answer
                                 andTitle:(NSString *)title
                                 andImage:(UIImage *)image
                                  andType:(UIButtonType)type
                            withButtonTag:(int)button_Tag
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(vc.view.frame), 44)];
    vc.navigationItem.titleView = view;

    UISearchBar * search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 10, CGRectGetWidth(view.frame)-15, 30)];
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
            [button setTitle:title forState:UIControlStateSelected];
        }
        if (image)
        {
            [button setImage:image forState:UIControlStateSelected];
        }
    }
}


+ (UINavigationController *)createNavigationControllerWithViewController:(UIViewController *)vc
{
    UINavigationController * navigation = [[UINavigationController alloc]initWithRootViewController:vc];
    navigation.navigationBar.barStyle = UIBarStyleDefault;
    navigation.navigationBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background_landscape@2x.png"]];
    return navigation;
}


@end
