//
//  TimeUtils.m
//  Car
//
//  Created by Start on 10/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "TimeUtils.h"

@implementation TimeUtils

+ (NSString*)getTimeFormatter:(NSString*)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:format];
    return [dateFormatter stringFromDate:[NSDate date]];
}

//13位时间戳
+ (NSString*)timestampConvertDate13Format:(NSString*)format WithTime:(NSString*)time
{
    NSTimeInterval secs=[time doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:secs];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:confromTimesp];
}

@end