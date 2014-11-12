#import "GetDataOfLocalFile.h"

@implementation GetDataOfLocalFile


#pragma mark 获取沙盒的txt文件
/*
 其中:
 name ---文件名
 */
+ (NSString *)getContentOfTxtFileAtBundleForFileName:(NSString *)name
{
    
    NSError * error;
    
    NSString * path = [[NSBundle mainBundle] pathForResource:name
                                                      ofType:@"txt"];
    
    NSString * content = [NSString stringWithContentsOfURL : [NSURL fileURLWithPath:path]
                                                   encoding:NSUTF8StringEncoding
                                                     error:&error];
    
    if (error)
    {
        
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                        message:@"Faile to get"
                                                       delegate:nil
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:nil];
        
        [alert show];
        
    }
    
    return content;
}


#pragma mark 获取沙盒文件夹的txt文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSString *)getContentOfTxtFileAtParh:(NSSearchPathDirectory)filePath
                            ForFileName:(NSString *)name
{
    
    NSError *  error;
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.txt",str,name];
    
    NSString * content = [NSString stringWithContentsOfURL : [NSURL fileURLWithPath:path]
                                                   encoding:NSUTF8StringEncoding
                                                      error:&error];
    
    if (error)
    {
        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
//                                                        message:@"Faile to get"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Cancel"
//                                              otherButtonTitles:nil];
//        
//        [alert show];
        
    }
    
    return content;
}


#pragma mark 获取沙盒的plist文件
/*
 其中:
 name ---文件名
 */
+ (NSArray *)getContentOfPlistFileAtBundleForFileName:(NSString *)name
{
    NSString * path = [[NSBundle mainBundle] pathForResource:name
                                                      ofType:@"plist"];
    
    NSArray * content = [NSArray arrayWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    return content;
}


#pragma mark 获取沙盒文件夹的plist文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSArray *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                             ForFileName:(NSString *)name
{
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.plist",str , name];
    NSArray * content = [NSArray arrayWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    return content;
}


#pragma mark 获取沙盒的plist文件
/*
 其中:
 name ---文件名
 */
+ (NSDictionary *)getContentOfPlistFileAtBundleWithFileName:(NSString *)name
{
    NSString * path = [[NSBundle mainBundle] pathForResource:name
                                                      ofType:@"plist"];
    
    NSDictionary * content = [NSDictionary dictionaryWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    return content;
}


#pragma mark 获取沙盒文件夹的plist文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSDictionary *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                                 WithFileName:(NSString *)name
{
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.plist",str,name];
    NSDictionary * content = [NSDictionary dictionaryWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    return content;
}


#pragma mark 获取沙盒的json文件
/*
 其中:
 name ---文件名
 */
+ (NSDictionary *)getContentOfJsonFileAtBundleWithFileName:(NSString *)name
{
    NSError * error;
    
    NSString * path = [[NSBundle mainBundle] pathForResource:name
                                                      ofType:@"json"];
    
    NSData * data = [NSData dataWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    NSDictionary * content = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&error];
    
    if (error)
    {
        
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                         message:@"Faile to get"
                                                        delegate:nil
                                               cancelButtonTitle:@"Cancel"
                                               otherButtonTitles:nil];
        [alert show];
        
    }
    
    return content;
}


#pragma mark 获取沙盒文件夹的json文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSDictionary *)getContentOfJsonFileAtParh:(NSSearchPathDirectory)filePath
                                WithFileName:(NSString *)name
{
    NSError *  error;
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.json",str,name];
    NSData * data = [NSData dataWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    NSDictionary * content = [NSJSONSerialization JSONObjectWithData:data
                                                             options:NSJSONReadingAllowFragments
                                                               error:&error];
    
    if (error)
    {
        
//        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error"
//                                                        message:@"Faile to get"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"Cancel"
//                                              otherButtonTitles:nil];
//        
//        [alert show];
        
    }
    
    return content;
}


#pragma mark 获取沙盒的图片文件
/*
 其中:
 name ---文件名
 type ---文件类型
 */
+ (NSData *)getContentOfPictureAtBundleWithFileName:(NSString *)name
                                            andType:(NSString *)type
{
    NSString * path = [[NSBundle mainBundle] pathForResource:name
                                                      ofType:type];
    
    NSData * content = [NSData dataWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    return content;
}


#pragma mark 获取沙盒文件夹的图片文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 type ---文件类型
 */
+ (NSData *)getContentOfPictureAtParh:(NSSearchPathDirectory)filePath
                         WithFileName:(NSString *)name
                              andType:(NSString *)type
{
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES) objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.%@",str,name,type];
    NSData * content = [NSData dataWithContentsOfURL : [NSURL fileURLWithPath:path]];
    
    return content;
}


@end
