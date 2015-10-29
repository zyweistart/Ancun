//
//  BaiduMapUtils.m
//  Car
//
//  Created by Start on 10/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaiduMapUtils.h"

@implementation BaiduMapUtils

+ (NSString *)getAddress:(BMKPoiInfo*)info
{
    NSString *address;
    if(![@"" isEqualToString:info.address]){
        address=[NSString stringWithFormat:@"%@",info.address];
    }
    if(![@"" isEqualToString:info.name]){
        address=[NSString stringWithFormat:@"%@%@",address,info.name];
    }
    return address;
}

@end
