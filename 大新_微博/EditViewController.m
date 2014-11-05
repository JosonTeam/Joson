#import "EditViewController.h"
#import "EmotionKeyBoard.h"
#import "Factory.h"
#import "JSKit.h"

@interface EditViewController ()
{
    int _high;
    int _width;
    UITextView * _textView;
    EmotionKeyBoard * _emotion;
    NSMutableArray * _picName;
    UIView * _button_View;
    NSMutableArray * _buttonImage;
    UIButton * _audio;
    UIImage * _audioImage;
    NSString * _limit;
    UIImage * _weiboimage;
}
@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self init_View];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIView *)getInputAccessoryView
{
    UIView * bgView = [[UIView alloc]initWithFrame:CGRectMake(0, _high-135, _width, 135)];
    
    UIView * weiboView = [[UIView alloc]initWithFrame:CGRectMake(5, 5, _width-10, 60)];
    weiboView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [bgView addSubview:weiboView];
    
    UIImageView * weiboImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    [weiboImage setImage:_weiboimage];
    [weiboView addSubview:weiboImage];
    
    UILabel * weiboUser = [[UILabel alloc]initWithFrame:CGRectMake(65, 0, _width-70, 30)];
    weiboUser.text = [NSString stringWithFormat:@"@%@",_source[@"user"][@"name"]];
    [weiboView addSubview:weiboUser];
    
    UILabel * weiboContent = [[UILabel alloc]initWithFrame:CGRectMake(65, 25, _width-80, 30)];
    weiboContent.font = [UIFont systemFontOfSize:10];
    weiboContent.numberOfLines = 2;
    weiboContent.textColor = [UIColor darkGrayColor];
    weiboContent.text = _source[@"text"];
    [weiboView addSubview:weiboContent];
    
    if (_source[@"retweeted_status"])
    {
        weiboUser.text = [NSString stringWithFormat:@"@%@",_source[@"retweeted_status"][@"user"][@"name"]];
        weiboContent.text = _source[@"retweeted_status"][@"text"];
        if ([_weiboimage isEqual:[UIImage imageNamed:@"compose_toolbar_picture@2x.png"]])
        {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_source[@"retweeted_status"][@"pic_urls"][0][@"thumbnail_pic"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                        _weiboimage = [UIImage imageWithData:data];
                        weiboImage.image = [UIImage imageWithData:data];
                    });
                });
        }
    }
    else if([_source[@"pic_urls"] count] != 0)
    {
        if ([_weiboimage isEqual:[UIImage imageNamed:@"compose_toolbar_picture@2x.png"]])
        {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:_source[@"pic_urls"][0][@"thumbnail_pic"]]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    _weiboimage = [UIImage imageWithData:data];
                    weiboImage.image = [UIImage imageWithData:data];
                });
            });
        }
    }
    
    UIView * selectView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(bgView.frame)-60, _width, 30)];
    [bgView addSubview:selectView];
    
    _audio = [UIButton buttonWithType:UIButtonTypeCustom];
    [_audio setImage:_audioImage forState:UIControlStateNormal];
    _audio.frame = CGRectMake(10, -6, 25, 25);
    _audio.selected = YES;
    [_audio addTarget:self action:@selector(audioChange) forControlEvents:UIControlEventTouchUpInside];
    [selectView addSubview:_audio];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, -6, 72, 25)];
    label.font = [UIFont systemFontOfSize:15];
    [selectView addSubview:label];
    
    if ([_type isEqualToString:@"comment"])
    {
        label.text = @"同时转发";
    }
    if ([_type isEqualToString:@"report"])
    {
        label.text = @"同时评论";
        UIButton * limitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        limitButton.frame = CGRectMake(_width-120, -7, 110, 30);
        [limitButton setImage:[UIImage imageNamed:@"compose_publicbutton_background@2x.png"] forState:UIControlStateNormal];
        [limitButton setTitle:_limit forState:UIControlStateNormal];
        [limitButton setTitleColor:[UIColor colorWithRed:0 green:0 blue:0.5 alpha:0.8] forState:UIControlStateNormal];
        limitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        limitButton.selected = YES;
        [selectView addSubview:limitButton];
    }
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(bgView.frame)-40, _width,40)];
    view.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.5];
    [bgView addSubview:view];
    
    [self.view addSubview:bgView];
    _textView.inputAccessoryView = bgView;
    
    for (int i = 0; i < _buttonImage.count; i++)
    {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*_width/_buttonImage.count, 0, _width/_buttonImage.count, 40);
        [button setImage:_buttonImage[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(click_Button:) forControlEvents:UIControlEventTouchUpInside];
        button.selected = YES;
        
        if ([_buttonImage[i] isEqual:[UIImage imageNamed:@"toolbar_rightarrow@2x2.png"]])
        {
            button.tag = 5;
        }
        else
        {
            button.tag = i+1;
        }
        [view addSubview:button];
    }
    return bgView;
}

- (void)audioChange
{
    if ([_audioImage isEqual:[UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"]])
    {
        _audioImage = [UIImage imageNamed:@"diaglog_recommended_check@2x.png"];
        [_audio setImage:[UIImage imageNamed:@"diaglog_recommended_check@2x.png"] forState:UIControlStateNormal];
    }
    else
    {
        _audioImage = [UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"];
        [_audio setImage:[UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"] forState:UIControlStateNormal];
    }
}

- (void)init_View
{
    
    _weiboimage = [UIImage imageNamed:@"compose_toolbar_picture@2x.png"];
    _limit = @"公开";
    NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _audioImage = [UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    [NavigationControllerCustomer createBackButtonForViewController:self hideOldBackButtonOfNavigationItem:1 withTag:1 andImage:nil orTitile:@"取消" andType:UIButtonTypeCustom];
    [NavigationControllerCustomer createRightBarButtonItemForViewController:self withTag:2 andTitle:@"发送" andImage:nil andType:UIButtonTypeCustom];
    
    UIButton * back = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * send = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 69, _width-10, _high-208)];
    _textView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.showsHorizontalScrollIndicator = NO;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.textColor = [UIColor grayColor];
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_textView];
    
    _buttonImage = [[NSMutableArray alloc]initWithObjects:[UIImage imageNamed:@"compose_mentionbutton_background@2x.png"],[UIImage imageNamed:@"compose_trendbutton_background@2x.png"],[UIImage imageNamed:@"message_emotion_background@2x.png"],[UIImage imageNamed:@"toolbar_rightarrow@2x2.png"], nil];
    
    if ([_type isEqualToString:@"comment"])
    {
        [NavigationControllerCustomer setTitle:@"发评论" andSubtitle:_name withColor:[UIColor blackColor] forViewController:self];
        [send addTarget:self action:@selector(commentWeibo) forControlEvents:UIControlEventTouchUpInside];
        _textView.text = @"写评论...";
    }
    
    if ([_type isEqualToString:@"report"])
    {
        [NavigationControllerCustomer setTitle:@"转发微博" andSubtitle:_name withColor:[UIColor blackColor] forViewController:self];
        [send addTarget:self action:@selector(reportWeibo) forControlEvents:UIControlEventTouchUpInside];
        _textView.text = @"说说分享心情...";
        
        [_buttonImage insertObject:[UIImage imageNamed:@"message_add_background@2x.png"] atIndex:3];
    }
    
    _button_View = [self getInputAccessoryView];
}

- (void)commentWeibo
{
    if ([_textView.text isEqualToString:@"写评论..."])
    {
        _textView.text = nil;
    }
    [MicroBlogOperateForSina CommentWeiboWithAccessToken:_access_token content:_textView.text andId:[_source[@"id"] integerValue]];
    if ([_audioImage isEqual:[UIImage imageNamed:@"diaglog_recommended_check@2x.png"]])
    {
        [self reportWeibo];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reportWeibo
{
    if ([_textView.text isEqualToString:@"说说分享心情..."])
    {
        _textView.text = nil;
    }
    [MicroBlogOperateForSina reportWeiboWithAccessToken:_access_token withContent:_textView.text andId:[_source[@"id"] integerValue]];
    if ([_audioImage isEqual:[UIImage imageNamed:@"diaglog_recommended_check@2x.png"]])
    {
        [self commentWeibo];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)click_Button:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
        {
            if ([sender.imageView.image isEqual:[UIImage imageNamed:@"message_emotion_background@2x.png"]])
            {
                [sender setImage:[UIImage imageNamed:@"message_keyboard_background@2x.png"] forState:UIControlStateNormal];
                _emotion = [[EmotionKeyBoard alloc]initWithFrame:CGRectMake(0, 0, _width, 190)];
                _emotion = [_emotion initWithBundleName:@"Emotion1" viewController:self];
                _picName = [[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:@"Emotion1" ofType:@"bundle"]]pathsForResourcesOfType:@"png" inDirectory:nil].mutableCopy;
                _textView.inputView = _emotion;
            }
            else
            {
                [sender setImage:[UIImage imageNamed:@"message_emotion_background@2x.png"] forState:UIControlStateNormal];
                _textView.inputView = nil;
            }
            [_textView resignFirstResponder];
            [_textView becomeFirstResponder];
        }
            break;
        case 4:
            
            break;
        case 5:
            [_textView resignFirstResponder];
            _textView.frame = CGRectMake(5, 69, _width-10, _high-208);
            [_button_View removeFromSuperview];
            _button_View = [self getInputAccessoryView];
            break;
    }
}

- (void)change_Selected:(UISegmentedControl *)sender

{
    NSString * name;
    for (UIView * view in _emotion.scroll.subviews)
    {
        [view removeFromSuperview];
    }
    switch (sender.selectedSegmentIndex)
    {
        case 0:
            name = @"RecentEmotion";
            break;
        case 1:
            name = @"Emotion1";
            _picName = [[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:name ofType:@"bundle"]]pathsForResourcesOfType:@"png" inDirectory:nil].mutableCopy;
            break;
        case 2:
            name = @"MEmotion";
            _picName = [[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:name ofType:@"bundle"]]pathsForResourcesOfType:@"gif" inDirectory:nil].mutableCopy;
            break;
        case 3:
            name = @"Emotion2";
            _picName = [[NSBundle bundleWithPath:[[NSBundle mainBundle]pathForResource:name ofType:@"bundle"]]pathsForResourcesOfType:@"gif" inDirectory:nil].mutableCopy;
            break;

    }
    UIView * bg_View = [_emotion getSource:name ViewController:self];
    _emotion.scroll.contentSize = CGSizeMake(CGRectGetWidth(bg_View.frame), 140);
    _emotion.scroll.contentOffset = CGPointMake(0, 0);
    _emotion.pageC.numberOfPages = _emotion.arr_Count;
    [_emotion.scroll addSubview:bg_View];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (_textView.textColor == [UIColor grayColor])
    {
        _textView.textColor = [UIColor blackColor];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([_textView.text isEqualToString:@"说说分享心情..."] || [_textView.text isEqualToString:@"写评论..."])
    {
        _textView.text = nil;
    }
    _textView.frame = CGRectMake(5, 69, _width-10, _high-418);
}

- (void)select_Emotion:(UITapGestureRecognizer *)sender
{
    if (_textView.textColor == [UIColor grayColor])
    {
        _textView.textColor = [UIColor blackColor];
    }
    if (_textView.text.length == 0)
    {
        _textView.text = [NSString stringWithFormat:@"[%@]",[[[[[[_picName[sender.view.tag-101]componentsSeparatedByString:@"/"]lastObject]componentsSeparatedByString:@"."]objectAtIndex:0] componentsSeparatedByString:@"@"]objectAtIndex:0]];
    }
    else
    {
        _textView.text = [_textView.text stringByAppendingString:[NSString stringWithFormat:@"[%@]",[[[[[[_picName[sender.view.tag-101]componentsSeparatedByString:@"/"]lastObject]componentsSeparatedByString:@"."]objectAtIndex:0] componentsSeparatedByString:@"@"]objectAtIndex:0]]];
    }
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
