#import "LimitViewController.h"
#import "EditViewController.h"
#import "EmotionKeyBoard.h"

@interface EditViewController ()
{

    NSMutableArray * _buttonImage; //按钮的图片
    NSMutableArray * _rangArray; //表情位置
    EmotionKeyBoard * _emotion; //表情键盘
    UIImageView * _weiboImage; //微博配图显示框
    UITextView * _textView; //文本框
    UIImage * _audioImage; //单选框的图片
    UIImage * _weiboimage; //微博配图
    UIView * _button_View; //放置键盘回收按钮等的底层view
    UIView * _addKeyBoard; //＋按钮下的键盘
    UIView * _weiboView; //微博主内容的底层view
    UIButton * _audio; //单选框
    NSString * _limit; //分享范围
    NSURL * _url; //图片地址
    int _width; //屏幕宽度
    int _high; //屏幕高度
    
}

@end

@implementation EditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
       
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = 0;
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

#pragma mark 初始化界面
- (void)init_View
{
    
    _audioImage = [UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"];
    _weiboimage = [UIImage imageNamed:@"compose_toolbar_picture@2x.png"];
    
    //为navigationBar添加返回按钮和右侧按钮
     [NavigationControllerCustomer createBackButtonForViewController:self
                                  hideOldBackButtonOfNavigationItem:1
                                                            withTag:1
                                                           andImage:nil
                                                           orTitile:@"取消"
                                                           andType : UIButtonTypeCustom];
    
    [NavigationControllerCustomer createRightBarButtonItemForViewController:self
                                                                    withTag:2
                                                                   andTitle:@"发送"
                                                                   andImage:nil
                                                                   andType : UIButtonTypeCustom];
    
    //获取屏幕尺寸
     NSArray * widthAndHigh = [Factory getHeigtAndWidthOfDevice];
    _width = [widthAndHigh[0] intValue];
    _high = [widthAndHigh[1] intValue];
    
    _rangArray = [NSMutableArray new];
    _limit = @"公开";
    
    
    if ([_type isEqualToString:@"post"])
    {
        _weiboimage = nil;
    }
    
    _addKeyBoard = [[UIView alloc] initWithFrame : CGRectMake(0, 0, _width, 200)];
    
    for (int i = 0; i < 2; i++)
    {
        
        //“＋”按钮下显示的按钮图片
        UIImageView * buttonImageView = [[UIImageView alloc] initWithFrame : CGRectMake(5+i*65, 5, 60, 60)];
        buttonImageView.backgroundColor = [UIColor whiteColor];
        buttonImageView.userInteractionEnabled = 1;
        [_addKeyBoard addSubview:buttonImageView];
        
        //“＋”按钮下的按钮名字
        UILabel * buttonLabel = [[UILabel alloc] initWithFrame : CGRectMake(5+i*65, 65, 60, 30)];
        buttonLabel.textAlignment = NSTextAlignmentCenter;
        buttonLabel.font = [UIFont systemFontOfSize:15];
        [_addKeyBoard addSubview:buttonLabel];
        
        switch (i)
        {
                
            case 0:
                
                [buttonImageView setImage : [UIImage imageNamed:@"compose_more_bigweibo@2x.png"]];
                buttonLabel.text = @"长微博";
                
                break;
                
            case 1:
                
                [buttonImageView setImage : [UIImage imageNamed:@"compose_more_transfer@2x.png"]];
                buttonLabel.text = @"收款";
                
                break;
                
        }
        
    }
    
    //为返回按钮添加方法
    UIButton * back = (UIButton *)self.navigationItem.leftBarButtonItem.customView;

    [back addTarget:self
             action:@selector(back)
  forControlEvents : UIControlEventTouchUpInside];
    
    UIButton * send = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //添加文本框
    _textView = [[UITextView alloc] initWithFrame : CGRectMake(5, 69, _width-10, _high-208)];
    _textView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _textView.font = [UIFont systemFontOfSize:15];
    _textView.showsHorizontalScrollIndicator = NO;
    _textView.showsVerticalScrollIndicator = NO;
    _textView.textColor = [UIColor grayColor];
    _textView.delegate = self;
    [self.view addSubview:_textView];
    
    _buttonImage = [[NSMutableArray alloc] initWithObjects : [UIImage imageNamed:@"compose_mentionbutton_background@2x.png"] , [UIImage imageNamed:@"compose_trendbutton_background@2x.png"] , [UIImage imageNamed:@"message_emotion_background@2x.png"] , [UIImage imageNamed:@"toolbar_rightarrow@2x2.png"] , nil];
    
    //根据不同操作类型，为navigationBar设置标题，并为发送按钮添加相应方法
    if ([_type isEqualToString:@"comment"])
    {
        
        [NavigationControllerCustomer setTitle:@"发评论"
                                   andSubtitle:_name
                                    withColor : [UIColor blackColor]
                             forViewController:self];
        
        [send addTarget:self
                 action:@selector(commentWeibo)
      forControlEvents : UIControlEventTouchUpInside];
        
        _textView.text = @"写评论...";
        
    }
    
    if ([_type isEqualToString:@"report"])
    {
        
        [NavigationControllerCustomer setTitle:@"转发微博"
                                   andSubtitle:_name
                                    withColor : [UIColor blackColor]
                             forViewController:self];
        
        [send addTarget:self
                 action:@selector(reportWeibo)
      forControlEvents : UIControlEventTouchUpInside];
        
        _textView.text = @"说说分享心得...";
        
        [_buttonImage insertObject : [UIImage imageNamed:@"message_add_background@2x.png"]
                            atIndex:3];
        
    }
    
    if ([_type isEqualToString:@"post"])
    {
        [NavigationControllerCustomer setTitle:@"发微博"
                                   andSubtitle:_name
                                    withColor : [UIColor blackColor]
                             forViewController:self];
        
        [send addTarget:self
                 action:@selector(postWeibo)
      forControlEvents : UIControlEventTouchUpInside];
        
        _textView.text = @"分享新鲜事...";
        
        [_buttonImage insertObject : [UIImage imageNamed:@"message_add_background@2x.png"]
                            atIndex:3];
        
        [_buttonImage insertObject : [UIImage imageNamed:@"compose_toolbar_picture@2x.png"]
                            atIndex:0];
    }
    
    if ([_type isEqualToString:@"share"])
    {
        
        [NavigationControllerCustomer setTitle:@"转发到微博"
                                   andSubtitle:_name
                                    withColor : [UIColor blackColor]
                             forViewController:self];
        
        [send addTarget:self
                 action:@selector(reportWeibo)
      forControlEvents : UIControlEventTouchUpInside];
        
        _textView.text = @"说说分享心得...";
        
    }
    
    _button_View = [self getInputAccessoryView];
    
}

#pragma mark 分享范围按钮
- (void)getLimitButton:(UIView *)selectView
{
    _limitButton = [UIButton buttonWithType : UIButtonTypeCustom];
    _limitButton.frame = CGRectMake(_width-120, -7, 110, 30);
    
    [_limitButton setImage : [UIImage imageNamed:@"compose_publicbutton_background@2x.png"]
                  forState : UIControlStateNormal];
    
    [_limitButton setTitle:_limit
                 forState : UIControlStateNormal];
    
    [_limitButton setTitleColor : [UIColor colorWithRed:0
                                                  green:0
                                                   blue:0.5
                                                  alpha:0.8]
                       forState : UIControlStateNormal];
    
    _limitButton.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [_limitButton addTarget:self
                     action:@selector(selectLimit)
          forControlEvents : UIControlEventTouchUpInside];
    
    _limitButton.selected = YES;
    [selectView addSubview:_limitButton];
}

#pragma mark 取得图片选框，权限按钮 和 键盘选择按钮等
- (UIView *)getInputAccessoryView
{
    UIView * bgView = [[UIView alloc] initWithFrame : CGRectMake(0, _high-135, _width, 135)];
    
    _weiboView = [[UIView alloc] initWithFrame : CGRectMake(5, 5, _width-10, 60)];
    
    _weiboView.backgroundColor = [UIColor colorWithWhite:0.9
                                                   alpha:1];
    
    [bgView addSubview:_weiboView];
    
    //添加微博配图
    _weiboImage = [[UIImageView alloc] initWithFrame : CGRectMake(0, 0, 60, 60)];
    [_weiboImage setImage:_weiboimage];
    [_weiboView addSubview:_weiboImage];
    
    if ([_type isEqualToString:@"post"])
    {
        
        _weiboView.backgroundColor = [UIColor whiteColor];
        
        UIView * selectView = [[UIView alloc] initWithFrame : CGRectMake(0, CGRectGetHeight(bgView.frame)-60, _width, 30)];
        [bgView addSubview:selectView];
        
        [self getLimitButton:selectView];
        
    }
    
    else
    {
        
        UILabel * weiboUser = [[UILabel alloc] initWithFrame : CGRectMake(65, 0, _width-70, 30)];
        weiboUser.text = [NSString stringWithFormat:@"@%@",_source[@"user"][@"name"]];
        [_weiboView addSubview:weiboUser];
        
        UILabel * weiboContent = [[UILabel alloc] initWithFrame : CGRectMake(65, 25, _width-80, 30)];
        weiboContent.font = [UIFont systemFontOfSize:10];
        weiboContent.numberOfLines = 2;
        weiboContent.textColor = [UIColor darkGrayColor];
        weiboContent.text = _source[@"text"];
        [_weiboView addSubview:weiboContent];
        
        if ([_type isEqualToString:@"share"])
        {
            weiboUser.text = @"微博找人广场－精心推荐好友";
            weiboContent.text = @"微博推荐好友 - 寻找你认识的那个ta";
        }
        
        if (_source[@"retweeted_status"])
        {
            
            weiboUser.text = [NSString stringWithFormat:@"@%@",_source[@"retweeted_status"][@"user"][@"name"]];
            weiboContent.text = _source[@"retweeted_status"][@"text"];
            
            if ([_weiboimage isEqual : [UIImage imageNamed:@"compose_toolbar_picture@2x.png"]])
            {
                
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                    NSData * data = [[NSData alloc] initWithContentsOfURL : [NSURL URLWithString:_source[@"retweeted_status"][@"pic_urls"][0][@"thumbnail_pic"]]];
                        
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                            _weiboimage = [UIImage imageWithData:data];
                            _weiboImage.image = [UIImage imageWithData:data];
                        
                        });
                    });
                
            }
            
        }
        
        else if([_source[@"pic_urls"] count] != 0)
        {
            
            if ([_weiboimage isEqual : [UIImage imageNamed:@"compose_toolbar_picture@2x.png"]])
            {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    NSData * data = [[NSData alloc] initWithContentsOfURL : [NSURL URLWithString:_source[@"pic_urls"][0][@"thumbnail_pic"]]];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        _weiboimage = [UIImage imageWithData:data];
                        _weiboImage.image = [UIImage imageWithData:data];
                        
                    });
                    
                });
                
            }
            
        }
        
        UIView * selectView = [[UIView alloc] initWithFrame : CGRectMake(0, CGRectGetHeight(bgView.frame)-60, _width, 30)];
        [bgView addSubview:selectView];
        
        UILabel * label;
        
        if ([_type isEqualToString:@"share"])
        {
            
            [self getLimitButton:selectView];
            
            _weiboImage.image = [UIImage imageNamed:@"poi_icon_myplace@2x.png"];
            _weiboimage = [UIImage imageNamed:@"poi_icon_myplace@2x.png"];

        }
        
        else
        {
            
            //添加单选框
            _audio = [UIButton buttonWithType : UIButtonTypeCustom];
            
            [_audio setImage:_audioImage
                   forState : UIControlStateNormal];
            
            _audio.frame = CGRectMake(10, -6, 25, 25);
            _audio.selected = YES;
            
            [_audio addTarget:self
                       action:@selector(audioChange)
            forControlEvents : UIControlEventTouchUpInside];
            
            [selectView addSubview:_audio];
            
            label = [[UILabel alloc] initWithFrame : CGRectMake(40, -6, 72, 25)];
            label.font = [UIFont systemFontOfSize:15];
            [selectView addSubview:label];
            
        }
        
        if ([_type isEqualToString:@"comment"])
        {
            label.text = @"同时转发";
        }
        
        if ([_type isEqualToString:@"report"])
        {
            
            label.text = @"同时评论";
            
            [self getLimitButton:selectView];
            
        }
    }
    
    UIView * view = [[UIView alloc] initWithFrame : CGRectMake(0, CGRectGetHeight(bgView.frame)-40, _width,40)];
    
    view.backgroundColor = [UIColor colorWithWhite:0.8
                                             alpha:0.5];
    
    [bgView addSubview:view];
    
    [self.view addSubview:bgView];
    
    for (int i = 0; i < _buttonImage.count; i++)
    {
        
        //添加键盘回收按钮，表情键盘按钮，图片选择按钮等
        UIButton * button = [UIButton buttonWithType : UIButtonTypeCustom];
        button.frame = CGRectMake(i*_width/_buttonImage.count, 0, _width/_buttonImage.count, 40);
        
        [button setImage:_buttonImage[i]
               forState : UIControlStateNormal];
        
        [button addTarget:self
                   action:@selector(click_Button:)
        forControlEvents : UIControlEventTouchUpInside];
        
        button.selected = YES;
        
        if (_buttonImage.count < 6)
        {
            
            if ([_buttonImage[i] isEqual : [UIImage imageNamed:@"toolbar_rightarrow@2x2.png"]])
            {
                button.tag = 5;
            }
            
            else
            {
                button.tag = i+1;
            }
            
        }
        
        else
        {
            
            if ([_buttonImage[i] isEqual : [UIImage imageNamed:@"toolbar_rightarrow@2x2.png"]])
            {
                button.tag = 5;
            }
            
            else if(i == 0)
            {
                button.tag = 6;
            }
            
            else
            {
                button.tag = i;
            }
            
        }
        
        [view addSubview:button];
    }
    
    return bgView;
}

#pragma mark 单选框
- (void)audioChange
{
    
    //如果单选框中打了勾，则取消打勾，否则勾上
    if ([_audioImage isEqual : [UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"]])
    {
        
        _audioImage = [UIImage imageNamed:@"diaglog_recommended_check@2x.png"];
        
        [_audio setImage : [UIImage imageNamed:@"diaglog_recommended_check@2x.png"]
                forState : UIControlStateNormal];
        
    }
    
    else
    {
        
        _audioImage = [UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"];
        
        [_audio setImage : [UIImage imageNamed:@"diaglog_recommended_check_highlighted@2x.png"]
                forState : UIControlStateNormal];
        
    }
    
}

#pragma mark 评论微博
- (void)commentWeibo
{
    
    if ([_textView.text isEqualToString:@"写评论..."])
    {
        _textView.text = nil;
    }
    
    //评论微博
    [MicroBlogOperateForSina CommentWeiboWithAccessToken:_access_token
                                                 content:_textView.text
                                                   andId:[_source[@"id"] integerValue]];
    
    //若单选框打钩，则同时转发
    if ([_audioImage isEqual : [UIImage imageNamed:@"diaglog_recommended_check@2x.png"]])
    {
        [self reportWeibo];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 发送微博
- (void)postWeibo
{
    
    if (_weiboimage)
    {
        //发送图片微博
        [MicroBlogOperateForSina postWordWeiboAndSinglePictureWithAccessToken:_access_token
                                                                      content:_textView.text
                                                                          pic:_url
                                                                      andType:VisibleTypeAll];
    }
    
    else
    {
        //发送文字微博
        BOOL isOK = [MicroBlogOperateForSina postWordWeiboWithAccessToken:_access_token
                                                                  content:_textView.text
                                                                  andType:nil];
        
        if (isOK)
          {
              //发送成功时，作出提醒
            UILabel * label = [[UILabel alloc] initWithFrame : CGRectMake(_width/2-40, -20, 80, 30)];
              
            [UIView animateWithDuration:0.1
                             animations:^{
                                 
                label.frame = CGRectMake(_width/2-40, 0, 80, 30);
                                 
            }];
              
            label.textColor = [UIColor redColor];
            label.text = @"发送成功";
            [_textView addSubview:label];
              
            [self performSelector:@selector(finishNotice:)
                       withObject:label
                       afterDelay:2];
              
        }
        
    }
    
}

#pragma mark 转发微博
- (void)reportWeibo
{
    
    if ([_textView.text isEqualToString:@"说说分享心得..."])
    {
        _textView.text = nil;
    }
    
    //转发微博
    [MicroBlogOperateForSina reportWeiboWithAccessToken:_access_token
                                            withContent:_textView.text
                                                  andId:[_source[@"id"] integerValue]];
    
    //若单选框打勾，则同时评论
    if ([_audioImage isEqual : [UIImage imageNamed:@"diaglog_recommended_check@2x.png"]])
    {
        [self commentWeibo];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark 进入范围选择界面
- (void)selectLimit
{
    
    LimitViewController * limitVC = [LimitViewController new];
    limitVC.edit = self;
    
    [self.navigationController pushViewController:limitVC
                                         animated:YES];
    
}

#pragma mark 微博发送成功提示消失
- (void)finishNotice:(UILabel *)label
{
    [label removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}

#warning 方法未完善
#pragma mark 表情键盘，@好友，话题，键盘回收按钮等触发方法
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
            //弹出和取消弹出表情键盘
            if ([sender.imageView.image isEqual : [UIImage imageNamed:@"message_emotion_background@2x.png"]])
            {
                
                [sender setImage : [UIImage imageNamed:@"message_keyboard_background@2x.png"]
                        forState : UIControlStateNormal];
                
                _emotion = [[EmotionKeyBoard alloc] initWithFrame : CGRectMake(0, 0, _width, 190)];
                
                _emotion = [_emotion initWithBundleName:@"Emotion1"
                                         viewController:self];
            
                _textView.inputView = _emotion;
                
                UIButton * button = (UIButton *)[_button_View viewWithTag:4];
                
                [button setImage : [UIImage imageNamed:@"message_add_background@2x.png"]
                        forState : UIControlStateNormal];
        
            }
            
            else
            {
                
                [sender setImage : [UIImage imageNamed:@"message_emotion_background@2x.png"]
                        forState : UIControlStateNormal];
                
                _textView.inputView = nil;
                
            }
            
            [_textView resignFirstResponder];
            [_textView becomeFirstResponder];
            
        }
            break;
            
        case 4:
        {
            //弹出和取消弹出“＋”按钮下的界面
            if ([sender.imageView.image isEqual : [UIImage imageNamed:@"message_keyboard_background@2x.png"]])
            {
                
                _textView.inputView = nil;
                
                [sender setImage : [UIImage imageNamed:@"message_add_background@2x.png"]
                        forState : UIControlStateNormal];
                
            }
            
            else
            {
                
                _textView.inputView = _addKeyBoard;
                
                [sender setImage : [UIImage imageNamed:@"message_keyboard_background@2x.png"]
                        forState : UIControlStateNormal];
                
                UIButton * button = (UIButton *)[_button_View viewWithTag:3];
                
                [button setImage : [UIImage imageNamed:@"message_emotion_background@2x.png"]
                        forState : UIControlStateNormal];
                
            }
            
            [_textView resignFirstResponder];
            [_textView becomeFirstResponder];
            
        }
            break;
            
        case 5:
            
            //回收键盘
            [_textView resignFirstResponder];
            _textView.frame = CGRectMake(5, 69, _width-10, _high-208);
            [_button_View removeFromSuperview];
            _button_View = [self getInputAccessoryView];
            
            break;
            
        case 6:
        {
            //选择图片
            UIImagePickerController * pick = [UIImagePickerController new];
            pick.delegate = self;
            
            [self presentViewController:pick
                               animated:YES
                             completion:nil];
            
        }
            break;
            
    }
    
}

#pragma mark 表情键盘表情切换
- (void)change_Selected:(UISegmentedControl *)sender

{
    //更换表情键盘上的表情
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
            break;
            
        case 2:
            name = @"MEmotion";
            break;
            
        case 3:
            name = @"Emotion2";
            break;

    }
    
    UIView * bg_View = [_emotion getSource:name
                            ViewController:self];
    
    _emotion.scroll.contentSize = CGSizeMake(CGRectGetWidth(bg_View.frame), 140);
    
    _emotion.scroll.contentOffset = CGPointMake(0, 0);
    _emotion.pageC.numberOfPages = _emotion.arr_Count;
    [_emotion.scroll addSubview:bg_View];
    
}

#pragma mark 取消图片选择
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
    
}

#pragma mark 图片选择完成
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    _weiboimage = info[UIImagePickerControllerOriginalImage];
    _url = info[UIImagePickerControllerReferenceURL];
    _weiboImage.image = _weiboimage;
    
    //微博配图位置显示自己选择的图片
    UIImageView * imageView = [[UIImageView alloc] initWithImage : [UIImage imageNamed:@"compose_pic_add_highlighted@2x.png"]];
    imageView.frame = CGRectMake(70, 0, 60, 60);
    [_weiboView addSubview:imageView];
    
    [picker dismissViewControllerAnimated:YES
                               completion:nil];
    
}

#pragma mark 选择某个表情
- (void)select_Emotion:(UITapGestureRecognizer *)sender
{
    
    if (_textView.textColor == [UIColor grayColor])
    {
        _textView.textColor = [UIColor blackColor];
    }
    
    if (_textView.text.length == 0)
    {
        
        if ([_picName[sender.view.tag/100][sender.view.tag%100] isEqualToString : [[NSBundle mainBundle] pathForResource:@"compose_emotion_delete_highlighted@2x" ofType:@"png"]])
        {
            _textView.text = nil;
        }
        
        else
        {
            
            NSArray * arr = @[[NSNumber numberWithInteger:_textView.text.length] , [NSNumber numberWithInteger : [ [ [ [ [ [ [_picName[sender.view.tag/100][sender.view.tag%100] componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] objectAtIndex:0] componentsSeparatedByString:@"@"]objectAtIndex:0] length]+2]];
            
            [_rangArray addObject:arr];
            
            _textView.text = [NSString stringWithFormat:@"[%@]",[ [ [ [ [ [_picName[sender.view.tag/100][sender.view.tag%100] componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] objectAtIndex:0] componentsSeparatedByString:@"@"] objectAtIndex:0]];
            
        }
        
    }
    
    else
    {
        
        if ([_picName[sender.view.tag/100][sender.view.tag%100] isEqualToString : [[NSBundle mainBundle] pathForResource:@"compose_emotion_delete_highlighted@2x" ofType:@"png"]])
        {
            
            if (_rangArray.count != 0)
            {
                NSArray * arr = [_rangArray lastObject];
                NSMutableString * str = _textView.text.mutableCopy;
                [str deleteCharactersInRange : NSMakeRange([arr[0] intValue], [arr[1] intValue])];
                _textView.text = str;
                [_rangArray removeLastObject];
            }
            
        }
        
        else
        {
            
            NSArray * arr = @[[NSNumber numberWithInteger:_textView.text.length] , [NSNumber numberWithInteger:[ [ [ [ [ [ [_picName[sender.view.tag/100][sender.view.tag%100] componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] objectAtIndex:0] componentsSeparatedByString:@"@"]objectAtIndex:0] length]+2]];
            
            [_rangArray addObject:arr];
            
            _textView.text = [_textView.text stringByAppendingString : [NSString stringWithFormat:@"[%@]",[ [ [ [ [ [_picName[sender.view.tag/100][sender.view.tag%100] componentsSeparatedByString:@"/"] lastObject] componentsSeparatedByString:@"."] objectAtIndex:0] componentsSeparatedByString:@"@"] objectAtIndex:0]]];
            
        }
        
    }
    
}

#pragma mark 文本内容发生改变
- (void)textViewDidChange:(UITextView *)textView
{
    if (_textView.textColor == [UIColor grayColor])
    {
        _textView.textColor = [UIColor blackColor];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [_button_View removeFromSuperview];
    _textView.inputAccessoryView = _button_View;
    return YES;
}

#pragma mark 开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    [textView becomeFirstResponder];
    
    if ([_textView.text isEqualToString:@"说说分享心得..."] || [_textView.text isEqualToString:@"写评论..."]|| [_textView.text isEqualToString:@"分享新鲜事..."])
    {
        _textView.text = nil;
    }
    _textView.frame = CGRectMake(5, 69, _width-10, _high-418);
}

#pragma mark 返回上一个页面
- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
