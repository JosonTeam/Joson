#import "MicroBlogOperateForSina.h"

@implementation MicroBlogOperateForSina

+ (void)postWordWeiboWithAccessToken:(NSString *)access_token
                             content:(NSString *)content
{
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToSendWord];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&status=%@",access_token,content];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

+ (void)postWordWeiboAndSinglePictureWithAccessToken:(NSString *)access_token
                                             content:(NSString *)content
                                                 pic:(NSURL *)pic
{
    NSDictionary * d = @{@"access_token":access_token,@"status":content};
    AFHTTPRequestOperationManager * m = [AFHTTPRequestOperationManager new];
    AFHTTPRequestOperation * op = [m POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:d constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:pic name:@"pic" error:nil];
    } success:nil failure:nil];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
}

#warning 以下3大接口有问题
+ (void)destroyFollowingWithAcccessToken:(NSString *)access_token
                                      iD:(NSInteger)ID
{
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToDestroyFollowing];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&uid=%d",access_token,ID];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to excute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

+ (void)destroyWeiBoWithAcccessToken:(NSString *)access_token
                                  iD:(NSInteger)ID
{
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToDestroyWeibo];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&cid=%d",access_token,ID];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to excute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

+ (void)logoutMicroBlogWithAccessToken:(NSString *)access_token
{
    NSError * error;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToLogOut];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@",access_token];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"GET"];
    [request setHTTPBody:para];
    [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
}

+ (void)reportWeiboWithAccessToken:(NSString *)access_token
                       withContent:(NSString *)content
                             andId:(NSInteger)iD
{
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToReportWeibo];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&status=%@&id=%d",access_token,content,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
        }
    }];
    
}

+ (NSDictionary *)getWeiboOfUserWithAccessToken:(NSString *)access_token
                                           name:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@",InterfaceForSinaToGetWeiboOfUser,access_token,name]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getIdOfWeiboOfUserWithAccessToken:(NSString *)access_token
                                           name:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@",InterfaceForSinaToGetIdOfWeiboOfUser,access_token,name]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getDetailOfUserWithAccessToken:(NSString *)access_token
                                            name:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@",InterfaceForSinaToGetDetaileOfUser,access_token,name]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getFollowingWithAccessToken:(NSString *)access_token
                                         name:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@",InterfaceForSinaToGetFollowing,access_token,name]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getFollowerWithAccessToken:(NSString *)access_token
                                        name:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@",InterfaceForSinaToGetFans,access_token,name]];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getRecentHotWeiboWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetRecentHotWeibo,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getRecentWeiboOfFriendsWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetRecentWeiboOfFriends,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getRecentWeiboOfSelfWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetRecentWeiboOfSelf,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getIdOfRecentWeiboWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetIdOfRecentWeibo,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getReportListOfWeiboWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetReportListOfWeibo,access_token,iD]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getAnswerListOfWeiboWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetAnswerListOfWeibo,access_token,iD]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getCountOfAnswerAndReportOfWeiboWithAccessToken:(NSString *)access_token
                                                            andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&ids=%d",InterfaceForSinaToGetCountOfAnswerAndReportOfWeibo,access_token,iD]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}

+ (NSDictionary *)getDetaileOfWeiboWithAccessToken:(NSString *)access_token
                                             andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetDetailOfWeibo,access_token,iD]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}


/*
 获取用户的微博数，关注数，粉丝数
 其中:
 access_token ---用户授权码
 uids ---用户id
 */
+ (NSDictionary *)getCountOfAllWithAccessToken:(NSString *)access_token
                                        andUid:(NSArray *)uids
{
    NSError * error;
    static NSDictionary * dic;
    NSMutableString * iD = [NSMutableString new];
    for (int i = 0; i < uids.count; i++)
    {
        [iD appendString:uids[i]];
        if (i != uids.count - 1)
        {
            [iD appendString:@","];
        }
    }
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uids=%@",InterfaceForSinaToGetCountOfAll,access_token,iD]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取共同关注
 其中:
 access_token ---用户授权码
 suid ---对方用户id
 */
+ (NSDictionary *)getsFollowTogetherWithAccessToken:(NSString *)access_token
                                             andUid:(NSInteger)suid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&suid=%d",InterfaceForSinaToGetFollowTogether,access_token,suid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}


/*
 获取用户互粉列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getFollowEachWithAccessToken:(NSString *)access_token
                                        andUid:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetFollowEach,access_token,uid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户互粉列表id
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getIdOfFollowEachWithAccessToken:(NSString *)access_token
                                            andUid:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetIdOfFollowEach,access_token,uid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户关注列表ID
 其中:
 access_token ---用户授权码
 name ---用户昵称
 */
+ (NSDictionary *)getIdOfFollowingWithAccessToken:(NSString *)access_token
                                          andName:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@",InterfaceForSinaToGetIdOfFollowing,access_token,name]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户粉丝列表ID
 其中:
 access_token ---用户授权码
 name ---用户昵称
 */
+ (NSDictionary *)getIdOfFollowerWithAccessToken:(NSString *)access_token
                                         andName:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@",InterfaceForSinaToGetIdOfFollower,access_token,name]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户的活跃粉丝
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getActiveFollowerWithAccessToken:(NSString *)access_token
                                            andUid:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetActiveFollower,access_token,uid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户关注的人中关注了指定的人的人
 其中:
 access_token ---用户授权码
 uid ---指定用户id
 */
+ (NSDictionary *)getFollowingWhoFollowThePersonWithAccessToken:(NSString *)access_token
                                                         andUid:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetFollowingWhoFollowThePerson,access_token,uid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取两个用户之间的关系
 其中:
 access_token ---用户授权码
 target_name ---对方用户名
 source_name ---源用户名
 */
+ (NSDictionary *)getRelationOfUsersWithAccessToken:(NSString *)access_token
                                            between:(NSString *)source_name
                                                and:(NSString *)target_name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&tar_screen_name=%@&source_screen_name",InterfaceForSinaToGetRelationOfUsers,access_token,target_name,source_name]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户的隐私设置
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getPrivateMessageOfUserWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetPrivateMessageOfUser,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取学校列表
 其中:
 access_token ---用户授权码
 type ---学校类型
 key_Word ---关键字
 */
+ (NSDictionary *)getSchoolListWithAccessToken:(NSString *)access_token
                                          type:(SchoolType *)type
                                    andKeyword:(NSString *)key_Word
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&type=%d&keyword=%@",InterfaceForSinaToGetSchoolList,access_token,(int)type,key_Word]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}


/*
 获取用户的访问频率限制
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getLimitOfUserWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetLimitOfUser,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户的ID
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getIdWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetUid,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户的收藏列表
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getFavoriteOfUserWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetFavorite,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户的收藏列表ID
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getIdOfFavoriteOfUserWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetIdOfFavorite,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户收藏的详细信息
 其中:
 access_token ---用户授权码
 iD ---要查询的收藏id
 */
+ (NSDictionary *)getDetaileOfFavoriteWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetDetaileOfFavorite,access_token,iD]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}

/*
 获取用户某标签下的收藏列表
 其中:
 access_token ---用户授权码
 tid ---标签id
 */
+ (NSDictionary *)getFavoriteListByTagWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)tid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&tid=%d",InterfaceForSinaToGetFavoriteOfTag,access_token,tid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户的标签列表
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getListOfFavoriteTagWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetListOfFavoriteTag,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户某标签下的收藏Id
 其中:
 access_token ---用户授权码
 tid ---标签id
 */
+ (NSDictionary *)getIdOfFavoriteOfTagWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)tid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&tid=%d",InterfaceForSinaToGetIdOfFavoriteOfTag,access_token,tid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取一小时内的热门话题
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotTopicOfHourWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetHotTopicOfHour,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取一天内的热门话题
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotTopicOfDayWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetHotTopicOfDay,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取一周内的热门话题
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotTopicOfWeekWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetHotTopicOfWeek,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户的标签列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getTagOfUserWithAccessToken:(NSString *)access_token
                                        andId:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetTagOfUser,access_token,uid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取系统推荐标签
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getSuggestionOfTagWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetSuggestionOfTag,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 判断昵称是否被用
 其中:
 access_token ---用户授权码
 name ---昵称
 */
+ (NSDictionary *)getNickNameVisibelWithAccessToken:(NSString *)access_token
                                            andName:(NSString *)name
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&nick_name=%@",InterfaceForSinaToMakeSureOfNickName,access_token,name]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取搜用户搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getSuggestionOfUserWithAccessToken:(NSString *)access_token
                                              andKey:(NSString *)key
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&q=%@",InterfaceForSinaToGetSuggestionOfUser,access_token,key]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取搜学校搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 typ ---学校类型
 */
+ (NSDictionary *)getSuggestionOfSchoolWithAccessToken:(NSString *)access_token
                                                 andKey:(NSString *)key
                                               withType:(SchoolType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@q=%@&type=%d",InterfaceForSinaToGetSuggestionOfSchool,access_token,key,(int)type]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取搜公司搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getSuggestionOfCompanyWithAccessToken:(NSString *)access_token
                                                 andKey:(NSString *)key
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&key=%@",InterfaceForSinaToGetSuggestionOfCompany,access_token,key]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取搜应用搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getSuggestionOfAppWithAccessToken:(NSString *)access_token
                                             andKey:(NSString *)key
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&key=%@",InterfaceForSinaToGetSuggestionOfApp,access_token,key]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取@用户搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 type ---用户类型(关注，粉丝)
 */
+ (NSDictionary *)getSuggestionOfMentionWithAccessToken:(NSString *)access_token
                                                 andKey:(NSString *)key
                                                 andTpe:(UserType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&key=%@&type=%d",InterfaceForSinaToGetSuggestionOfPeople,access_token,key,(int)type]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取某话题下的微博
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getWeiboOfTopicWithAccessToken:(NSString *)access_token
                                          andKey:(NSString *)key
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&key=%@",InterfaceForSinaToGetWeiboOfTopic,access_token,key]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取系统推荐用户
 其中:
 access_token ---用户授权码
 category ---用户类型
 */
+ (NSDictionary *)getSuggestedUserWithAccessToken:(NSString *)access_token
                                      andCategory:(UserCategory *)category
{
    NSArray * userCategory = @[@"Default",@"Ent",@"Music",@"Sport",@"Fashion",@"Art",@"Cartoon",@"Games",@"UTrip",@"Food",@"Health",@"Literature",@"Slock",@"Business",@"Tech",@"House",@"Auto",@"Fate",@"Govern",@"Medium",@"Marketer"];
    NSError * error;
    static NSDictionary * dic;
    NSString * str = userCategory[(int)category];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&category=%@",InterfaceForSinaToGetSuggestedUser,access_token,str]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取可能感兴趣用户
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getSuggestedUserByMayInterestedWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetSuggestedUserByMayInterested,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取微博内容相关用户
 其中:
 access_token ---用户授权码
 content ---微博内容
 */
+ (NSDictionary *)getSuggestedUserByContentOfWeiboWithAccessToken:(NSString *)access_token
                                                       andContent:(NSString *)content
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&content=%@",InterfaceForSinaToGetSuggestedUserByContentOfWeibo,access_token,content]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取按兴趣排序后的微博
 其中:
 access_token ---用户授权码
 time ---据当前时间n秒之内
 */
+ (NSDictionary *)getWeiboSortByInterestWithAccessToken:(NSString *)access_token
                                                andTime:(int)time
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&section=%d",InterfaceForSinaToSortByInterested,access_token,time]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;
}


/*
 获取按兴趣排序后的微博的ID
 其中:
 access_token ---用户授权码
 time ---据当前时间n秒之内
 */
+ (NSDictionary *)getIdOfWeiboSortByInterestWithAccessToken:(NSString *)access_token
                                                    andTime:(int)time
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&section=%d",InterfaceForSinaToGetIdOfWeiboSortByInterested,access_token,time]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取热门收藏
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotFavoriteWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetHotFavorite,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取用户各种消息未读数
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getUnreadCountOfAllWithAccessToken:(NSString *)access_token
                                              andUid:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetUnreadCountOfAll,access_token,uid]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取城市列表
 其中:
 access_token ---用户授权码
 province ---省份
 capital ---名字首字母，可为nil
 */
+ (NSDictionary *)getCityWithAccessToken:(NSString *)access_token
                             andProvince:(NSString *)province
                              andCapital:(NSString *)capital
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&province=%@&capital=%@",InterfaceForSinaToGetCity,access_token,province,capital]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取省份列表
 其中:
 access_token ---用户授权码
 country ---国家
 capital ---名字首字母，可为nil
 */
+ (NSDictionary *)getProvinceWithAccessToken:(NSString *)access_token
                                 andCountry:(NSString *)country
                                 andCapital:(NSString *)capital
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&country=%@&capital=%@",InterfaceForSinaToGetProvince,access_token,country,capital]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取国家列表
 其中:
 access_token ---用户授权码
 capital ---名字首字母，可为nil
 */
+ (NSDictionary *)getCountryWithAccessToken:(NSString *)access_token
                                 andCapital:(NSString *)capital
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&capital=%@",InterfaceForSinaToGetCountry,access_token,capital]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}


/*
 获取市区配置表
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getTimeZoneWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetTimeZone,access_token]];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to exute..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    }
    return dic;

}

@end
