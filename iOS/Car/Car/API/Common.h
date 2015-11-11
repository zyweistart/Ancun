//
//  Common.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

//缓存存取
+ (id)getCache:(NSString *)key;
+ (void)setCache:(NSString *)key data:(id)data;
+ (BOOL)getCacheByBool:(NSString *)key;
+ (void)setCacheByBool:(NSString *)key data:(BOOL)data;

+ (NSString*)formatPhone:(NSString*)phone;

+ (BOOL)isNull:(id)obj;

+ (void)alert:(NSString *)message;

@end
