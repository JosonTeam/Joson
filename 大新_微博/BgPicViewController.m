//
//  BgPicViewController.m
//  大新_微博
//
//  Created by YF01-D05 on 14-11-11.
//  Copyright (c) 2014年 joson. All rights reserved.
//

#import "BgPicViewController.h"
#import "MyView.h"
#import "PhotoTableView.h"
@interface BgPicViewController ()

@end

@implementation BgPicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton * backBtn = (UIButton *)self.navigationItem.leftBarButtonItem.customView;
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * moreBtn = (UIButton *)self.navigationItem.rightBarButtonItem.customView;
    [moreBtn addTarget:self action:@selector(clickdian) forControlEvents:UIControlEventTouchUpInside];
    int x = 15,y = 90,k = 0;
    NSArray * arrPic = [[NSArray alloc]initWithObjects:@"bg0.jpg",@"bg1.jpg",@"bg2.jpg",@"bg3.jpg",@"bg4.jpg",@"bg5.jpg",@"bg6.jpg",@"bg7.jpg",@"bg8.jpg", nil];
    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < 3; j++)
        {
            UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(x + j * 100, y, 90, 130)];
            img.image = [UIImage imageNamed:arrPic[k++]];
            img.tag = k;
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage:)];
            tap.numberOfTapsRequired = 1;
            img.userInteractionEnabled = YES;
            [img addGestureRecognizer:tap];
            
            [self.view addSubview:img];
        }
        x = 15;
        y += 140;
    }
    
    
       
}

-(void)clickImage:(UITapGestureRecognizer *)sender
{
    NSDictionary * dic = @{@"tag": [NSNumber numberWithInt:sender.view.tag]};
    [[NSNotificationCenter defaultCenter]postNotificationName:@"passvalue" object:self userInfo:dic];
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)clickdian
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"照相机",@"从相册选一张", nil];
    actionSheet.delegate = self;
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    NSLog(@"**********");
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex)
    {
        case 0:
        {
            NSLog(@"index = %d",buttonIndex);
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            {
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.delegate = self;
                //设置拍照后的图片可被编辑
                picker.allowsEditing = YES;
                picker.sourceType = sourceType;
                [self presentViewController:picker animated:YES completion:nil];
            }
            else
            {
                NSLog(@"模拟其中无法打开照相机,请在真机中使用");
            }
        }
            break;
        case 1:
        {
            NSLog(@"index = %d",buttonIndex);
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            //设置选择后的图片可被编辑
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
            
            
        }
            break;
        default:
            break;
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString * type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"])
    {
        UIImage * phototImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        NSData * data;
        if (UIImagePNGRepresentation(phototImage))
        {
            data = UIImageJPEGRepresentation(phototImage, 1.0);
        }
        else
        {
            data = UIImagePNGRepresentation(phototImage);
        }
        
        NSString * documentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSFileManager * filemanager = [NSFileManager defaultManager];
        
        [filemanager createDirectoryAtPath:documentsPath withIntermediateDirectories:YES attributes:nil error:nil];
        [filemanager createFileAtPath:[documentsPath stringByAppendingString:@"/image.png"] contents:data attributes:nil];
        
        NSString * filePath = [[NSString alloc]initWithFormat:@"%@%@",documentsPath,  @"/image.png"];
        
        NSLog(@"filePath = %@",filePath);
        [picker dismissViewControllerAnimated:YES completion:nil];
        
        NSDictionary * dic = @{@"image": phototImage};
        [[NSNotificationCenter defaultCenter]postNotificationName:@"passvalue" object:self userInfo:dic];
        
    }
}





//返回键,返回上一个页面
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}









/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
