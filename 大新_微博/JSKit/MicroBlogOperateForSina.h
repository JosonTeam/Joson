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
    SchoolTypeUniverCity = 1,
    SchoolTypeHighSchool = 2,
    SchoolTypeSecondaryTechnicalSchool = 3,
    SchoolTypeJuniorMiddleSchool = 4,
    SchoolTypePrimarySchool = 5
};


/*
 Following: 关注
 Fans: 粉丝
 */
typedef NS_ENUM(NSInteger, UserType)
{
    UserTypeFollowing = 0,
    UserTypeFans = 1
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
    UserCategoryDefault = 0,
    UserCategoryEnt = 1,
    UserCategoryMusic = 2,
    UserCategorySport = 3,
    UserCategoryFashion = 4,
    UserCategoryArt = 5,
    UserCategoryCartoon = 6,
    UserCategoryGames = 7,
    UserCategoryTrip = 8,
    UserCategoryFood = 9,
    UserCategoryHealth = 10,
    UserCategoryLiterature = 11,
    UserCategorySlock = 12,
    UserCategoryBusiness = 13,
    UserCategoryTech = 14,
    UserCategoryHouse = 15,
    UserCategoryAuto = 16,
    UserCategoryFate = 17,
    UserCategoryGovern = 18,
    UserCategoryMedium = 19,
    UserCategoryMarketer = 20
};


@interface MicroBlogOperateForSina : NSObject


/*
 发送一条纯文字微博
 其中:
 access_token ---用户授权码
 content ---发送内容
 */
+ (void)postWordWeiboWithAccessToken:(NSString *)access_token
                             content:(NSString *)content;


/*
 发送一条携带一张图片的微博
 其中:
 access_token ---用户授权码
 content ---文字内容
 pic ---图片地址
 */
+ (void)postWordWeiboAndSinglePictureWithAccessToken:(NSString *)access_token
                                             content:(NSString *)content
                                                 pic:(NSURL *)pic;

/*
 转发一条微博
 其中:
 access_token ---用户授权码
 content ---转发评论信息(可为nil)
 iD ---转发的微博id
 */
+ (void)reportWeiboWithAccessToken:(NSString *)access_token
                       withContent:(NSString *)content
                             andId:(NSInteger)iD;


/*
 删除微博
 其中:
 access_token ---用户授权码
 ID ---要删除的微博的ID
 */
+ (void)destroyWeiBoWithAcccessToken:(NSString *)access_token
                                  iD:(NSInteger)ID;


/*
 移除关注用户
 其中:
 access_token ---用户授权码
 ID ---需要移除的用户ID
 */
+ (void)destroyFollowingWithAcccessToken:(NSString *)access_token
                                      iD:(NSInteger)ID;


/*
 退出登录状态
 其中:
 access_token ---用户授权码
 */
+ (void)logoutMicroBlogWithAccessToken:(NSString *)access_token;


/*
 取得用户的详细信息
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (NSDictionary *)getDetailOfUserWithAccessToken:(NSString *)access_token
                                            name:(NSString *)name;


/*
 获得用户发表的微博
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (NSDictionary *)getWeiboOfUserWithAccessToken:(NSString *)access_token
                                           name:(NSString *)name;

/*
 获得用户发表的微博的id
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (NSDictionary *)getIdOfWeiboOfUserWithAccessToken:(NSString *)access_token
                                           name:(NSString *)name;


/*
 获得用户关注列表
 其中:
 access_token ---用户授权码
 name ---用户名
 */
+ (NSDictionary *)getFollowingWithAccessToken:(NSString *)access_token
                                         name:(NSString *)name;


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
 */
+ (NSDictionary *)getRecentWeiboOfFriendsWithAccessToken:(NSString *)access_token;


/*
 获取当前用户的最新微博
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getRecentWeiboOfSelfWithAccessToken:(NSString *)access_token;


/*
 获取当前用户与所关注用户的最新微博
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getIdOfRecentWeiboWithAccessToken:(NSString *)access_token;


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
 获取系统推荐用户
 其中:
 access_token ---用户授权码
 category ---用户类型
 */
+ (NSDictionary *)getSuggestedUserWithAccessToken:(NSString *)access_token
                                      andCategory:(UserCategory *)category;


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
 获取市区配置表
 其中:
 access_token ---用户授权码
 */
+ (NSDictionary *)getTimeZoneWithAccessToken:(NSString *)access_token;

@end
