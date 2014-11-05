#import <Foundation/Foundation.h>

@interface Factory : NSObject

+ (NSArray *)getHeigtAndWidthOfDevice;

//控件自适应字符串高度
+ (CGFloat)contentHeight:(NSString *)content;

+ (NSString *)getDateWithSourceDate:(NSString *)sourceDate
                         andSysDate:(NSString *)sysDate;

@end
