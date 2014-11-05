#import <UIKit/UIKit.h>

@interface EmotionKeyBoard : UIView < UIScrollViewDelegate >
{
    int _width;
}

@property(nonatomic, assign)int arr_Count;
@property(nonatomic, strong)NSString * path;
@property(nonatomic, strong)UIPageControl * pageC;
@property(nonatomic, strong)UIScrollView * scroll;

- (id)initWithBundleName:(NSString *)name
          viewController:(UIViewController *)vc;

- (UIView *)getSource:(NSString *)name
       ViewController:(UIViewController *)vc;

@end
