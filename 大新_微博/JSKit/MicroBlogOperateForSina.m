#import "MicroBlogOperateForSina.h"

@implementation MicroBlogOperateForSina


/*
 发送一条携带一张图片的微博
 其中:
 access_token ---用户授权码
 content ---文字内容
 pic ---图片地址
 type ---访问权限类型
 */
+ (void)postWordWeiboAndSinglePictureWithAccessToken:(NSString *)access_token
                                             content:(NSString *)content
                                                 pic:(NSURL *)pic
                                             andType:(VisibleType *)type
{
    NSDictionary * d = @{@"access_token":access_token,@"status":content,@"visible":[NSString stringWithFormat:@"%d",(int)type]};
    AFHTTPRequestOperationManager * m = [AFHTTPRequestOperationManager new];
    AFHTTPRequestOperation * op = [m POST:InterfaceForSinaToSendWordAndSinglePic parameters:d constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:pic name:@"pic" error:nil];
    } success:nil failure:nil];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
}


/*
 签到同时上传一张图片
 其中:
 access_token ---用户授权码
 content ---签到内容
 pic ---图片url
 iD ---位置id
 */
+ (void)chekinWithAccessToken:(NSString *)access_token
                      content:(NSString *)content
                       picURL:(NSURL *)pic
                        andId:(NSInteger)iD
{
    NSDictionary * d = @{@"access_token":access_token,@"status":content,@"id":[NSString stringWithFormat:@"%d",iD]};
    AFHTTPRequestOperationManager * m = [AFHTTPRequestOperationManager new];
    AFHTTPRequestOperation * op = [m POST:InterfaceForSinaToChekin parameters:d constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:pic name:@"pic" error:nil];
    } success:nil failure:nil];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
}


/*
 添加照片
 access_token ---用户授权码
 content ---签到内容
 pic ---图片url
 iD ---位置id
 */
+ (void)addPicWithAccessToken:(NSString *)access_token
                      content:(NSString *)content
                       picURL:(NSURL *)pic
                        andId:(NSInteger)iD
{
    NSDictionary * d = @{@"access_token":access_token,@"status":content,@"id":[NSString stringWithFormat:@"%d",iD]};
    AFHTTPRequestOperationManager * m = [AFHTTPRequestOperationManager new];
    AFHTTPRequestOperation * op = [m POST:InterfaceForSinaToAddPic parameters:d constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileURL:pic name:@"pic" error:nil];
    } success:nil failure:nil];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [op start];
}


/*
 关注用户
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (BOOL)followUserWithAccessToken:(NSString *)access_token
                          andName:(NSString *)name
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToFollowUser];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&name=%@",access_token,name];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 添加收藏
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (BOOL)createFavoriteWithAccessToken:(NSString *)access_token
                                andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToCreateFavorite];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&id=%d",access_token,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 删除收藏
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (BOOL)deleteFavoriteWithAccessToken:(NSString *)access_token
                                andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToDeleteFavorite];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&id=%d",access_token,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 更新收藏
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (BOOL)updateFavoriteWithAccessToken:(NSString *)access_token
                                andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToUpdateFavorite];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&id=%d",access_token,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 更新用户收藏下的指定标签
 其中:
 access_token ---用户授权码
 iD ---标签id
 */
+ (BOOL)updateTagAtFavoriteWithAccessToken:(NSString *)access_token
                                     andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToUpdateTagAtFavorite];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&tid=%d",access_token,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 删除用户收藏下的指定标签
 其中:
 access_token ---用户授权码
 iD ---标签ID
 */
+ (BOOL)deleteTagAtFavoriteWithAccessToken:(NSString *)access_token
                                     andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToDeleteTagAtFavorite];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&tid=%d",access_token,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 添加用户标签
 其中:
 access_token ---用户授权码
 tag ---标签
 */
+ (BOOL)createTagWithAccessToken:(NSString *)access_token
                          andTag:(NSArray *)tag
{
    static BOOL isOk = 1;
    NSMutableString * str1;
    for (int i = 0; i < tag.count; i++)
    {
        [str1 appendString:tag[i]];
        if (i != tag.count - 1)
        {
            [str1 appendString:@","];
        }
    }
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToCreateTag];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&tags=%@",access_token,str1];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 删除用户标签
 其中:
 access_token ---用户授权码
 iD ---标签id
 */
+ (BOOL)deleteTagWithAccessToken:(NSString *)access_token
                           andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToDeleteTag];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&tag_id=%d",access_token,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 标记不感兴趣的人
 其中:
 access_token ---用户授权码
 iD ---用户id
 */
+ (BOOL)setUserUninterestedWithAccessToken:(NSString *)access_token
                                     andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToCreateTag];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&uid=%d",access_token,iD];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 添加点评
 access_token ---用户授权码
 content ---签到内容
 iD ---位置id
 */
+ (BOOL)addTipWithAccessToken:(NSString *)access_token
                      content:(NSString *)content
                        andId:(NSInteger)iD
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToAddTip];
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
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 发送一条纯文字微博
 其中:
 access_token ---用户授权码
 content ---发送内容
 type ---访问权限类型
 */
+ (BOOL)postWordWeiboWithAccessToken:(NSString *)access_token
                             content:(NSString *)content
                             andType:(VisibleType *)type
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToSendWord];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&status=%@&visible=%d",access_token,content,(int)type];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 判断地理信息坐标是否是国内坐标
 其中:
 access_token ---用户授权码
 coordinate ---坐标
 */
+ (BOOL)MakeSureGeoIsDomesticWithAccessToken:(NSString *)access_token
                                  coordinate:(NSString *)coordinate
{
    static BOOL isOk = 1;
    NSURL * url = [NSURL URLWithString:InterfaceForSinaToMakeSureGeoIsDomestic];
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc]initWithURL:url];
    NSString * str = [NSString stringWithFormat:@"access_token=%@&coordinate=%@",access_token,coordinate];
    NSData * para = [str dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:para];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue new]  completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError)
        {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Fail to post..." delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
            [alert show];
            isOk = 0;
        }
    }];
    return isOk;
}


/*
 转发一条微博
 其中:
 access_token ---用户授权码
 content ---转发评论信息(可为nil)
 iD ---转发的微博id
 */
+ (BOOL)destroyFollowingWithAcccessToken:(NSString *)access_token
                                      iD:(NSInteger)ID
{
    static BOOL isOK = 1;
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
            isOK = 0;
        }
    }];
    return isOK;
}


/*
 删除微博
 其中:
 access_token ---用户授权码
 ID ---要删除的微博的ID
 */
+ (BOOL)destroyWeiBoWithAcccessToken:(NSString *)access_token
                                  iD:(NSInteger)ID
{
    static BOOL isOK = 1;
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
            isOK = 0;
        }
    }];
    return isOK;
}


/*
 移除关注用户
 其中:
 access_token ---用户授权码
 ID ---需要移除的用户ID
 */
+ (BOOL)logoutMicroBlogWithAccessToken:(NSString *)access_token
{
    static BOOL isOK = 1;
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
        isOK = 0;
    }
    return isOK;
}


/*
 退出登录状态
 其中:
 access_token ---用户授权码
 */
+ (BOOL)reportWeiboWithAccessToken:(NSString *)access_token
                       withContent:(NSString *)content
                             andId:(NSInteger)iD
{
    static BOOL isOK = 1;
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
            isOK = 0;
        }
    }];
    return isOK;
}


/*
 取得用户的详细信息
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (NSDictionary *)getWeiboOfUserWithAccessToken:(NSString *)access_token
                                           name:(NSString *)name
                                        andtype:(WeiboType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@&feature=%d",InterfaceForSinaToGetWeiboOfUser,access_token,name,(int)type]];
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


/*
 获得用户发表的微博
 其中:
 access_token ---用户授权码
 name ---用户名
 type ---微博类型
 */
+ (NSDictionary *)getIdOfWeiboOfUserWithAccessToken:(NSString *)access_token
                                               name:(NSString *)name
                                            andtype:(WeiboType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&screen_name=%@&feature=%d",InterfaceForSinaToGetIdOfWeiboOfUser,access_token,name,(int)type]];
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


/*
 获得用户发表的微博的id
 其中:
 access_token ---用户授权码
 name ---用户名
 type ---微博类型
 */
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


/*
 获得用户关注列表
 其中:
 access_token ---用户授权码
 name ---用户名
 */
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



/*
 获得用户粉丝列表
 其中:
 access_token ---用户授权码
 name ---用户名
 */
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


/*
 获取最新的热门微博
 其中:
 access_token ---用户授权码
 */
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


/*
 获取关注好友的最新微博
 其中:
 access_token ---用户授权码
 type ---微博类型
 */
+ (NSDictionary *)getRecentWeiboOfFriendsWithAccessToken:(NSString *)access_token
                                                 andtype:(WeiboType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&feature=%d",InterfaceForSinaToGetRecentWeiboOfFriends,access_token,(int)type]];
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
 获取当前用户的最新微博
 其中:
 access_token ---用户授权码
 type ---微博类型
 */
+ (NSDictionary *)getRecentWeiboOfSelfWithAccessToken:(NSString *)access_token
                                              andtype:(WeiboType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&feature=%d",InterfaceForSinaToGetRecentWeiboOfSelf,access_token,(int)type]];
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
 获取当前用户与所关注用户的最新微博ID
 其中:
 access_token ---用户授权码
 type ---微博类型
 */
+ (NSDictionary *)getIdOfRecentWeiboWithAccessToken:(NSString *)access_token
                                            andtype:(WeiboType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&feature=%d",InterfaceForSinaToGetIdOfRecentWeibo,access_token,(int)type]];
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
 获取指定微博的转发列表
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
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


/*
 获取指定微博的评论列表
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
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


/*
 获取指定微博的评论和转发数
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
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


/*
 获取指定微博的详细信息
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
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
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&tar_screen_name=%@&source_screen_name=%@",InterfaceForSinaToGetRelationOfUsers,access_token,target_name,source_name]];
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
 获取时区配置表
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


/*
 获取好友位置动态
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getLocationOfFriendWithAccessToken:(NSString *)access_token
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@",InterfaceForSinaToGetLocationOfFriend,access_token]];
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
 获取用户的位置动态
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getLocationOfUserWithAccessToken:(NSString *)access_token
                                             andId:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetLocationOfUser,access_token,uid]];
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
 获取某个位置地点的动态
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getLocationOfPlaceWithAccessToken:(NSString *)access_token
                                              andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&poiid=%d",InterfaceForSinaToGetLocationOfPlace,access_token,iD]];
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
 获取某个位置周边的动态
 其中:
 access_token ---用户授权码
 lat ---纬度
 l_ong ---经度
 */
+ (NSDictionary *)getLocationAroundPlaceWithAccessToken:(NSString *)access_token
                                                 andLat:(float)lat
                                                andLong:(float)l_ong
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&lat=%f&l_ong=%f",InterfaceForSinaToGetLocationAroundPlace,access_token,lat,l_ong]];
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
 根据id获取动态详情
 其中:
 access_token ---用户授权码
 iD ---动态id
 */
+ (NSDictionary *)getDetaileOfLocationWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetDetaileOfLocation,access_token,iD]];
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
 获取lbs位置服务内的用户信息
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getDetaileOfUserOfLBSWithAccessToken:(NSString *)access_token
                                                 andId:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetDetaileOfUserOfLBS,access_token,uid]];
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
 获取用户签发过的地点列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getPlaceListUserGoneWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetPlaceListUserGone,access_token,uid]];
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
 获取用户的照片列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getPicListWithAccessToken:(NSString *)access_token
                                      andId:(NSInteger)uid
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&uid=%d",InterfaceForSinaToGetPicList,access_token,uid]];
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
 获取地点详情
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getDetailOfPlaceWithAccessToken:(NSString *)access_token
                                            andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetDetaileOfPlace,access_token,iD]];
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
 获取在某地点签到的用户列表
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getUserWhoGoneToPlaceWithAccessToken:(NSString *)access_token
                                                 andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetUserWhoGoneToPlace,access_token,iD]];
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
 获取地点照片列表
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getPicListOfPlaceWithAccessToken:(NSString *)access_token
                                             andId:(NSInteger)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&id=%d",InterfaceForSinaToGetPicListOfPlace,access_token,iD]];
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
 按省市查询地点
 其中:
 access_token ---用户授权码
 key ---关键字
 city_code ---城市代码
 category_code ---分类代码
 */
+ (NSDictionary *)getPlaceByProvinceAndCityWithAccessToken:(NSString *)access_token
                                                    andKey:(NSString *)key
                                                   andCity:(NSString *)city_code
                                               andCategory:(NSString *)category_code
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&keyword=%@&city=%@,category=%@",InterfaceForSinaToGetPlaceByProvinceAndCity,access_token,key,city_code,category_code]];
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
 获取地点分类
 其中:
 access_token ---用户授权码
 iD ---父分类id
 */
+ (NSDictionary *)getCategoryOfPlaceWithAccessToken:(NSString *)access_token
                                              andId:(int)iD
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&pid=%d",InterfaceForSinaToGetCategoryOfPlace,access_token,iD]];
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
 获取附近地点
 其中:
 access_token ---用户授权码
 key ---关键词
 category_code ---分类代码
 lat ---纬度
 l_ong ---经度
 */
+ (NSDictionary *)getPlaceNearbyWithAccessToken:(NSString *)access_token
                                         andKey:(NSString *)key
                                    andCategory:(NSString *)category_code
                                         andLat:(float)lat
                                        andLong:(float)l_ong
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&q=%@&category=%@&lat=%f&long=%f",InterfaceForSinaToGetPlaceNearby,access_token,key,category_code,lat,l_ong]];
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
 获取附近发位置微博的人
 其中:
 access_token ---用户授权码
 lat ---纬度
 l_ong ---经度
 */
+ (NSDictionary *)getUserSentLocalWeiboNearbyWithAccessToken:(NSString *)access_token
                                                      andLat:(float)lat
                                                     andLong:(float)l_ong
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&lat=%f&long=%f",InterfaceForSinaToGetUserSentLocalWeiboNearby,access_token,lat,l_ong]];
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
 获取附近照片
 其中:
 access_token ---用户授权码
 lat ---纬度
 l_ong ---经度
 */
+ (NSDictionary *)getPicNearbyWithAccessToken:(NSString *)access_token
                                       andLat:(float)lat
                                      andLong:(float)l_ong
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&lat=%f&long=%f",InterfaceForSinaToGetPicNearby,access_token,lat,l_ong]];
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
 根据ip地址返回地理信息坐标
 其中:
 access_token ---用户授权码
 ip ---ip地址
 */
+ (NSDictionary *)getGeoByIpWithAccessToken:(NSString *)access_token
                                         ip:(NSString *)ip
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&ip=%@",InterfaceForSinaToGetGeoByIp,access_token,ip]];
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
 根据实际地址返回地址信息坐标
 其中:
 access_token ---用户授权码
 address ---地址
 */
+ (NSDictionary *)getGeoByAddressWithAccessToken:(NSString *)access_token
                                         address:(NSString *)address
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&address=%@",InterfaceForSinaToGetGeoByAddress,access_token,address]];
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
 根据地理信息坐标返回实际地址
 其中:
 access_token ---用户授权码
 coordinate ---坐标
 */
+ (NSDictionary *)getGeoByCoordinateWithAccessToken:(NSString *)access_token
                                         coordinate:(NSString *)coordinate
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&coordinate=%@",InterfaceForSinaToGetAddressByGeo,access_token,coordinate]];
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
 根据gps坐标获取偏移后的坐标
 其中:
 access_token ---用户授权码
 coordinate ---坐标
 */
+ (NSDictionary *)getGeoAfterOffsetWithAccessToken:(NSString *)access_token
                                        coordinate:(NSString *)coordinate
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&coordibate=%@",InterfaceForSinaToGetGeoAfterOffsetByGPS,access_token,coordinate]];
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
 根据起点和终点查询自驾车路线信息
 其中:
 access_token ---用户授权码
 begin_pid ---其实位置id
 end_pid ---终点位置id
 type ---优先类型
 */
+ (NSDictionary *)getDriveRoute:(NSString *)access_token
                           from:(NSString *)begin_pid
                             to:(NSString *)end_pid
                       withType:(UnderlyingType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&begin_pid=%@&end_pic=%@&type=%d",InterfaceForSinaToGetDriveRoute,access_token,begin_pid,end_pid,(int)type]];
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
 根据起点和终点查询公交路线信息
 其中:
 access_token ---用户授权码
 begin_pid ---其实位置id
 end_pid ---终点位置id
 type ---优先类型
 */
+ (NSDictionary *)getBusRoute:(NSString *)access_token
                         from:(NSString *)begin_pid
                           to:(NSString *)end_pid
                     withType:(UnderlyingType *)type
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&begin_pid=%@&end_pid=%@type=%d",InterfaceForSinaToGetBusRoute,access_token,begin_pid,end_pid,(int)type]];
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
 根据关键字查询公交线路信息
 其中:
 access_token ---用户授权码
 key ---关键词
 code ---城市代码
 */
+ (NSDictionary *)getBusLineWithAccessToken:(NSString *)access_token
                                     andKey:(NSString *)key
                                    andCity:(NSString *)code
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&q=%@&city=%@",InterfaceForSinaToGetBusLine,access_token,key,code]];
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
 根据关键字查询公交车站信息
 其中:
 access_token ---用户授权码
 key ---关键词
 code ---城市代码
 */
+ (NSDictionary *)getBusStationWithAccessToken:(NSString *)access_token
                                        andKey:(NSString *)key
                                       andCity:(NSString *)code
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&q=%@&city=%@",InterfaceForSinaToGetBusStation,access_token,key,code]];
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
 根据关键词按地址位置获取poi的信息
 其中:
 access_token ---用户授权码
 key ---关键词
 code ---城市代码
 category ---分类代码
 */
+ (NSDictionary *)getPOIByAddressWithAccessToken:(NSString *)access_token
                                          andKey:(NSString *)key
                                         andCity:(NSString *)code
                                     andCategory:(NSString *)category
{
    NSError * error;
    static NSDictionary * dic;
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&q=%@&city=%@&category=%@",InterfaceForSinaToGetPOIByAddress,access_token,key,code,category]];
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
 根据关键词按矩形区域回去poi信息
 其中:
 access_token ---用户授权码
 key ---关键词
 code ---城市代码
 category ---分类代码
 coordinate ---坐标
 */
+ (NSDictionary *)getPOIByRectWithAccessToken:(NSString *)access_token
                                       andKey:(NSString *)key
                                      andCity:(NSString *)code
                                  andCategory:(NSString *)category
                                andCoordinate:(NSArray *)coordinate
{
    NSError * error;
    static NSDictionary * dic;
    NSMutableString * str;
    for (int i = 0; i < coordinate.count; i++)
    {
        [str appendString:coordinate[i]];
        if (i != coordinate.count - 1)
        {
            [str appendString:@"|"];
        }
    }
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?access_token=%@&q=%@&city=%@&category=%@&coordinates=%@",InterfaceForSinaToGetPOIByRect,access_token,key,code,category,str]];
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
