#import "EditViewController.h"
#import "EmotionKeyBoard.h"

@implementation EmotionKeyBoard

- (id)initWithBundleName:(NSString *)name
          viewController:(EditViewController *)vc
{
    self = [super initWithFrame:self.frame];
    
    _width = [[Factory getHeigtAndWidthOfDevice][0] intValue];
    
    UIView * bgView = [self getSource:name
                       ViewController:vc];
    
    _scroll = [[UIScrollView alloc] initWithFrame : CGRectMake(0, 0, _width, 140)];
    _scroll.contentSize = CGSizeMake(CGRectGetWidth(bgView.frame), 140);
    _scroll.showsHorizontalScrollIndicator = 0;
    _scroll.showsVerticalScrollIndicator = 0;
    _scroll.pagingEnabled = 1;
    _scroll.delegate = self;
    _scroll.bounces = 0;
    [_scroll addSubview:bgView];
    [self addSubview:_scroll];
    
    _pageC = [[UIPageControl alloc] initWithFrame : CGRectMake(_width/2, 140, (ceil(_arr_Count/2)-1)*5, 20)];
    _pageC.pageIndicatorTintColor = [UIColor grayColor];
    _pageC.currentPageIndicatorTintColor = [UIColor yellowColor];
    _pageC.numberOfPages = _arr_Count;
    [self addSubview:_pageC];
    
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems : @[@"最近" , @"默认" , @"Emoji" , @"浪小花"]];
    
    [segment addTarget:vc
                action:@selector(change_Selected:)
     forControlEvents : UIControlEventValueChanged];
    
    segment.frame = CGRectMake(0, 160, _width, 30);
    segment.backgroundColor = [UIColor grayColor];
    segment.tintColor = [UIColor whiteColor];
    segment.selectedSegmentIndex = 1;
    [self addSubview:segment];
    
    return self;
}

- (UIView *)getSource:(NSString *)name
       ViewController:(EditViewController *)vc
{
    NSMutableArray * source;
    
    if ([name isEqualToString:@"Emotion1"] || [name isEqualToString:@"RecentEmotion"])
    {
        
        source = [[NSBundle bundleWithPath : [[NSBundle mainBundle] pathForResource:name
                                                                             ofType:@"bundle"]] pathsForResourcesOfType:@"png"
                                                                                                            inDirectory:nil].mutableCopy;
        
    }
    
    else
    {
        
        source = [[NSBundle bundleWithPath : [[NSBundle mainBundle] pathForResource:name
                                                                             ofType:@"bundle"]] pathsForResourcesOfType:@"gif"
                                                                                                            inDirectory:nil].mutableCopy;
        
    }
    
    [source insertObject : [[NSBundle mainBundle] pathForResource:@"compose_emotion_delete_highlighted@2x"
                                                           ofType:@"png"]
                  atIndex:0];
    
    NSMutableArray * item_Source = [NSMutableArray new];
    NSMutableArray * appeare_Source = [NSMutableArray new];
    
    for (int i = 1; i < source.count; i++)
    {
        [item_Source addObject:source[i]];
        if (i % 21 == 0)
        {
            
            [source insertObject : [[NSBundle mainBundle] pathForResource:@"compose_emotion_delete_highlighted@2x"
                                                                  ofType:@"png"]
                          atIndex:i];
            
            [item_Source removeLastObject];
            [item_Source addObject : [[NSBundle mainBundle] pathForResource:@"compose_emotion_delete_highlighted@2x"
                                                                    ofType:@"png"]];
            [appeare_Source addObject:item_Source.copy];
            item_Source = [NSMutableArray new];
        }
    }
    
    _arr_Count = (int)appeare_Source.count;
    int num = 100;
    UIView * bgView = [[UIView alloc] initWithFrame : CGRectMake(0, 0, _arr_Count*_width, 140)];
    
    for (int i = 0; i < _arr_Count; i++)
    {
        
        for (int j = 0; j < [appeare_Source[i] count]; j++)
        {
            
            NSData * image_Data = [NSData dataWithContentsOfFile:appeare_Source[i][j]];
            
            UIImageView * image = [[UIImageView alloc] initWithFrame : CGRectMake(_width*i+10+j%7*45, 10+j/7*40,  30, 30)];
            image.image = [UIImage imageWithData:image_Data];
            image.userInteractionEnabled = YES;
            image.tag = num*i+j;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:vc
                                                                                   action:@selector(select_Emotion:)];
            
            [image addGestureRecognizer:tap];
            [bgView addSubview:image];
            
        }
        
    }
    
    vc.picName = appeare_Source;
    
    return bgView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _pageC.currentPage = (int)((int)scrollView.contentOffset.x/_width);
}

@end
