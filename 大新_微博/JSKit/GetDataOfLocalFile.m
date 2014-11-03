#import "GetDataOfLocalFile.h"

@implementation GetDataOfLocalFile

+ (NSString *)getContentOfTxtFileAtBundleForFileName:(NSString *)name
{
    NSError * error;
    NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:@"txt"];
    NSString * content = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Faile to get" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    return content;
}

+ (NSString *)getContentOfTxtFileAtParh:(NSSearchPathDirectory)filePath
                            ForFileName:(NSString *)name
{
    NSError *  error;
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.txt",str,name];
    NSString * content = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:path] encoding:NSUTF8StringEncoding error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Faile to get" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    return content;
}

+ (NSArray *)getContentOfPlistFileAtBundleForFileName:(NSString *)name
{
    NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:@"plist"];
    NSArray * content = [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:path]];
    return content;
}

+ (NSArray *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                             ForFileName:(NSString *)name
{
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.plist",str,name];
    NSArray * content = [NSArray arrayWithContentsOfURL:[NSURL fileURLWithPath:path]];
    return content;
}

+ (NSDictionary *)getContentOfPlistFileAtBundleWithFileName:(NSString *)name
{
    NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:@"plist"];
    NSDictionary * content = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:path]];
    return content;
}

+ (NSDictionary *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                                 WithFileName:(NSString *)name
{
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.plist",str,name];
    NSDictionary * content = [NSDictionary dictionaryWithContentsOfURL:[NSURL fileURLWithPath:path]];
    return content;
}

+ (NSDictionary *)getContentOfJsonFileAtBundleWithFileName:(NSString *)name
{
    NSError * error;
    NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:@"json"];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    NSDictionary * content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Faile to get" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    return content;
}

+ (NSDictionary *)getContentOfJsonFileAtParh:(NSSearchPathDirectory)filePath
                                WithFileName:(NSString *)name
{
    NSError *  error;
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.json",str,name];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    NSDictionary * content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Faile to get" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    return content;
}

+ (NSData *)getContentOfPictureAtBundleWithFileName:(NSString *)name
                                            andType:(NSString *)type
{
    NSString * path = [[NSBundle mainBundle]pathForResource:name ofType:type];
    NSData * content = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    return content;
}

+ (NSData *)getContentOfPictureAtParh:(NSSearchPathDirectory)filePath
                         WithFileName:(NSString *)name
                              andType:(NSString *)type
{
    NSString * str = [NSSearchPathForDirectoriesInDomains(filePath, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * path = [NSString stringWithFormat:@"%@/%@.%@",str,name,type];
    NSData * content = [NSData dataWithContentsOfURL:[NSURL fileURLWithPath:path]];
    return content;
}

@end
