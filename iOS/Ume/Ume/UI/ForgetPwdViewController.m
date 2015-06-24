//
//  ForgetPwdViewController.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "CTextField.h"
#import "CButton.h"

#define  __SCREEN_WIDTH 320
#define  __SCREEN_HEIGHT 290

@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController{
    CTextField *tfUserName;
    CTextField *tfVerifyCode;
    CTextField *tfPassword;
    CTextField *tfRePassword;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"忘记密码"];
        UIScrollView *scrollFrame=[[UIScrollView alloc]initWithFrame:self.view.bounds];
        [scrollFrame setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [scrollFrame setContentSize:CGSizeMake1(__SCREEN_WIDTH, __SCREEN_HEIGHT)];
        [self.view addSubview:scrollFrame];
        //
        tfUserName=[[CTextField alloc]initWithFrame:CGRectMake1(20, 20, 280, 40) Placeholder:@"请输入账户"];
        [tfUserName setWidth:__SCREEN_WIDTH];
        [tfUserName setHeight:__SCREEN_HEIGHT];
        [tfUserName setScrollFrame:scrollFrame];
        [scrollFrame addSubview:tfUserName];
        //
        tfVerifyCode=[[CTextField alloc]initWithFrame:CGRectMake1(20, 70, 280, 40) Placeholder:@"请输入校验码"];
        [tfVerifyCode setWidth:__SCREEN_WIDTH];
        [tfVerifyCode setHeight:__SCREEN_HEIGHT];
        [tfVerifyCode setScrollFrame:scrollFrame];
        [scrollFrame addSubview:tfVerifyCode];
        //
        CButton *button=[[CButton alloc]initWithFrame:CGRectMake1(40, 120, 240, 40) Name:@"获取校验码"];
        [button addTarget:self action:@selector(goModify:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:button];
        //
        tfPassword=[[CTextField alloc]initWithFrame:CGRectMake1(20, 170, 280, 40) Placeholder:@"请输入密码"];
        [tfPassword setWidth:__SCREEN_WIDTH];
        [tfPassword setHeight:__SCREEN_HEIGHT];
        [tfPassword setScrollFrame:scrollFrame];
        [tfPassword setSecureTextEntry:YES];
        [scrollFrame addSubview:tfPassword];
        //
        tfRePassword=[[CTextField alloc]initWithFrame:CGRectMake1(20, 220, 280, 40) Placeholder:@"请输入密码"];
        [tfRePassword setWidth:__SCREEN_WIDTH];
        [tfRePassword setHeight:__SCREEN_HEIGHT];
        [tfRePassword setScrollFrame:scrollFrame];
        [tfRePassword setSecureTextEntry:YES];
        [scrollFrame addSubview:tfRePassword];
        //
        button=[[CButton alloc]initWithFrame:CGRectMake1(40, 270, 240, 40) Name:@"确定"];
        [button addTarget:self action:@selector(goModify:) forControlEvents:UIControlEventTouchUpInside];
        [scrollFrame addSubview:button];
    }
    return self;
}

- (void)goModify:(id)sender
{
    
}

@end
