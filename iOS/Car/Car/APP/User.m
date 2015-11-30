//
//  User.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#define  USERUID @"USERUID"

#define  CONFIGMESSAGENOTICE @"CONFIGMESSAGENOTICE"
#define  CONFIGMESSAGEDYNAMIC @"CONFIGMESSAGEDYNAMIC"
#define  CONFIGUPLOADFILE2G3GAUTO @"CONFIGUPLOADFILE2G3GAUTO"
#define  CONFIGUPLOADFILEWIFIAUTO @"CONFIGUPLOADFILEWIFIAUTO"

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


//平台公告
- (BOOL)configMessageNotice
{
    return [Common getCacheByBool:CONFIGMESSAGENOTICE];
}

- (void)setConfigMessageNotice:(BOOL)u
{
    [Common setCacheByBool:CONFIGMESSAGENOTICE data:u];
}

//出险动态
- (BOOL)configMessageDynamic
{
    return [Common getCacheByBool:CONFIGMESSAGEDYNAMIC];
}

- (void)setConfigMessageDynamic:(BOOL)u
{
    [Common setCacheByBool:CONFIGMESSAGEDYNAMIC data:u];
}

//2G3G自动上传
- (BOOL)configUploadFile2G3GAuto
{
    return [Common getCacheByBool:CONFIGUPLOADFILE2G3GAUTO];
}

- (void)setConfigUploadFile2G3GAuto:(BOOL)u
{
    [Common setCacheByBool:CONFIGUPLOADFILE2G3GAUTO data:u];
}

//WiFi自动上传
- (BOOL)configUploadFileWiFiAuto
{
    return [Common getCacheByBool:CONFIGUPLOADFILEWIFIAUTO];
}

- (void)setConfigUploadFileWiFiAuto:(BOOL)u
{
    [Common setCacheByBool:CONFIGUPLOADFILEWIFIAUTO data:u];
}

//判断是否已认证
- (BOOL)isAuthentication
{
    if([User getInstance].name){
        return ![[User getInstance].name isEmpty];
    }
    return NO;
}

@end