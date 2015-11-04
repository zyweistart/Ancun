//
//  User.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "User.h"

@implementation User

static User * instance = nil;
+ (User *) getInstance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
            instance.isLogin=NO;
        }
    }
    return instance;
}

+ (void)resetConfig {
    instance=nil;
}

@end