#import <Foundation/Foundation.h>

@interface Factory : NSObject

+ (NSArray *)getHeigtAndWidthOfDevice;

//控件自适应字符串高度
+ (CGFloat)contentHeight:(NSString *)content
                   width:(int)width;

//控件自适应字符串高度
+ (CGFloat)contentWidth:(NSString *)content
                 height:(int)height
               fontSize:(float)fontSize;

//获取微博发表时间
+ (NSString *)getDateWithSourceDate:(NSString *)sourceDate
                         andSysDate:(NSString *)sysDate
                            andType:(NSString *)type;

@end
