#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "InterFaceForSina.h"


/*
 All: 所有
 UniverCity: 大学
 HighSchool: 高中
 SecondaryTechnicalSchool: 中专技校
 JuniorMiddleSchool: 初中
 PrimarySchool: 小学
 */
typedef NS_ENUM(NSInteger, SchoolType)
{
    SchoolTypeUniverCity,
    SchoolTypeHighSchool,
    SchoolTypeSecondaryTechnicalSchool,
    SchoolTypeJuniorMiddleSchool,
    SchoolTypePrimarySchool
};


/*
 Following: 关注
 Fans: 粉丝
 */
typedef NS_ENUM(NSInteger, UserType)
{
    UserTypeFollowing,
    UserTypeFans
};


/*
 default：人气关注
 ent：影视名星
 music：音乐
 sports：体育
 fashion：时尚
 art：艺术
 cartoon：动漫
 games：游戏
 trip：旅行
 food：美食
 health：健康
 literature：文学
 stock：炒股
 business：商界
 tech：科技
 house：房产
 auto：汽车
 fate：命理
 govern：政府
 medium：媒体
 marketer：营销专家
 */
typedef NS_ENUM(NSInteger, UserCategory)
{
    UserCategoryDefault,
    UserCategoryEnt,
    UserCategoryMusic,
    UserCategorySport,
    UserCategoryFashion,
    UserCategoryArt,
    UserCategoryCartoon,
    UserCategoryGames,
    UserCategoryTrip,
    UserCategoryFood,
    UserCategoryHealth,
    UserCategoryLiterature,
    UserCategorySlock,
    UserCategoryBusiness,
    UserCategoryTech,
    UserCategoryHouse,
    UserCategoryAuto,
    UserCategoryFate,
    UserCategoryGovern,
    UserCategoryMedium,
    UserCategoryMarketer
};


/*
 All: 全部
 Self: 原创
 Pic: 图片
 Movie: 视频
 Music: 音乐
 */
typedef NS_ENUM(NSInteger, WeiboType)
{
    WeiboTypeAll,
    WeiboTypeSelf,
    WeiboTypePic,
    WeiboTypeMovie,
    WeiboTypeMusic,
};


/*
 All: 所有人
 Self: 自己
 Friend: 密友
 Group: 指定分组
 */
typedef NS_ENUM(NSInteger, VisibleType)
{
    VisibleTypeAll,
    VisibleTypeSelf,
    VisibleTypeFriend,
    VisibleTypeGroup
};


/*
 Following: 关注
 Fans: 粉丝
 */
typedef NS_ENUM(NSInteger, UnderlyingType)
{
    UnderlyingTypeSpeed,
    UnderlyingTypeCost,
    UnderlyingTypeDistance
};


@interface MicroBlogOperateForSina : NSObject




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
                                             andType:(VisibleType *)type;


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
                        andId:(NSInteger)iD;


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
                        andId:(NSInteger)iD;


/*
 判断地理信息坐标是否是国内坐标
 其中:
 access_token ---用户授权码
 coordinate ---坐标
 */
+ (BOOL)MakeSureGeoIsDomesticWithAccessToken:(NSString *)access_token
                                  coordinate:(NSString *)coordinate;


/*
 添加点评
 access_token ---用户授权码
 content ---签到内容
 iD ---位置id
 */
+ (BOOL)addTipWithAccessToken:(NSString *)access_token
                      content:(NSString *)content
                        andId:(NSInteger)iD;



/*
 发送一条纯文字微博
 其中:
 access_token ---用户授权码
 content ---发送内容
 type ---访问权限类型
 */
+ (BOOL)postWordWeiboWithAccessToken:(NSString *)access_token
                             content:(NSString *)content
                             andType:(VisibleType *)type;


/*
 转发一条微博
 其中:
 access_token ---用户授权码
 content ---转发评论信息(可为nil)
 iD ---转发的微博id
 */
+ (BOOL)reportWeiboWithAccessToken:(NSString *)access_token
                       withContent:(NSString *)content
                             andId:(NSInteger)iD;


/*
 删除微博
 其中:
 access_token ---用户授权码
 ID ---要删除的微博的ID
 */
+ (BOOL)destroyWeiBoWithAcccessToken:(NSString *)access_token
                                  iD:(NSInteger)ID;


/*
 移除关注用户
 其中:
 access_token ---用户授权码
 ID ---需要移除的用户ID
 */
+ (BOOL)destroyFollowingWithAcccessToken:(NSString *)access_token
                                      iD:(NSInteger)ID;


/*
 退出登录状态
 其中:
 access_token ---用户授权码
 */
+ (BOOL)logoutMicroBlogWithAccessToken:(NSString *)access_token;


/*
 关注用户
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (BOOL)followUserWithAccessToken:(NSString *)access_token
                          andName:(NSString *)name;


/*
 添加收藏
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (BOOL)createFavoriteWithAccessToken:(NSString *)access_token
                                andId:(NSInteger)iD;


/*
 删除收藏
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (BOOL)deleteFavoriteWithAccessToken:(NSString *)access_token
                                andId:(NSInteger)iD;


/*
 更新收藏
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (BOOL)updateFavoriteWithAccessToken:(NSString *)access_token
                                andId:(NSInteger)iD;


/*
 更新用户收藏下的指定标签
 其中:
 access_token ---用户授权码
 iD ---标签id
 */
+ (BOOL)updateTagAtFavoriteWithAccessToken:(NSString *)access_token
                                     andId:(NSInteger)iD;


/*
 删除用户收藏下的指定标签
 其中:
 access_token ---用户授权码
 iD ---标签ID
 */
+ (BOOL)deleteTagAtFavoriteWithAccessToken:(NSString *)access_token
                                     andId:(NSInteger)iD;


/*
 添加用户标签
 其中:
 access_token ---用户授权码
 tag ---标签
 */
+ (BOOL)createTagWithAccessToken:(NSString *)access_token
                          andTag:(NSArray *)tag;


/*
 删除用户标签
 其中:
 access_token ---用户授权码
 iD ---标签id
 */
+ (BOOL)deleteTagWithAccessToken:(NSString *)access_token
                           andId:(NSInteger)iD;


/*
 标记不感兴趣的人
 其中:
 access_token ---用户授权码
 iD ---用户id
 */
+ (BOOL)setUserUninterestedWithAccessToken:(NSString *)access_token
                                     andId:(NSInteger)iD;


/*
 评论微博
 其中:
 access_token ---用户授权码
 content ---评论内容
 iD ---微博id
 */
+ (BOOL)CommentWeiboWithAccessToken:(NSString *)access_token
                             content:(NSString *)content
                               andId:(NSInteger)iD;


/*
 删除评论
 其中:
 access_token ---用户授权码
 cid ---评论id
 */
+ (BOOL)DeleteCommentWithAccessToken:(NSString *)access_token
                              andCid:(NSInteger)cid;


/*
 根据id删除评论
 其中:
 access_token ---用户授权码
 cids ---评论id
 */
+ (BOOL)DestroyCommentsWithAccessToken:(NSString *)access_token
                                andCid:(NSArray *)cids;


/*
 回复评论
 其中:
 access_token ---用户授权码
 iD ---微博id
 content ---评论内容
 cid ---评论id
 */
+ (BOOL)ReplyCommentWithAccessToken:(NSString *)access_token
                               andId:(NSInteger)iD
                          andContent:(NSString *)content
                              andCid:(NSInteger)cid;


/*
 获取系统推荐用户
 其中:
 access_token ---用户授权码
 category ---用户类型
 */
+ (NSArray *)getSuggestedUserWithAccessToken:(NSString *)access_token
                                 andCategory:(UserCategory *)category;



/*
 取得用户的详细信息
 其中:
 access_token ---用户授权码
 name ---用户名
 uid ---用户ID
 */
+ (NSDictionary *)getDetailOfUserWithAccessToken:(NSString *)access_token
                                            name:(NSString *)name
                                            orId:(NSInteger)uid;


/*
 获得用户发表的微博
 其中:
 access_token ---用户授权码
 name ---用户名
 type ---微博类型
 */
+ (NSDictionary *)getWeiboOfUserWithAccessToken:(NSString *)access_token
                                           name:(NSString *)name
                                        andtype:(WeiboType *)type;

/*
 获得用户发表的微博的id
 其中:
 access_token ---用户授权码
 name ---用户名
 type ---微博类型
 */
+ (NSDictionary *)getIdOfWeiboOfUserWithAccessToken:(NSString *)access_token
                                               name:(NSString *)name
                                            andtype:(WeiboType *)type;


/*
 获得用户关注列表
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (NSDictionary *)getFollowingWithAccessToken:(NSString *)access_token
                                         name:(NSString *)name;

/*
 获取我发出的评论
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getCommentsByMeWithAccessToken:(NSString *)access_token;


/*
 获取评论我
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getCommentsToMeWithAccessToken:(NSString *)access_token;


/*
 获取最新评论
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getRecentNewCommentsWithAccessToken:(NSString *)access_token;


/*
 获取@我评论
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getMentionsCommentWithAccessToken:(NSString *)access_token;


/*
 获取评论的详细信息
 其中:
 access_token ---用户授权码
 cids ---评论id
 */
+ (NSDictionary *)getDetaileOfCommentWithAccessToken:(NSString *)access_token
                                              andIds:(NSArray *)cids;


/*
 获得用户粉丝列表
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (NSDictionary*)getFollowerWithAccessToken:(NSString *)access_token
                                       name:(NSString *)name;


/*
 获取最新的热门微博
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getRecentHotWeiboWithAccessToken:(NSString *)access_token;


/*
 获取关注好友的最新微博
 其中:
 access_token ---用户授权码
 type ---微博类型
 */
+ (NSDictionary *)getRecentWeiboOfFriendsWithAccessToken:(NSString *)access_token
                                                 andtype:(WeiboType *)type;


/*
 获取当前用户的最新微博
 其中:
 access_token ---用户授权码
 type ---微博类型
 */
+ (NSDictionary *)getRecentWeiboOfUserWithAccessToken:(NSString *)access_token
                                              andtype:(WeiboType *)type;


/*
 获取当前用户与所关注用户的最新微博ID
 其中:
 access_token ---用户授权码
 type ---微博类型
 */
+ (NSDictionary *)getIdOfRecentWeiboWithAccessToken:(NSString *)access_token
                                            andtype:(WeiboType *)type;


/*
 获取指定微博的转发列表
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (NSDictionary *)getReportListOfWeiboWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)iD;


/*
 获取指定微博的评论列表
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (NSDictionary *)getAnswerListOfWeiboWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)iD;


/*
 获取指定微博的评论和转发数
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (NSDictionary *)getCountOfAnswerAndReportOfWeiboWithAccessToken:(NSString *)access_token
                                                            andId:(NSInteger)iD;


/*
 获取指定微博的详细信息
 其中:
 access_token ---用户授权码
 iD ---微博id
 */
+ (NSDictionary *)getDetaileOfWeiboWithAccessToken:(NSString *)access_token
                                             andId:(NSInteger)iD;


/*
 获取用户的微博数，关注数，粉丝数
 其中:
 access_token ---用户授权码
 uids ---用户id
 */
+ (NSDictionary *)getCountOfAllWithAccessToken:(NSString *)access_token
                                         andUid:(NSArray *)uids;


/*
 获取共同关注
 其中:
 access_token ---用户授权码
 suid ---对方用户id
 */
+ (NSDictionary *)getsFollowTogetherWithAccessToken:(NSString *)access_token
                                             andUid:(NSInteger)suid;


/*
 获取用户互粉列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getFollowEachWithAccessToken:(NSString *)access_token
                                        andUid:(NSInteger)uid;


/*
 获取用户互粉列表id
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getIdOfFollowEachWithAccessToken:(NSString *)access_token
                                            andUid:(NSInteger)uid;


/*
 获取用户关注列表ID
 其中:
 access_token ---用户授权码
 name ---用户昵称
 */
+ (NSDictionary *)getIdOfFollowingWithAccessToken:(NSString *)access_token
                                          andName:(NSString *)name;


/*
 获取用户粉丝列表ID
 其中:
 access_token ---用户授权码
 name ---用户昵称
 */
+ (NSDictionary *)getIdOfFollowerWithAccessToken:(NSString *)access_token
                                          andName:(NSString *)name;


/*
 获取用户的活跃粉丝
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getActiveFollowerWithAccessToken:(NSString *)access_token
                                            andUid:(NSInteger)uid;


/*
 获取用户关注的人中关注了指定的人的人
 其中:
 access_token ---用户授权码
 uid ---指定用户id
 */
+ (NSDictionary *)getFollowingWhoFollowThePersonWithAccessToken:(NSString *)access_token
                                                         andUid:(NSInteger)uid;

/*
 获取两个用户之间的关系
 其中:
 access_token ---用户授权码
 target_name ---对方用户名
 source_name ---源用户名
 */
+ (NSDictionary *)getRelationOfUsersWithAccessToken:(NSString *)access_token
                                            between:(NSString *)source_name
                                                and:(NSString *)target_name;

/*
 获取用户的隐私设置
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getPrivateMessageOfUserWithAccessToken:(NSString *)access_token;


/*
 获取学校列表
 其中:
 access_token ---用户授权码
 type ---学校类型
 key_Word ---关键字
 */
+ (NSDictionary *)getSchoolListWithAccessToken:(NSString *)access_token
                                          type:(SchoolType *)type
                                    andKeyword:(NSString *)key_Word;


/*
 获取用户的访问频率限制
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getLimitOfUserWithAccessToken:(NSString *)access_token;


/*
 获取用户的ID
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getIdWithAccessToken:(NSString *)access_token;


/*
 获取用户的收藏列表
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getFavoriteOfUserWithAccessToken:(NSString *)access_token;

/*
 获取用户的收藏列表ID
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getIdOfFavoriteOfUserWithAccessToken:(NSString *)access_token;


/*
 获取用户收藏的详细信息
 其中:
 access_token ---用户授权码
 iD ---要查询的收藏id
 */
+ (NSDictionary *)getDetaileOfFavoriteWithAccessToken:(NSString *)access_token
                                                 andId:(NSInteger)iD;

/*
 获取用户某标签下的收藏列表
 其中:
 access_token ---用户授权码
 tid ---标签id
 */
+ (NSDictionary *)getFavoriteListByTagWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)tid;


/*
 获取用户的标签列表
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getListOfFavoriteTagWithAccessToken:(NSString *)access_token;


/*
 获取用户某标签下的收藏Id
 其中:
 access_token ---用户授权码
 tid ---标签id
 */
+ (NSDictionary *)getIdOfFavoriteOfTagWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)tid;


/*
 获取一小时内的热门话题
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotTopicOfHourWithAccessToken:(NSString *)access_token;


/*
 获取一天内的热门话题
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotTopicOfDayWithAccessToken:(NSString *)access_token;


/*
 获取一周内的热门话题
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotTopicOfWeekWithAccessToken:(NSString *)access_token;


/*
 获取用户的标签列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getTagOfUserWithAccessToken:(NSString *)access_token
                                        andId:(NSInteger)uid;


/*
 获取系统推荐标签
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getSuggestionOfTagWithAccessToken:(NSString *)access_token;


/*
 判断昵称是否被用
 其中:
 access_token ---用户授权码
 name ---昵称
 */
+ (NSDictionary *)getNickNameVisibelWithAccessToken:(NSString *)access_token
                                            andName:(NSString *)name;


/*
 获取搜用户搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getSuggestionOfUserWithAccessToken:(NSString *)access_token
                                              andKey:(NSString *)key;


/*
 获取搜学校搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 typ ---学校类型
 */
+ (NSDictionary *)getSuggestionOfSchoolWithAccessToken:(NSString *)access_token
                                                 andKey:(NSString *)key
                                               withType:(SchoolType *)type;


/*
 获取搜公司搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getSuggestionOfCompanyWithAccessToken:(NSString *)access_token
                                                 andKey:(NSString *)key;


/*
 获取搜应用搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getSuggestionOfAppWithAccessToken:(NSString *)access_token
                                             andKey:(NSString *)key;


/*
 获取@用户搜索建议
 其中:
 access_token ---用户授权码
 key ---关键字
 type ---用户类型(关注，粉丝)
 */
+ (NSDictionary *)getSuggestionOfMentionWithAccessToken:(NSString *)access_token
                                                 andKey:(NSString *)key
                                                 andTpe:(UserType *)type;


/*
 获取某话题下的微博
 其中:
 access_token ---用户授权码
 key ---关键字
 */
+ (NSDictionary *)getWeiboOfTopicWithAccessToken:(NSString *)access_token
                                          andKey:(NSString *)key;


/*
 获取可能感兴趣用户
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getSuggestedUserByMayInterestedWithAccessToken:(NSString *)access_token;


/*
 获取微博内容相关用户
 其中:
 access_token ---用户授权码
 content ---微博内容
 */
+ (NSDictionary *)getSuggestedUserByContentOfWeiboWithAccessToken:(NSString *)access_token
                                                       andContent:(NSString *)content;


/*
 获取按兴趣排序后的微博
 其中:
 access_token ---用户授权码
 time ---据当前时间n秒之内
 */
+ (NSDictionary *)getWeiboSortByInterestWithAccessToken:(NSString *)access_token
                                                andTime:(int)time;


/*
 获取按兴趣排序后的微博的ID
 其中:
 access_token ---用户授权码
 time ---据当前时间n秒之内
 */
+ (NSDictionary *)getIdOfWeiboSortByInterestWithAccessToken:(NSString *)access_token
                                                    andTime:(int)time;


/*
 获取热门收藏
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getHotFavoriteWithAccessToken:(NSString *)access_token;


/*
 获取用户各种消息未读数
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getUnreadCountOfAllWithAccessToken:(NSString *)access_token
                                              andUid:(NSInteger)uid;


/*
 获取城市列表
 其中:
 access_token ---用户授权码
 province ---省份
 capital ---名字首字母，可为nil
 */
+ (NSDictionary *)getCityWithAccessToken:(NSString *)access_token
                             andProvince:(NSString *)province
                              andCapital:(NSString *)capital;

/*
 获取省份列表
 其中:
 access_token ---用户授权码
 country ---国家
 capital ---名字首字母，可为nil
 */
+ (NSDictionary *)getProvinceWithAccessToken:(NSString *)access_token
                                 andCountry:(NSString *)country
                                 andCapital:(NSString *)capital;


/*
 获取国家列表
 其中:
 access_token ---用户授权码
 capital ---名字首字母，可为nil
 */
+ (NSDictionary *)getCountryWithAccessToken:(NSString *)access_token
                                 andCapital:(NSString *)capital;


/*
 获取时区配置表
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getTimeZoneWithAccessToken:(NSString *)access_token;


/*
 获取好友位置动态
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getLocationOfFriendWithAccessToken:(NSString *)access_token;


/*
 获取用户的位置动态
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getLocationOfUserWithAccessToken:(NSString *)access_token
                                             andId:(NSInteger)uid;


/*
 获取某个位置地点的动态
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getLocationOfPlaceWithAccessToken:(NSString *)access_token
                                              andId:(NSInteger)iD;


/*
 获取某个位置周边的动态
 其中:
 access_token ---用户授权码
 lat ---纬度
 l_ong ---经度
 */
+ (NSDictionary *)getLocationAroundPlaceWithAccessToken:(NSString *)access_token
                                            andLat:(float)lat
                                           andLong:(float)l_ong;


/*
 根据id获取动态详情
 其中:
 access_token ---用户授权码
 iD ---动态id
 */
+ (NSDictionary *)getDetaileOfLocationWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)iD;


/*
 获取lbs位置服务内的用户信息
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getDetaileOfUserOfLBSWithAccessToken:(NSString *)access_token
                                                 andId:(NSInteger)uid;


/*
 获取用户签发过的地点列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getPlaceListUserGoneWithAccessToken:(NSString *)access_token
                                                andId:(NSInteger)uid;


/*
 获取用户的照片列表
 其中:
 access_token ---用户授权码
 uid ---用户id
 */
+ (NSDictionary *)getPicListWithAccessToken:(NSString *)access_token
                                      andId:(NSInteger)uid;


/*
 获取地点详情
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getDetailOfPlaceWithAccessToken:(NSString *)access_token
                                            andId:(NSInteger)iD;


/*
 获取在某地点签到的用户列表
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getUserWhoGoneToPlaceWithAccessToken:(NSString *)access_token
                                                 andId:(NSInteger)iD;


/*
 获取地点照片列表
 其中:
 access_token ---用户授权码
 iD ---位置id
 */
+ (NSDictionary *)getPicListOfPlaceWithAccessToken:(NSString *)access_token
                                             andId:(NSInteger)iD;


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
                                               andCategory:(NSString *)category_code;


/*
 获取地点分类
 其中:
 access_token ---用户授权码
 iD ---父分类id
 */
+ (NSDictionary *)getCategoryOfPlaceWithAccessToken:(NSString *)access_token
                                         andId:(int)iD;


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
                                        andLong:(float)l_ong;


/*
 获取附近发位置微博的人
 其中:
 access_token ---用户授权码
 lat ---纬度
 l_ong ---经度
 */
+ (NSDictionary *)getUserSentLocalWeiboNearbyWithAccessToken:(NSString *)access_token
                                                      andLat:(float)lat
                                                     andLong:(float)l_ong;


/*
 获取附近照片
 其中:
 access_token ---用户授权码
 lat ---纬度
 l_ong ---经度
 */
+ (NSDictionary *)getPicNearbyWithAccessToken:(NSString *)access_token
                                       andLat:(float)lat
                                      andLong:(float)l_ong;


/*
 根据ip地址返回地理信息坐标
 其中:
 access_token ---用户授权码
 ip ---ip地址
 */
+ (NSDictionary *)getGeoByIpWithAccessToken:(NSString *)access_token
                                         ip:(NSString *)ip;


/*
 根据实际地址返回地址信息坐标
 其中:
 access_token ---用户授权码
 address ---地址
 */
+ (NSDictionary *)getGeoByAddressWithAccessToken:(NSString *)access_token
                                         address:(NSString *)address;


/*
 根据地理信息坐标返回实际地址
 其中:
 access_token ---用户授权码
 coordinate ---坐标
 */
+ (NSDictionary *)getGeoByCoordinateWithAccessToken:(NSString *)access_token
                                         coordinate:(NSString *)coordinate;


/*
 根据gps坐标获取偏移后的坐标
 其中:
 access_token ---用户授权码
 coordinate ---坐标
 */
+ (NSDictionary *)getGeoAfterOffsetWithAccessToken:(NSString *)access_token
                                        coordinate:(NSString *)coordinate;


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
                       withType:(UnderlyingType *)type;


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
                       withType:(UnderlyingType *)type;


/*
 根据关键字查询公交线路信息
 其中:
 access_token ---用户授权码
 key ---关键词
 code ---城市代码
 */
+ (NSDictionary *)getBusLineWithAccessToken:(NSString *)access_token
                                        andKey:(NSString *)key
                                       andCity:(NSString *)code;


/*
 根据关键字查询公交车站信息
 其中:
 access_token ---用户授权码
 key ---关键词
 code ---城市代码
 */
+ (NSDictionary *)getBusStationWithAccessToken:(NSString *)access_token
                                        andKey:(NSString *)key
                                       andCity:(NSString *)code;


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
                                   andCategory:(NSString *)category;


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
                                 andCoordinate:(NSArray *)coordinate;

@end
