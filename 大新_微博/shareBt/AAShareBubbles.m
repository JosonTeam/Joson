#import "FindFriendAndWeiboDetaileViewController.h"
#import "BaseViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "AAShareBubbles.h"


@interface AAShareBubbles()

@end

@implementation AAShareBubbles
{
    
    NSMutableArray *bubbles;
    UIView *faderView;
    NSMutableDictionary *bubbleIndexTypes;

}

@synthesize delegate = _delegate, parentView;

- (id)initCenteredInWindowWithRadius:(int)radiusValue
{
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return [self initWithPoint:CGPointMake((CGFloat) (window.frame.size.width * 0.5), (CGFloat) (window.frame.size.height * 0.5))
                        radius:radiusValue
                        inView:window];
}

- (id)initWithPoint:(CGPoint)point
             radius:(int)radiusValue
             inView:(UIView *)inView
{
    [ShareSDK registerApp:@"35f0abde3001"];
    
    self = [super initWithFrame:CGRectMake(point.x - radiusValue, point.y - radiusValue, 2 * radiusValue, 2 * radiusValue)];
    if (self)
    {
        
        self.radius = radiusValue;
        self.bubbleRadius = 40;
        self.parentView = inView;
        
        self.faderAlpha = 0.15;
        self.googlePlusBackgroundColorRGB = 0xd95433;
        self.pinterestBackgroundColorRGB = 0xb61d23;
        self.instagramBackgroundColorRGB = 0x2e5e89;
        self.linkedInBackgroundColorRGB = 0x008dd2;
        self.favoriteBackgroundColorRGB = 0xedd013;
        self.whatsappBackgroundColorRGB = 0x00B000;
        self.facebookBackgroundColorRGB = 0x3c5a9a;
        self.twitterBackgroundColorRGB = 0x3083be;
        self.youtubeBackgroundColorRGB = 0xce3025;
        self.redditBackgroundColorRGB = 0xffffff;
        self.tumblrBackgroundColorRGB = 0x385877;
        self.vimeoBackgroundColorRGB = 0x00acf2;
        self.mailBackgroundColorRGB = 0xbb54b5;
        self.vkBackgroundColorRGB = 0x4a74a5;
        
    }
    
    return self;
}

#pragma mark -
#pragma mark Actions

-(void)shareButtonTappedWithType:(AAShareBubbleType)buttonType
{
    [self hide:nil];
    
    if([self.delegate respondsToSelector:@selector(aaShareBubbles:tappedBubbleWithType:)])
    {
        
        [self.delegate aaShareBubbles:self
                 tappedBubbleWithType:buttonType];
        
    }
}


#pragma mark -
#pragma mark Helper functions

-(void)shareViewBackgroundTapped:(UITapGestureRecognizer *)tapGesture
{
    [self hide:nil];
}

#pragma mark -
#pragma mark Methods

-(void)show:(UIViewController *)vc
{
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        
        [self.parentView addSubview:self];
        
        // Create background
        faderView = [[UIView alloc] initWithFrame:self.parentView.bounds];
        faderView.backgroundColor = [UIColor blackColor];
        faderView.alpha = 0.0f;
        UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(shareViewBackgroundTapped:)];
      
        [faderView addGestureRecognizer:tapges];
        [parentView insertSubview:faderView belowSubview:self];

        [UIView animateWithDuration:0.25
                        animations : ^{
                            
            faderView.alpha = self.faderAlpha;
                            
        }];
        // --
        
        if(bubbles)
        {
            bubbles = nil;
        }
        
        bubbles = [[NSMutableArray alloc] init];
        bubbleIndexTypes = [[NSMutableDictionary alloc] init];
        
        if(self.showSinaMicroblogBubble)
            
            [self createButtonWithIcon:@"bgb.png"
                       backgroundColor:self.facebookBackgroundColorRGB
                               andType:AAShareBubbleTypeFacebook
                     andViewController:vc];
        
        if(self.showTencentMicroblogBubble)
            
            [self createButtonWithIcon:@"bgb2.png"
                       backgroundColor:self.twitterBackgroundColorRGB
                               andType:AAShareBubbleTypeTwitter
                     andViewController:vc];
        
        if(self.showYixinBubble)
            
            [self createButtonWithIcon:@"sns_icon_38@2x_b.png"
                       backgroundColor:self.googlePlusBackgroundColorRGB
                               andType:AAShareBubbleTypeGooglePlus
                     andViewController:vc];
        
        if(self.showMingdaoBubble)
            
            [self createButtonWithIcon:@"sns_icon_41@2x_b.png"
                       backgroundColor:self.tumblrBackgroundColorRGB
                               andType:AAShareBubbleTypeTumblr
                     andViewController:vc];
        
        if(self.showMailBubble)
            
            [self createButtonWithIcon:@"bgb3.png"
                       backgroundColor:self.mailBackgroundColorRGB
                               andType:AAShareBubbleTypeMail
                     andViewController:vc];
        
        if(self.showWangyiBubble)
            
            [self createButtonWithIcon:@"bgb4.png"
                       backgroundColor:self.vkBackgroundColorRGB
                               andType:AAShareBubbleTypeVk
                     andViewController:vc];
        
        if(self.showDouBanBubble)
            
            [self createButtonWithIcon:@"bgb5.png"
                       backgroundColor:self.linkedInBackgroundColorRGB
                               andType:AAShareBubbleTypeLinkedIn
                     andViewController:vc];
        
        if(self.showRenRenBubble)
            
            [self createButtonWithIcon:@"bgb6.png"
                       backgroundColor:self.pinterestBackgroundColorRGB
                               andType:AAShareBubbleTypePinterest
                     andViewController:vc];
        
        if(self.showKaixinBubble)
            
            [self createButtonWithIcon:@"bgb7.png"
                       backgroundColor:self.youtubeBackgroundColorRGB
                               andType:AAShareBubbleTypeYoutube
                     andViewController:vc];
        
        if(bubbles.count == 0) return;
        
        float bubbleDistanceFromPivot = self.radius - self.bubbleRadius;
        
        float bubblesBetweenAngel = 360 / bubbles.count;
        float angely = (float) ((180 - bubblesBetweenAngel) * 0.5);
        float startAngel = 180 - angely;
        
        NSMutableArray *coordinates = [NSMutableArray array];
        
        for (int i = 0; i < bubbles.count; ++i)
        {
            
            UIButton *bubble = bubbles[i];
            bubble.tag = i;
            
            float angle = startAngel + i * bubblesBetweenAngel;
            float x = (float) (cos(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius);
            float y = (float) (sin(angle * M_PI / 180) * bubbleDistanceFromPivot + self.radius);

            [coordinates addObject:@{@"x" : @(x), @"y" : @(y)}];
            
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.center = CGPointMake(self.radius, self.radius);
            
        }
        
        int inetratorI = 0;
        for (NSDictionary *coordinate in coordinates)
        {
            
            UIButton *bubble = bubbles[inetratorI];
            float delayTime = (float) (inetratorI * 0.1);
           
            [self performSelector:@selector(showBubbleWithAnimation:)
                       withObject:@{@"button" : bubble, @"coordinate" : coordinate}
                       afterDelay:delayTime];
            
            ++inetratorI;
            
        }
    }
}
-(void)hide:(UIButton *)sender
{
    
    if(!self.isAnimating)
    {
        self.isAnimating = YES;
        int inetratorI = 0;
        for (UIButton *bubble in bubbles)
        {
            
            CGFloat delayTime = (CGFloat) (inetratorI * 0.1);
            
            NSArray * arr;
            
            if (sender)
            {
                arr = @[bubble,sender];
            }
            
            else
            {
                arr = @[bubble];
            }
            
            [self performSelector:@selector(hideBubbleWithAnimation:)
                       withObject:arr
                       afterDelay:delayTime];
            
            ++inetratorI;
            
        }
        
    }
    
}


-(void)showBubbleWithAnimation:(NSDictionary *)info
{
    
    UIButton *bubble = (UIButton *) info[@"button"];
    NSDictionary *coordinate = (NSDictionary *) info[@"coordinate"];
    
    [UIView animateWithDuration:0.25
                     animations:^{
                         
        bubble.center = CGPointMake([coordinate[@"x"] floatValue], [coordinate[@"y"] floatValue]);
        bubble.alpha = 1;
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
                         
    }
                     completion:^(BOOL finished)
    {
        
        [UIView animateWithDuration:0.15
                         animations:^{
                             
            bubble.transform = CGAffineTransformMakeScale(0.8, 0.8);
                             
        }
                         completion:^(BOOL finished)
        {
            
            [UIView animateWithDuration:0.15
                             animations:^{
                                 
                bubble.transform = CGAffineTransformMakeScale(1, 1);
                                 
            }
                             completion:^(BOOL finished)
            {
                
                if(bubble.tag == bubbles.count - 1) self.isAnimating = NO;
                bubble.layer.shadowColor = [UIColor blackColor].CGColor;
                bubble.layer.shadowOpacity = 0.2;
                bubble.layer.shadowOffset = CGSizeMake(0, 1);
                bubble.layer.shadowRadius = 2;
                
            }];
            
        }];
        
    }];
}

-(void)hideBubbleWithAnimation:(NSArray *)sender
{
    UIButton * bubble = (UIButton *)sender[0];
    
    if (sender.count == 2)
    {
        UIButton * change = (UIButton *)sender[1];
        [change setImage:[UIImage imageNamed:@"userinfo_navigationbar_more@2x"] forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.2
                     animations:^{
        
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
    }
                     completion:^(BOOL finished)
     {
        
        [UIView animateWithDuration:0.25
                         animations:^{
            
            bubble.center = CGPointMake(self.radius, self.radius);
            bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            bubble.alpha = 0;
            
        }
                         completion:^(BOOL finished)
        {
            if(bubble.tag == bubbles.count - 1)
            {
                self.isAnimating = NO;
                self.hidden = YES;

                [UIView animateWithDuration:0.25
                                 animations:^{
                    
                    faderView.alpha = 0;
                                     
                }
                                 completion:^(BOOL finished)
                {
                    
                    [faderView removeFromSuperview];
                    
                    if([self.delegate respondsToSelector:@selector(aaShareBubblesDidHide:)])
                    {
                        
                        [self.delegate aaShareBubblesDidHide:self];
                        
                    }
                    
                    [self removeFromSuperview];
                    
                }];
                
            }
            
            [bubble removeFromSuperview];
            
        }];
        
    }];
    
}

-(void)createButtonWithIcon:(NSString *)iconName
            backgroundColor:(int)rgb
                    andType:(AAShareBubbleType)type
          andViewController:(UIViewController *)vc
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:vc
               action:@selector(buttonWasTapped:)
     forControlEvents:UIControlEventTouchUpInside];
    
    button.frame = CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius);
    
    // Circle background
    UIView *circle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 2 * self.bubbleRadius, 2 * self.bubbleRadius)];
    circle.backgroundColor = [self colorFromRGB:rgb];
    circle.layer.cornerRadius = self.bubbleRadius;
    circle.layer.masksToBounds = YES;
    circle.opaque = NO;
    circle.alpha = 0.97;
    
    // Circle icon
    UIImageView *icon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"AAShareBubbles.bundle/%@", iconName]]];
    CGRect f = icon.frame;
    f.origin.x = (CGFloat) ((circle.frame.size.width - f.size.width) * 0.5);
    f.origin.y = (CGFloat) ((circle.frame.size.height - f.size.height) * 0.5);
    icon.frame = f;
    [circle addSubview:icon];
    
    [button setBackgroundImage:[self imageWithView:circle]
                      forState:UIControlStateNormal];
    
    [bubbles addObject:button];
    bubbleIndexTypes[@(bubbles.count - 1)] = @(type);
    
    if ([vc isMemberOfClass:[FindFriendAndWeiboDetaileViewController class]])
    {
        
        FindFriendAndWeiboDetaileViewController * find = (FindFriendAndWeiboDetaileViewController *)vc;
        find.bubbleIndexTypes = [NSMutableDictionary new];
        find.bubbleIndexTypes = bubbleIndexTypes;
        find.type = _type;
        
    }
   
    if ([vc isMemberOfClass:[BaseViewController class]])
    {
        
        BaseViewController * base = (BaseViewController *)vc;
        base.bubbleIndexTypes = [NSMutableDictionary new];
        base.bubbleIndexTypes = bubbleIndexTypes;
        
    }

    [self addSubview:button];
}

-(UIColor *)colorFromRGB:(int)rgb
{
    return [UIColor colorWithRed:((float)((rgb & 0xFF0000) >> 16))/255.0 green:((float)((rgb & 0xFF00) >> 8))/255.0 blue:((float)(rgb & 0xFF))/255.0 alpha:1.0];
}

-(UIImage *)imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
