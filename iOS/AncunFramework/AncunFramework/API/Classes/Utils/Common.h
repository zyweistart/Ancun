//
//  Common.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

@interface Common : NSObject

//缓存存取
+ (id)getCache:(NSString *)key;
+ (void)setCache:(NSString *)key data:(id)data;
+ (BOOL)getCacheByBool:(NSString *)key;
+ (void)setCacheByBool:(NSString *)key data:(BOOL)data;

+ (NSString*)formatPhone:(NSString*)phone;
//判断是否为null
+ (BOOL)isNull:(id)obj;
//null转""
+ (NSString*)nullConvertString:(id)value;

+ (void)alert:(NSString *)message;
+ (UIAlertController *)alertTitle:(NSString *)title Message:(NSString *)message confirmMsg:(NSString *)confirmMsg CancleMsg:(NSString *)msg confirmBlock:(void(^)(UIAlertAction *action))confirm;
/**
 * 取出document文件夹下得某个文件
 */
+ (NSString *)getDocumentFilePath:(NSString *)fileName;

//获取APP版本号
+ (NSString*)getAppVersion;
//获取APP版本生成号
+ (NSString*)getAppBuild;
+ (NSData *)toJSONData:(id)theData;
+ (NSString*)buildFileNameWithUrl:(NSString*)url;

//指纹验证
+ (void)authenticateUser;

@end
