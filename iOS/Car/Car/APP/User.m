//
//  User.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#define  USERUID @"USERUID"

#import "User.h"

@implementation User

static User * instance = nil;
+ (User *) getInstance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
        }
    }
    return instance;
}

+ (void)resetConfig {
    [instance setUid:nil];
    instance=nil;
}

- (BOOL)isLogin
{
    if([self uid]!=nil){
        return ![[self uid] isEmpty];
    }
    return NO;
}

- (NSString*)uid
{
    return [Common getCache:USERUID];
}

- (void)setUid:(NSString*)u
{
    [Common setCache:USERUID data:u];
}

@end