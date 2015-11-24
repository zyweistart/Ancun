//
//  ACResponse.m
//  ACyulu
//
//  Created by Start on 12-12-6.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

#import "Response.h"

@implementation Response

- (id)init{
    self=[super init];
    if(self){
        _successFlag=NO;
    }
    return self;
}

+ (Response*)toData:(NSData*)data
{
    Response *response=[[Response alloc]init];
    [response setData:data];
    if([response data]!=nil){
        NSString *responseString =[[NSString alloc] initWithData:[response data] encoding:NSUTF8StringEncoding];
        [response setResponseString:responseString];
        //转换成JSON格式
        NSDictionary *resultJSON=[NSJSONSerialization JSONObjectWithData:[response data] options:NSJSONReadingMutableLeaves error:nil];
        if(resultJSON!=nil){
            [response setCode:[NSString stringWithFormat:@"%@",[resultJSON objectForKey:@"result"]]];
            [response setMsg:[NSString stringWithFormat:@"%@",[resultJSON objectForKey:@"reason"]]];
            [response setResultJSON:resultJSON];
        }
    }
    return response;
}

@end
