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

@end
