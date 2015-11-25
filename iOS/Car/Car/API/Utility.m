//
//  Utility.m
//  Car
//
//  Created by Start on 11/12/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (NSString*)getBeinDangerStatus:(NSString*)status
{
    if([@"1" isEqualToString:status]){
        return @"初审中";
    }else if([@"2" isEqualToString:status]){
        return @"责任认定中";
    }else if([@"3" isEqualToString:status]){
        return @"保险定损中";
    }else if([@"4" isEqualToString:status]){
        return @"责任认定有误";
    }else if([@"5" isEqualToString:status]){
        return @"<道路交通认定书>拍摄不清晰";
    }else if([@"6" isEqualToString:status]){
        return @"出险结束";
    }else if([@"7" isEqualToString:status]){
        return @"用户确认中";
    }else if([@"8" isEqualToString:status]){
        return @"补拍照片";
    }else{
        return [NSString stringWithFormat:@"未知状态:%@",status];
    }
}

@end
