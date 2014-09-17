#import <Foundation/Foundation.h>

enum DateType{
    YYYYMMddHHmmss
};

@interface NSString (Date)

- (NSString *) dateStringFormat;

- (NSDate *)stringConvertDate;

- (NSString *)getDateLongTimeByYYYYMMddHHmmss;

@end
