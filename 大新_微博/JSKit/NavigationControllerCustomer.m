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
                                        andImage:(UIImage *)image
                                         andType:(UIButtonType)type
{
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
        vc.navigationItem.leftBarButtonItems = @[vc.navigationItem.leftBarButtonItem,barbutton];
    }
    else
    {
        vc.navigationItem.leftBarButtonItem = barbutton;
    }
}

+ (void)createRightBarButtonItemForViewController:(UIViewController *)vc
                                          withTag:(int)tag
                                         andImage:(UIImage *)image
                                          andType:(UIButtonType)type
{
    UIButton * button = [UIButton buttonWithType:type];
    UIBarButtonItem * barbutton = [[UIBarButtonItem alloc]initWithCustomView:button];
    button.frame = CGRectMake(0, 0, 25, 25);
    button.tag = tag;
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
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 20 * title.length, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = color;
    vc.navigationItem.titleView = label;
}


@end
