//
//  CButtonGetCode.m
//  Car
//
//  Created by Start on 11/26/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "CButtonGetCode.h"

@implementation CButtonGetCode{
    int second;
    NSTimer *verificationCodeTime;
    UIView *currentView;
}

- (id)initWithFrame:(CGRect)frame View:(UIView*)view
{
    self=[super initWithFrame:frame Name:@"获取验证码" Type:3];
    if(self){
        currentView=view;
    }
    return self;
}

- (void)goGetCode:(NSString*)phone Type:(NSString*)type
{
    if([phone isEmpty]){
        [Common alert:@"请输入手机号"];
        return;
    }
    if(verificationCodeTime==nil){
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"sendcode" forKey:@"act"];
        [params setObject:phone forKey:@"mobile"];
        [params setObject:type forKey:@"type"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
        [self.hRequest setDelegate:self];
        [self.hRequest setView:currentView];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }
}

- (void)updateTimer
{
    --second;
    if(second==0){
        [self setEnabled:YES];
        [self setTitle:@"获取校验码" forState:UIControlStateNormal];
        if(verificationCodeTime){
            [verificationCodeTime invalidate];
            verificationCodeTime=nil;
        }
    }else{
        [self setEnabled:NO];
        [self setTitle:[NSString stringWithFormat:GLOBAL_GETCODE_STRING,second] forState:UIControlStateNormal];
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            second=GLOBAL_SECOND;
            [self setEnabled:NO];
            [self setTitle:[NSString stringWithFormat:GLOBAL_GETCODE_STRING,second] forState:UIControlStateNormal];
            verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }
    }
}

@end