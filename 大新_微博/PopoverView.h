#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface PopoverView : UIView

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, strong)AVAudioPlayer * player;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);

-(id)initWithPoint:(CGPoint)point
            titles:(NSArray *)titles
            images:(NSArray *)images;

-(void)show;

-(void)dismiss;

-(void)dismiss:(BOOL)animated;

@end
