//
//  LoginViewController.m
//  Ume
//
//  Created by Start on 5/13/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
#import "CLabel.h"
#import "CTextField.h"
#import "CButton.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    CTextField *tfUserName;
    CTextField *tfPassword;
}

- (id)init{
    self=[super init];
    if(self){
        self.title=@"登录";
        //
        UIButton *bRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        [bRegister setTitle:@"注册" forState:UIControlStateNormal];
        [bRegister.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bRegister addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];
        bRegister.frame = CGRectMake(0, 0, 70, 30);
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:bRegister];
        //
        tfUserName=[[CTextField alloc]initWithFrame:CGRectMake1(20, 20, 280, 40) Placeholder:@"请输入账户"];
        [self.view addSubview:tfUserName];
        //
        tfPassword=[[CTextField alloc]initWithFrame:CGRectMake1(20, 70, 280, 40) Placeholder:@"请输入密码"];
        [self.view addSubview:tfPassword];
        //
        UIButton *bForgetPwd=[[UIButton alloc]initWithFrame:CGRectMake1(220, 120, 80, 30)];
        [bForgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [bForgetPwd setTitleColor:DEFAULTITLECOLOR(190) forState:UIControlStateNormal];
        [bForgetPwd.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bForgetPwd addTarget:self action:@selector(goForgetPwd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bForgetPwd];
        [self.view addSubview:bForgetPwd];
        //
        CButton *cLogin=[[CButton alloc]initWithFrame:CGRectMake1(40, 160, 240, 40) Name:@"登录"];
        [cLogin addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cLogin];
    }
    return self;
}

- (void)goRegister:(id)sender
{
    [self.navigationController pushViewController:[[RegisterViewController alloc]init] animated:YES];
}

- (void)goForgetPwd:(id)sender
{
    [self.navigationController pushViewController:[[ForgetPwdViewController alloc]init] animated:YES];
}

- (void)goLogin:(id)sender
{
    
}

@end
