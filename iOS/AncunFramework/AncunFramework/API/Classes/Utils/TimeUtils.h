//
//  TimeUtils.h
//  Car
//
//  Created by Start on 10/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#define  FORMAT_yyyyMMddHHmmss @"yyyy-MM-dd HH:mm:ss"
#define  FORMAT_yyyyMMddHHmmss_1 @"yyyyMMddHHmmss"

#import <Foundation/Foundation.h>

@interface TimeUtils : NSObject

+ (NSString*)getTimeFormatter:(NSString*)format;

+ (long)getTimestamp13;

+ (NSString*)timestampConvertDate13Format:(NSString*)format WithTime:(long)timestamp;

+ (NSString*)timeCompareDisplay:(NSString*)timestamp;

+ (NSString *)secondConvertHHmmss:(long)totalSecond;
+ (NSString *)secondChangeHHmmss:(NSString *)time;
@end
