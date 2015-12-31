//
//  Config.m
//  Witness
//
//  Created by Start on 12/1/15.
//  Copyright © 2015 Ancun. All rights reserved.
//
#define FIRSTOPENAPP @"FIRSTOPENAPP"
#define CONFIGUPLOADFILE2G3GAUTO @"CONFIGUPLOADFILE2G3GAUTO"
#define CONFIGUPLOADFILEWIFIAUTO @"CONFIGUPLOADFILEWIFIAUTO"

#import "Config.h"

@implementation Config

static Config * instance = nil;
+ (Config *) getInstance {
    @synchronized(self){
        if(nil == instance){
            instance=[self new];
        }
    }
    return instance;
}

//第一次打开APP
- (BOOL)firstOpenApp
{
    return [Common getCacheByBool:FIRSTOPENAPP];
}

- (void)setFirstOpenApp:(BOOL)u
{
    [Common setCacheByBool:FIRSTOPENAPP data:u];
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

@end