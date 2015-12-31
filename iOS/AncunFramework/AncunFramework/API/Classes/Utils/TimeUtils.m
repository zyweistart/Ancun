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

+ (long)getTimestamp13;
{
    double tt=[[NSDate date] timeIntervalSince1970];
    return (long)tt*1000;
}

//13位时间戳
+ (NSString*)timestampConvertDate13Format:(NSString*)format WithTime:(long)timestamp
{
    NSTimeInterval secs=timestamp/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:secs];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:confromTimesp];
}

+ (NSString*)timeCompareDisplay:(NSString*)timestamp
{
    long startstamp=[timestamp longLongValue];
    long second=([TimeUtils getTimestamp13]-startstamp)/1000;
    long min=second/60;
    if(min==0){
        return @"刚刚";
    }else if(60>min){
        return [NSString stringWithFormat:@"%ld分钟前",min];
    }
    long h=min/60;
    if(24>h){
        return [NSString stringWithFormat:@"%ld小时前",h];
    }
    long d=h/24;
    if(31>d){
        return [NSString stringWithFormat:@"%ld天前",d];
    }
    return [TimeUtils timestampConvertDate13Format:@"yyyy年MM月dd日" WithTime:startstamp];
}

+ (NSString *)secondConvertHHmmss:(long)totalSecond
{
    long hour=totalSecond/(60*60);
    long min=totalSecond/60%60;
    long second=totalSecond%60;
    NSString *h,*m,*s;
    if(hour<10){
        h=[NSString stringWithFormat:@"0%ld",hour];
    }else{
        h=[NSString stringWithFormat:@"%ld",hour];
    }
    if(min<10){
        m=[NSString stringWithFormat:@"0%ld",min];
    }else{
        m=[NSString stringWithFormat:@"%ld",min];
    }
    if(second<10){
        s=[NSString stringWithFormat:@"0%ld",second];
    }else{
        s=[NSString stringWithFormat:@"%ld",second];
    }
//    if(hour>0){
        return [NSString stringWithFormat:@"%@:%@:%@",h,m,s];
//    }else{
//        return [NSString stringWithFormat:@"%@:%@",m,s];
//    }
}
+ (NSString *)secondChangeHHmmss:(NSString *)time
{
    long len = [time longLongValue];
    long hour = 0;
    long min = 0;
    long sec = 0;
    
    //1.大于1一小时
    if (len >= 60*60) {
        hour = len/(60*60);
        len = len%(60*60);
    }
    //2.小于一小时
    if (len >= 60) {
        min = len/60;
        len = len%60;
    }
    //3.小于1分钟
    if (len < 60) {
        sec = len;
    }
    
    return [NSString stringWithFormat:@"%02ld:%02ld:%02ld",hour,min,sec];


}
@end