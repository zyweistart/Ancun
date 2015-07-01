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
#import "ImageTextField.h"
#import "CButton.h"
#import "NSString+Utils.h"

@interface LoginViewController ()

@end

@implementation LoginViewController{
    ImageTextField *tfUserName;
    ImageTextField *tfPassword;
    NSString *tUid,*tTimeStamp,*tUserName,*tPassWord;
    CButton *cLogin;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"登录"];
        //
        UIButton *bClose = [[UIButton alloc]init];
        [bClose setFrame:CGRectMake1(0, 0, 30, 30)];
        [bClose setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
        [bClose setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateHighlighted];
        [bClose addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bClose];
        //
        UIButton *bRegister = [UIButton buttonWithType:UIButtonTypeCustom];
        [bRegister setFrame:CGRectMake1(0, 0, 30, 30)];
        [bRegister setTitle:@"注册" forState:UIControlStateNormal];
        [bRegister.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bRegister setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [bRegister addTarget:self action:@selector(goRegister:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:bRegister];
        //
        tfUserName=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 20, 280, 40) Image:@"icon_phone" Placeholder:@"请输入账户"];
        [tfUserName.textField setDelegate:self];
        [self.view addSubview:tfUserName];
        //
        tfPassword=[[ImageTextField alloc]initWithFrame:CGRectMake1(20, 70, 280, 40) Image:@"icon_mima" Placeholder:@"请输入密码"];
        [tfPassword.textField setSecureTextEntry:YES];
        [tfPassword.textField setDelegate:self];
        [self.view addSubview:tfPassword];
        //
        UIButton *bForgetPwd=[[UIButton alloc]initWithFrame:CGRectMake1(220, 110, 80, 30)];
        [bForgetPwd setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [bForgetPwd setTitleColor:DEFAULTITLECOLOR(190) forState:UIControlStateNormal];
        [bForgetPwd.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bForgetPwd addTarget:self action:@selector(goForgetPwd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:bForgetPwd];
        [self.view addSubview:bForgetPwd];
        //
        cLogin=[[CButton alloc]initWithFrame:CGRectMake1(20, 150, 280, 40) Name:@"登录" Type:4];
        [cLogin setTitleColor:DEFAULTITLECOLOR(120) forState:UIControlStateNormal];
        [cLogin addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:cLogin];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 340, 300, 40) Text:@"快捷登陆"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:lbl];
        UIButton *kSina=[[UIButton alloc]initWithFrame:CGRectMake1(94, 380, 24, 24)];
        [kSina setImage:[UIImage imageNamed:@"sina"] forState:UIControlStateNormal];
        [self.view addSubview:kSina];
        UIButton *kQQ=[[UIButton alloc]initWithFrame:CGRectMake1(148, 380, 24, 24)];
        [kQQ setImage:[UIImage imageNamed:@"qq"] forState:UIControlStateNormal];
        [self.view addSubview:kQQ];
        UIButton *kWX=[[UIButton alloc]initWithFrame:CGRectMake1(202, 380, 24, 24)];
        [kWX setImage:[UIImage imageNamed:@"weixin"] forState:UIControlStateNormal];
        [self.view addSubview:kWX];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //自动登陆
    if([[User Instance]isAutoLogin]){
        [tfUserName.textField setText:[[User Instance]getUserName]];
        tUserName=[tfUserName.textField text];
        [tfPassword.textField setText:[[User Instance]getPassword]];
        tPassWord=[tfPassword.textField text];
        [self handleGetInit];
    }
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
    tUserName=[tfUserName.textField text];
    if([@"" isEqualToString:tUserName]){
        [Common alert:@"账号不能为空"];
        return;
    }
    tPassWord=[tfPassword.textField text];
    if([@"" isEqualToString:tPassWord]){
        [Common alert:@"密码不能为空"];
        return;
    }
    [self handleGetInit];
}

//初始化
- (void)handleGetInit
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:tUserName forKey:@"mobile"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"cmd=hello" requestParams:params];
}
//登陆
- (void)handleGoLogin
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:tUserName forKey:@"mobile"];
    [params setObject:[self passwordDigest:tPassWord Uid:tUid TimeStamp:tTimeStamp] forKey:@"digest"];//加密后的密码
    NSString *model=[[UIDevice currentDevice] model];
    [params setObject:model forKey:@"teltype"];//品牌
    NSString *systemVersion=[[UIDevice currentDevice] systemVersion];
    [params setObject:systemVersion forKey:@"osver"];//系统版本号
    NSString *systemName=[[UIDevice currentDevice] model];
    [params setObject:systemName forKey:@"model"];//手机型号
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appCurVersionNum = [infoDictionary objectForKey:@"CFBundleVersion"];
    [params setObject:appCurVersionNum forKey:@"appver"];//app版本
    [params setObject:@"120384774983729487" forKey:@"imsi"];//设备唯一码
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:@"cmd=auth" requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            tUid=[Common getString:[[response resultJSON]objectForKey:@"uid"] DefaultValue:@""];
            tTimeStamp=[Common getString:[[response resultJSON]objectForKey:@"timestamp"] DefaultValue:@""];
            [self handleGoLogin];
        }else if(reqCode==501){
            [[User Instance]LoginSuccessWithUserName:tUserName Password:tPassWord Data:[response resultJSON]];
            if(self.delegate){
                [self.delegate handleLogin:nil];
            }else{
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }else{
        if(reqCode==501){
            [tfPassword.textField setText:@""];
            [[User Instance]clear];
        }
    }
}

- (NSString*)passwordDigest:(NSString*)password Uid:(NSString*)uid TimeStamp:(NSString*)timestamp
{
    password=[[[NSString stringWithFormat:@"%@_%@",uid,password]md5]uppercaseString];
    return [[[NSString stringWithFormat:@"%@%@",timestamp,password]md5]uppercaseString];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [cLogin setType:2];
    [self changeTextFieldStatus:textField];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    [self changeTextFieldStatus:nil];
    return YES;
}

- (void)changeTextFieldStatus:(UITextField*)textField
{
    if(textField==tfUserName.textField){
        [tfUserName.image setImage:[UIImage imageNamed:@"icon_phone2"]];
        tfUserName.layer.borderColor=[COLOR2552160 CGColor];
        [tfPassword.image setImage:[UIImage imageNamed:@"icon_mima"]];
        tfPassword.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
    }else if(textField==tfPassword.textField){
        [tfUserName.image setImage:[UIImage imageNamed:@"icon_phone"]];
        tfUserName.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tfPassword.image setImage:[UIImage imageNamed:@"icon_mima2"]];
        tfPassword.layer.borderColor=[COLOR2552160 CGColor];
    }else{
        [tfUserName.image setImage:[UIImage imageNamed:@"icon_phone"]];
        tfUserName.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [tfPassword.image setImage:[UIImage imageNamed:@"icon_mima"]];
        tfPassword.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
    }
}

@end