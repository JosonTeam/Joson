#import <UIKit/UIKit.h>

@protocol AAShareBubblesDelegate;

typedef enum AAShareBubbleType : int {
    AAShareBubbleTypeFacebook = 0,
    AAShareBubbleTypeTwitter = 1,
    AAShareBubbleTypeGooglePlus = 2,
    AAShareBubbleTypeTumblr = 3,
    AAShareBubbleTypeMail = 4,
    AAShareBubbleTypeVk = 5, // Vkontakte (vk.com)
    AAShareBubbleTypeLinkedIn = 6,
    AAShareBubbleTypePinterest = 7,
    AAShareBubbleTypeYoutube = 8,
    AAShareBubbleTypeVimeo = 9,
    AAShareBubbleTypeReddit = 10,
    AAShareBubbleTypeInstagram = 11,
    AAShareBubbleTypeFavorite = 12,
    AAShareBubbleTypeWhatsapp = 13
    
} AAShareBubbleType;

@interface AAShareBubbles : UIView

@property (nonatomic, assign) id<AAShareBubblesDelegate> delegate;

@property (nonatomic, assign) BOOL showTencentMicroblogBubble;
@property (nonatomic, assign) BOOL showSinaMicroblogBubble;

@property (nonatomic, assign) BOOL showMingdaoBubble;
@property (nonatomic, assign) BOOL showWangyiBubble;
@property (nonatomic, assign) BOOL showDouBanBubble;
@property (nonatomic, assign) BOOL showRenRenBubble;
@property (nonatomic, assign) BOOL showKaixinBubble;
@property (nonatomic, assign) BOOL showYixinBubble;
@property (nonatomic, assign) BOOL showMailBubble;

// The radius from center point to each share button
@property (nonatomic, assign) int radius;

// Bubble button radius
@property (nonatomic, assign) int bubbleRadius;

// Define if bubbles are currently animating (showing or hiding)
@property (nonatomic, assign) BOOL isAnimating;

@property (nonatomic, weak) UIView *parentView;

// The fader view alpha, by default is 0.15
@property(nonatomic, assign) CGFloat faderAlpha;

@property (nonatomic, assign) int googlePlusBackgroundColorRGB;
@property (nonatomic, assign) int pinterestBackgroundColorRGB;
@property (nonatomic, assign) int instagramBackgroundColorRGB;
@property (nonatomic, assign) int favoriteBackgroundColorRGB;
@property (nonatomic, assign) int whatsappBackgroundColorRGB;
@property (nonatomic, assign) int linkedInBackgroundColorRGB;
@property (nonatomic, assign) int facebookBackgroundColorRGB;
@property (nonatomic, assign) int twitterBackgroundColorRGB;
@property (nonatomic, assign) int youtubeBackgroundColorRGB;
@property (nonatomic, assign) int tumblrBackgroundColorRGB;
@property (nonatomic, assign) int redditBackgroundColorRGB;
@property (nonatomic, assign) int vimeoBackgroundColorRGB;
@property (nonatomic, assign) int mailBackgroundColorRGB;
@property (nonatomic, assign) int vkBackgroundColorRGB;

-(id)initWithPoint:(CGPoint)point
            radius:(int)radiusValue
            inView:(UIView *)inView;

// Share bubbles will appear in UIWindow instance
-(id)initCenteredInWindowWithRadius:(int)radiusValue;

-(void)shareButtonTappedWithType:(AAShareBubbleType)buttonType;

-(void)show:(UIViewController *)vc;

-(void)hide;

@end

@protocol AAShareBubblesDelegate<NSObject>

@optional

// On buttons pressed
-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles
 tappedBubbleWithType:(AAShareBubbleType)bubbleType;

// On bubbles hide
-(void)aaShareBubblesDidHide:(AAShareBubbles *)shareBubbles;

@end
