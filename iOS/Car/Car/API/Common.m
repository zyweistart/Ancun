//
//  Common.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (NSString*)formatPhone:(NSString*)phone
{
    if(phone){
        NSMutableString *phoneNumber=[[NSMutableString alloc]init];
        for(int i=0;i<[phone length];i++){
            unichar c=[phone characterAtIndex:i];
            if((c>=48&&c<=57)||c==43){
                [phoneNumber appendFormat:@"%c",c];
            }
        }
        return [NSString stringWithFormat:@"%@",phoneNumber];
    }
    return @"";
}

@end
