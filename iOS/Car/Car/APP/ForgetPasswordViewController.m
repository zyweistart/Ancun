//
//  ForgetPasswordViewController.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController{
    XLTextField *mUserName;
    XLTextField *mPassword;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"找回密码"];
    UIImageView *bgView=[[UIImageView alloc]initWithFrame:self.view.bounds];
    [bgView setImage:[UIImage imageNamed:@"BJ_1"]];
    [bgView setUserInteractionEnabled:YES];
    [self.view addSubview:bgView];
    
    UIImageView *logo=[[UIImageView alloc]initWithFrame:CGRectMake1(94, 60, 132, 62)];
    [logo setImage:[UIImage imageNamed:@"LOGO"]];
    [bgView addSubview:logo];
    
    mUserName=[[XLTextField alloc]initWithFrame:CGRectMake1(20, 150, 280, 40)];
    [mUserName setPlaceholder:@"请输入手机号"];
    [mUserName setStyle:1];
    [bgView addSubview:mUserName];
    
    mPassword=[[XLTextField alloc]initWithFrame:CGRectMake1(20, 210, 280, 40)];
    [mPassword setPlaceholder:@"请输入密码"];
    [mPassword setSecureTextEntry:YES];
    [mPassword setStyle:1];
    [bgView addSubview:mPassword];
    
    XLButton *bLogin=[[XLButton alloc]initWithFrame:CGRectMake1(20, 270, 280, 40) Name:@"登录" Type:3];
    [bLogin addTarget:self action:@selector(goLogin) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:bLogin];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
