#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GetDataOfLocalFile : NSObject


/*
 获取沙盒的txt文件
 其中:
 name ---文件名
 */
+ (NSString *)getContentOfTxtFileAtBundleForFileName:(NSString *)name;


/*
 获取沙盒文件夹的txt文件
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSString *)getContentOfTxtFileAtParh:(NSSearchPathDirectory)filePath
                            ForFileName:(NSString *)name;


/*
 获取沙盒的plist文件
 其中:
 name ---文件名
 */
+ (NSArray *)getContentOfPlistFileAtBundleForFileName:(NSString *)name;


/*
 获取沙盒文件夹的plist文件
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */

+ (NSArray *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                             ForFileName:(NSString *)name;


/*
 获取沙盒的plist文件
 其中:
 name ---文件名
 */
+ (NSDictionary *)getContentOfPlistFileAtBundleWithFileName:(NSString *)name;


/*
 获取沙盒文件夹的plist文件
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */

+ (NSDictionary *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                                 WithFileName:(NSString *)name;


/*
 获取沙盒的json文件
 其中:
 name ---文件名
 */
+ (NSDictionary *)getContentOfJsonFileAtBundleWithFileName:(NSString *)name;


/*
 获取沙盒文件夹的json文件
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */

+ (NSDictionary *)getContentOfJsonFileAtParh:(NSSearchPathDirectory)filePath
                                WithFileName:(NSString *)name;

/*
 获取沙盒的图片文件
 其中:
 name ---文件名
 type ---文件类型
 */
+ (NSData *)getContentOfPictureAtBundleWithFileName:(NSString *)name andType:(NSString *)type;

/*
 获取沙盒文件夹的图片文件
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 type ---文件类型
 */
+ (NSData *)getContentOfPictureAtParh:(NSSearchPathDirectory)filePath
                         WithFileName:(NSString *)name
                              andType:(NSString *)type;
@end
