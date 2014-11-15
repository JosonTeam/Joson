#import <UIKit/UIKit.h>

@protocol ExpendableAlartViewDelegate <NSObject>

- (void)positiveButtonAction;

- (void)negativeButtonAction;

- (void)closeButtonAction;

@end

@interface AlartViewController : UIViewController

@property (nonatomic,strong) UIView *titleView;
@property (nonatomic,weak) id<ExpendableAlartViewDelegate> expendAbleAlartViewDelegate;

- (void)showView:(UIViewController *)VC;

CA_EXTERN CATransform3D CATransform3DMakePerspective(CGPoint center, float disZ);


CA_EXTERN CATransform3D CATransform3DPerspect(CATransform3D t, CGPoint center, float disZ);

@end
