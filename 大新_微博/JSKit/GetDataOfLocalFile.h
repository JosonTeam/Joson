#import <Foundation/Foundation.h>
#import "AlartViewController.h"
#import <UIKit/UIKit.h>

@interface GetDataOfLocalFile : NSObject < ExpendableAlartViewDelegate >


#pragma mark 获取沙盒的txt文件
/*
 其中:
 name ---文件名
 */
+ (NSString *)getContentOfTxtFileAtBundleForFileName:(NSString *)name;


#pragma mark 获取沙盒文件夹的txt文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSString *)getContentOfTxtFileAtParh:(NSSearchPathDirectory)filePath
                            ForFileName:(NSString *)name;


#pragma mark 获取沙盒的plist文件
/*
 其中:
 name ---文件名
 */
+ (NSArray *)getContentOfPlistFileAtBundleForFileName:(NSString *)name;


#pragma mark 获取沙盒文件夹的plist文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSArray *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                             ForFileName:(NSString *)name;


#pragma mark 获取沙盒的plist文件
/*
 其中:
 name ---文件名
 */
+ (NSDictionary *)getContentOfPlistFileAtBundleWithFileName:(NSString *)name;


#pragma mark 获取沙盒文件夹的plist文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSDictionary *)getContentOfPlistFileAtParh:(NSSearchPathDirectory)filePath
                                 WithFileName:(NSString *)name;


#pragma mark 获取沙盒的json文件
/*
 其中:
 name ---文件名
 */
+ (NSDictionary *)getContentOfJsonFileAtBundleWithFileName:(NSString *)name;


#pragma mark 获取沙盒文件夹的json文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 */
+ (NSDictionary *)getContentOfJsonFileAtParh:(NSSearchPathDirectory)filePath
                                WithFileName:(NSString *)name;

#pragma mark 获取沙盒的图片文件
/*
 其中:
 name ---文件名
 type ---文件类型
 */
+ (NSData *)getContentOfPictureAtBundleWithFileName:(NSString *)name andType:(NSString *)type;

#pragma mark 获取沙盒文件夹的图片文件
/*
 其中:
 fileParh ---沙盒文件夹名
 name ---文件名
 type ---文件类型
 */
+ (NSData *)getContentOfPictureAtParh:(NSSearchPathDirectory)filePath
                         WithFileName:(NSString *)name
                              andType:(NSString *)type;



@end
