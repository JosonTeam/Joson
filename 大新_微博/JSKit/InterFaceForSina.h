#ifndef MicroBlog_InterFaceForSina_h
#define MicroBlog_InterFaceForSina_h

/*
 获取用户发布的微博
 */
#define InterfaceForSinaToGetWeiboOfUser @"https://api.weibo.com/2/statuses/user_timeline.json"

/*
 获取用户发布的微博的id
 */
#define InterfaceForSinaToGetIdOfWeiboOfUser @"https://api.weibo.com/2/statuses/user_timeline/ids.json"

/*
 发布纯文字微博
 */
#define InterfaceForSinaToSendWord @"https://api.weibo.com/2/statuses/update.json"

/*
 发布带一张图片的文字微博
 */
#define InterfaceForSinaToSendWordAndSinglePic @"https://api.weibo.com/2/statuses/upload.json"

/*
 删除微博
 */
#define InterfaceForSinaToDestroyWeibo @"https://api.weibo.com/2/statuses/destroy.json"

/*
 获取用户的详细资料
 */
#define InterfaceForSinaToGetDetaileOfUser @"https://api.weibo.com/2/users/show.json"

/*
 获取用户的关注列表
 */
#define InterfaceForSinaToGetFollowing @"https://api.weibo.com/2/friendships/friends.json"

/*
 获取最新热门微博
 */
#define InterfaceForSinaToGetRecentHotWeibo @"https://api.weibo.com/2/statuses/public_timeline.json"

/*
 获取用户的粉丝列表
 */
#define InterfaceForSinaToGetFans @"https://api.weibo.com/2/friendships/followers.json"

/*
 获取好友的最新微博
 */
#define InterfaceForSinaToGetRecentWeiboOfFriends @"https://api.weibo.com/2/statuses/friends_timeline.json"

/*
 获取用户发布的最新微博
 */
#define InterfaceForSinaToGetRecentWeiboOfSelf @"https://api.weibo.com/2/statuses/home_timeline.json"

/*
 获取用户发布的最新微博的id
 */
#define InterfaceForSinaToGetIdOfRecentWeibo @"https://api.weibo.com/2/statuses/friends_timeline/ids.json"

/*
 获取用户微博的转发列表
 */
#define InterfaceForSinaToGetReportListOfWeibo @"https://api.weibo.com/2/statuses/repost_timeline.json"

/*
 获取用户微博的评论列表
 */
#define InterfaceForSinaToGetAnswerListOfWeibo @"https://api.weibo.com/2/comments/show.json"

/*
 获取用户的微博转发数和微博评论数
 */
#define InterfaceForSinaToGetCountOfAnswerAndReportOfWeibo @"https://api.weibo.com/2/statuses/count.json"

/*
 获取用户微博的详细信息
 */
#define InterfaceForSinaToGetDetailOfWeibo @"https://api.weibo.com/2/statuses/show.json"

/*
 转发微博
 */
#define InterfaceForSinaToReportWeibo @"https://api.weibo.com/2/statuses/repost.json"

/*
 获取@我列表
 */
#define InterfaceForSinaToGetMemtionMe @"https://api.weibo.com/2/comments/mentions.json"

/*
 获取用户的微博数，关注数，粉丝数
 */
#define InterfaceForSinaToGetCountOfAll @"https://api.weibo.com/2/users/counts.json"

/*
 获取用户的共同关注
 */
#define InterfaceForSinaToGetFollowTogether @"https://api.weibo.com/2/friendships/friends/in_common.json"

/*
 获取用户的互粉列表
 */
#define InterfaceForSinaToGetFollowEach @"https://api.weibo.com/2/friendships/friends/bilateral.json"

/*
 获取用户互粉列表的id
 */
#define InterfaceForSinaToGetIdOfFollowEach @"https://api.weibo.com/2/friendships/friends/bilateral/ids.json"

/*
 获取用户关注列表的id
 */
#define InterfaceForSinaToGetIdOfFollowing @"https://api.weibo.com/2/friendships/friends/ids.json"

/*
 获取用户粉丝列表的id
 */
#define InterfaceForSinaToGetIdOfFollower @"https://api.weibo.com/2/friendships/followers/ids.json"

/*
 获取用户的活跃粉丝列表
 */
#define InterfaceForSinaToGetActiveFollower @"https://api.weibo.com/2/friendships/followers/active.json"

/*
 获取用户关注的人中关注了指定的人的人
 */
#define InterfaceForSinaToGetFollowingWhoFollowThePerson @"https://api.weibo.com/2/friendships/friends_chain/followers.json"

/*
 获取用户关系
 */
#define InterfaceForSinaToGetRelationOfUsers @"https://api.weibo.com/2/friendships/show.json"

/*
 获取用户的隐私设置
 */
#define InterfaceForSinaToGetPrivateMessageOfUser @"https://api.weibo.com/2/account/get_privacy.json"

/*
 获取学校列表
 */
#define InterfaceForSinaToGetSchoolList @"https://api.weibo.com/2/account/profile/school_list.json"

/*
 获取用户的访问频率限制
 */
#define InterfaceForSinaToGetLimitOfUser @"https://api.weibo.com/2/account/rate_limit_status.json"

/*
 获取用户的id
 */
#define InterfaceForSinaToGetUid @"https://api.weibo.com/2/account/get_uid.json"

/*
 获取用户的收藏列表
 */
#define InterfaceForSinaToGetFavorite @"https://api.weibo.com/2/favorites.json"

/*
 获取用户收藏列表的id
 */
#define InterfaceForSinaToGetIdOfFavorite @"https://api.weibo.com/2/favorites/ids.json"

/*
 获取用户收藏的详细信息
 */
#define InterfaceForSinaToGetDetaileOfFavorite @"https://api.weibo.com/2/favorites/show.json"

/*
 获取用户某标签下的收藏列表
 */
#define InterfaceForSinaToGetFavoriteOfTag @"https://api.weibo.com/2/favorites/by_tags.json"

/*
 获取用户收藏标签的列表
 */
#define InterfaceForSinaToGetListOfFavoriteTag @"https://api.weibo.com/2/favorites/tags.json"

/*
 获取用户某标签下的收藏ID
 */
#define InterfaceForSinaToGetIdOfFavoriteOfTag @"https://api.weibo.com/2/favorites/by_tags/ids.json"

/*
 获取一小时内的热门话题
 */
#define InterfaceForSinaToGetHotTopicOfHour @"https://api.weibo.com/2/trends/hourly.json"

/*
 获取一天之内的热门话题
 */
#define InterfaceForSinaToGetHotTopicOfDay @"https://api.weibo.com/2/trends/daily.json"

/*
 获取一周之内的热门话题
 */
#define InterfaceForSinaToGetHotTopicOfWeek @"https://api.weibo.com/2/trends/weekly.json"

/*
 获取用户的标签列表
 */
#define InterfaceForSinaToGetTagOfUser @"https://api.weibo.com/2/tags.json"

/*
 获取系统推荐的标签列表
 */
#define InterfaceForSinaToGetSuggestionOfTag @"https://api.weibo.com/2/tags/suggestions.json"

/*
 判断昵称是否存在
 */
#define InterfaceForSinaToMakeSureOfNickName @"https://api.weibo.com/2/register/verify_nickname.json"

/*
 搜用户搜索建议
 */
#define InterfaceForSinaToGetSuggestionOfUser @"https://api.weibo.com/2/search/suggestions/users.json"

/*
 搜学校搜索建议
 */
#define InterfaceForSinaToGetSuggestionOfSchool @"https://api.weibo.com/2/search/suggestions/schools.json"

/*
 艘公司搜索建议
 */
#define InterfaceForSinaToGetSuggestionOfCompany @"https://api.weibo.com/2/search/suggestions/companies.json"

/*
 搜应用搜索建议
 */
#define InterfaceForSinaToGetSuggestionOfApp @"https://api.weibo.com/2/search/suggestions/apps.json"

/*
 @联想搜索
 */
#define InterfaceForSinaToGetSuggestionOfPeople @"https://api.weibo.com/2/search/suggestions/at_users.json"

/*
 获取某一话题下的微博
 */
#define InterfaceForSinaToGetWeiboOfTopic @"https://api.weibo.com/2/search/topics.json"

/*
 获取系统推荐用户
 */
#define InterfaceForSinaToGetSuggestedUser @"https://api.weibo.com/2/suggestions/users/hot.json"

/*
 获取可能感兴趣的人
 */
#define InterfaceForSinaToGetSuggestedUserByMayInterested @"https://api.weibo.com/2/suggestions/users/may_interested.json"

/*
 获取与微博内容相关用户
 */
#define InterfaceForSinaToGetSuggestedUserByContentOfWeibo @"https://api.weibo.com/2/suggestions/users/by_status.json"

/*
 按兴趣对微博进行排序
 */
#define InterfaceForSinaToSortByInterested @"https://api.weibo.com/2/suggestions/statuses/reorder.json"

/*
 按兴趣进行排序的微博的id
 */
#define InterfaceForSinaToGetIdOfWeiboSortByInterested @"https://api.weibo.com/2/suggestions/statuses/reorder/ids.json"

/*
 获取热门收藏
 */
#define InterfaceForSinaToGetHotFavorite @"https://api.weibo.com/2/suggestions/favorites/hot.json"

/*
 获取用户某种消息的未读数
 */
#define InterfaceForSinaToGetUnreadCountOfAll @"https://rm.api.weibo.com/2/remind/unread_count.json"

/*
 获取城市列表
 */
#define InterfaceForSinaToGetCity @"https://api.weibo.com/2/common/get_city.json"

/*
 获取省份列表
 */
#define InterfaceForSinaToGetProvince @"https://api.weibo.com/2/common/get_province.json"

/*
 获取国家列表
 */
#define InterfaceForSinaToGetCountry @"https://api.weibo.com/2/common/get_country.json"

/*
 获取时区列表
 */
#define InterfaceForSinaToGetTimeZone @"https://api.weibo.com/2/common/get_timezone.json"

/*
 移除关注
 */
#define InterfaceForSinaToDestroyFollowing @"https://api.weibo.com/2/friendships/destroy.json"

/*
 注销
 */
#define InterfaceForSinaToLogOut @"https://api.weibo.com/2/account/end_session.json"

/*
 关注某用户
 */
#define InterfaceForSinaToFollowUser @"https://api.weibo.com/2/friendships/create.json"

/*
 添加收藏
 */
#define InterfaceForSinaToCreateFavorite @"https://api.weibo.com/2/favorites/create.json"

/*
 删除收藏
 */
#define InterfaceForSinaToDeleteFavorite @"https://api.weibo.com/2/favorites/destroy.json"

/*
 更新收藏
 */
#define InterfaceForSinaToUpdateFavorite @"https://api.weibo.com/2/favorites/tags/update.json"

/*
  更新用户收藏下的指定标签
 */
#define InterfaceForSinaToUpdateTagAtFavorite @"https://api.weibo.com/2/favorites/tags/update_batch.json"

/*
 删除用户收藏下的指定标签
 */
#define InterfaceForSinaToDeleteTagAtFavorite @"https://api.weibo.com/2/favorites/tags/destroy_batch.json"

/*
 添加用户标签
 */
#define InterfaceForSinaToCreateTag @"https://api.weibo.com/2/tags/create.json"

/*
 删除用户标签
 */
#define InterfaceForSinaToDeleteTag @"https://api.weibo.com/2/tags/destroy.json"

/*
 标记不感兴趣的人
 */
#define InterfaceForSinaToSetUserUninterested @"https://api.weibo.com/2/suggestions/users/not_interested.json"

/*
 获取好友位置动态
 */
#define InterfaceForSinaToGetLocationOfFriend @"https://api.weibo.com/2/place/friends_timeline.json"

/*
 获取用户的位置动态
 */
#define InterfaceForSinaToGetLocationOfUser @"https://api.weibo.com/2/place/user_timeline.json"

/*
 获取某个位置地点的动态
 */
#define InterfaceForSinaToGetLocationOfPlace @"https://api.weibo.com/2/place/poi_timeline.json"

/*
 获取某个位置周边的动态
 */
#define InterfaceForSinaToGetLocationAroundPlace @"https://api.weibo.com/2/place/nearby_timeline.json"

/*
 根据id获取动态详情
 */
#define InterfaceForSinaToGetDetaileOfLocation @"https://api.weibo.com/2/place/statuses/show.json"

/*
 获取lbs位置服务内的用户信息
 */
#define InterfaceForSinaToGetDetaileOfUserOfLBS @"https://api.weibo.com/2/place/users/show.json"

/*
 获取用户签发过的地点列表
 */
#define InterfaceForSinaToGetPlaceListUserGone @"https://api.weibo.com/2/place/users/checkins.json"

/*
 获取用户的照片列表
 */
#define InterfaceForSinaToGetPicList @"https://api.weibo.com/2/place/users/photos.json"

/*
 获取地点详情
 */
#define InterfaceForSinaToGetDetaileOfPlace @"https://api.weibo.com/2/place/pois/show.json"

/*
 获取在某地点签到的用户列表
 */
#define InterfaceForSinaToGetUserWhoGoneToPlace @"https://api.weibo.com/2/place/pois/users.json"

/*
 获取地点照片列表
 */
#define InterfaceForSinaToGetPicListOfPlace @"https://api.weibo.com/2/place/pois/photos.json"

/*
 按省市查询地点
 */
#define InterfaceForSinaToGetPlaceByProvinceAndCity @"https://api.weibo.com/2/place/pois/search.json"

/*
 获取地点分类
 */
#define InterfaceForSinaToGetCategoryOfPlace @"https://api.weibo.com/2/place/pois/category.json"

/*
 获取附近地点
 */
#define InterfaceForSinaToGetPlaceNearby @"https://api.weibo.com/2/place/nearby/pois.json"

/*
 获取附近发位置微博的人
 */
#define InterfaceForSinaToGetUserSentLocalWeiboNearby @"https://api.weibo.com/2/place/nearby/users.json"

/*
 获取附近照片
 */
#define InterfaceForSinaToGetPicNearby @"https://api.weibo.com/2/place/nearby/photos.json"

/*
 签到同时上传一张图片
 */
#define InterfaceForSinaToChekin @"https://api.weibo.com/2/place/pois/add_checkin.json"

/*
 添加照片
 */
#define InterfaceForSinaToAddPic @"https://api.weibo.com/2/place/pois/add_photo.json"

/*
 添加点评
 */
#define InterfaceForSinaToAddTip @"https://api.weibo.com/2/place/pois/add_tip.json"

/*
 根据ip地址返回地理信息坐标
 */
#define InterfaceForSinaToGetGeoByIp @"https://api.weibo.com/2/location/geo/ip_to_geo.json"

/*
 根据实际地址返回地址信息坐标
 */
#define InterfaceForSinaToGetGeoByAddress @"https://api.weibo.com/2/location/geo/address_to_geo.json"

/*
 根据地理信息坐标返回实际地址
 */
#define InterfaceForSinaToGetAddressByGeo @"https://api.weibo.com/2/location/geo/geo_to_address.json"

/*
 根据gps坐标获取偏移后的坐标
 */
#define InterfaceForSinaToGetGeoAfterOffsetByGPS @"https://api.weibo.com/2/location/geo/gps_to_offset.json"

/*
 判断地理信息坐标是否是国内坐标
 */
#define InterfaceForSinaToMakeSureGeoIsDomestic @"https://api.weibo.com/2/location/geo/is_domestic.json"


/*
 根据起点和终点查询自驾车路线信息
 */
#define InterfaceForSinaToGetDriveRoute @"https://api.weibo.com/2/location/line/drive_route.json"

/*
 根据起点和终点查询公交路线信息
 */
#define InterfaceForSinaToGetBusRoute @"https://api.weibo.com/2/location/line/bus_route.json"

/*
 根据关键字查询公交线路信息
 */
#define InterfaceForSinaToGetBusLine @"https://api.weibo.com/2/location/line/bus_line.json"

/*
 根据关键字查询公交车站信息
 */
#define InterfaceForSinaToGetBusStation @"https://api.weibo.com/2/location/line/bus_station.json"

/*
 根据关键词按地址位置获取poi的信息
 */
#define InterfaceForSinaToGetPOIByAddress @"https://api.weibo.com/2/location/pois/search/by_location.json"

/*
 根据关键词按矩形区域回去poi信息
 */
#define InterfaceForSinaToGetPOIByRect @"https://api.weibo.com/2/location/pois/search/by_area.json"

/*
 获取code
 */
#define InterfaceForSinaToGetCode(cid) [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=https://api.weibo.com/oauth2/default.html",cid];

/*
 获取access_token
 */
#define InterfaceForSinaToGetAccesstoken(csecret,rcode) [NSString stringWithFormat:@"https://api.weibo.com/oauth2/access_token?client_secret=%@&redirect_uri=https://api.weibo.com/oauth2/default.html&grant_type=authorization_code&code=%@",csecret,rcode];

#endif
