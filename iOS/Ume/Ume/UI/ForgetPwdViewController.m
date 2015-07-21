//
//  ForgetPwdViewController.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "CTextField.h"

@interface ForgetPwdViewController ()

@end

@implementation ForgetPwdViewController{
    CTextField *tfUserName;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"找回密码"];
        //
        [self cNavigationRightItemType:2 Title:@"下一步" action:@selector(goNext:)];
        //
        tfUserName=[[CTextField alloc]initWithFrame:CGRectMake1(20, 20, 280, 40) Placeholder:@"请输入注册手机号"];
        [self.view addSubview:tfUserName];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(25, 60, 280, 40) Text:@"验证码信息将发送到您的手机号"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [self.view addSubview:lbl];
    }
    return self;
}

- (void)goNext:(id)sender
{
    
}

@end
