#import "NSString+Date.h"

@implementation NSString (Date)

- (NSString *)dateStringFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    //[formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSDate *dateFormatted = [formatter dateFromString:self];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    return [formatter stringFromDate:dateFormatted];
}

- (NSDate *)stringConvertDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter dateFromString:self];
}

- (NSString *)getDateLongTimeByYYYYMMddHHmmss{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone *timeZone=[NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate *date=[formatter dateFromString:self];
    return [NSString stringWithFormat:@"%zi",(long)[date timeIntervalSince1970]];
}


@end
