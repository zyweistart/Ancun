//
//  RegisterViewController.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "RegisterViewController.h"
#import "DesEncrypt.h"
#import "CButtonGetCode.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController{
    CButtonGetCode *bGetCode;
    CButtonAgreement *bAgreement;
    XLTextField *mUserName;
    XLTextField *mCode;
    XLTextField *mPassword,*mRePassword;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"快速注册"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mUserName=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 20, 300, 40)];
    [mUserName setPlaceholder:@"请输入手机号"];
    [mUserName setKeyboardType:UIKeyboardTypePhonePad];
    [mUserName setReturnKeyType:UIReturnKeyNext];
    [mUserName setStyle:2];
    [self.view addSubview:mUserName];
    
    mCode=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 70, 150, 40)];
    [mCode setPlaceholder:@"请输入验证码"];
    [mCode setKeyboardType:UIKeyboardTypeNumberPad];
    [mCode setReturnKeyType:UIReturnKeyNext];
    [mCode setStyle:2];
    [self.view addSubview:mCode];
    
    bGetCode=[[CButtonGetCode alloc]initWithFrame:CGRectMake1(170, 70, 140, 40) View:self.view];
    [bGetCode addTarget:self action:@selector(goGetCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bGetCode];
    
    mPassword=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 120, 300, 40)];
    [mPassword setPlaceholder:@"请输入密码(6-16字)"];
    [mPassword setReturnKeyType:UIReturnKeyNext];
    [mPassword setSecureTextEntry:YES];
    [mPassword setStyle:2];
    [self.view addSubview:mPassword];
    
    mRePassword=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 170, 300, 40)];
    [mRePassword setPlaceholder:@"请再次输入密码"];
    [mRePassword setSecureTextEntry:YES];
    [mRePassword setStyle:2];
    [self.view addSubview:mRePassword];
    
    bAgreement=[[CButtonAgreement alloc]initWithFrame:CGRectMake1(10, 220, 280, 40) Name:@"我已阅读并同意《车安存车辆线上定损协议》"];
    [self.view addSubview:bAgreement];
    
    XLButton *bRegister=[[XLButton alloc]initWithFrame:CGRectMake1(10, 270, 300, 40) Name:@"注册" Type:3];
    [bRegister addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bRegister];
    
    [mUserName setGoNextTextField:mCode];
    [mCode setGoNextTextField:mPassword];
    [mPassword setGoNextTextField:mRePassword];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)goGetCode
{
    NSString *userName=[mUserName text];
    if([userName isEmpty]){
        [Common alert:@"请输入手机号"];
        return;
    }
    [bGetCode goGetCode:userName Type:@"1"];
}

- (void)goRegister
{
    [self goResignFirstResponder];
    if(bAgreement.selected){
        NSString *userName=[mUserName text];
        if([userName isEmpty]){
            [Common alert:@"请输入手机号"];
            return;
        }
        NSString *code=[mCode text];
        if([code isEmpty]){
            [Common alert:@"请输入验证码"];
            return;
        }
        NSString *password=[mPassword text];
        if([password isEmpty]){
            [Common alert:@"请输入密码"];
            return;
        }
        NSString *rePassword=[mRePassword text];
        if(![password isEqualToString:rePassword]){
            [Common alert:@"两次密码不相同"];
            return;
        }
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"addUser" forKey:@"act"];
        [params setObject:userName forKey:@"mobile"];
        [params setObject:code forKey:@"code"];
        [params setObject:[DesEncrypt encryptEBCWithText:password] forKey:@"pwd"];
        [params setObject:@"1" forKey:@"gender"];
        [params setObject:@"1" forKey:@"appver"];
        [params setObject:@"baidu" forKey:@"regfrom"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
        [self.hRequest setDelegate:self];
        [self.hRequest setView:self.view];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }else{
        [Common alert:@"请勾选定损协议"];
    }
}

- (void)goResignFirstResponder
{
    [mUserName resignFirstResponder];
    [mCode resignFirstResponder];
    [mPassword resignFirstResponder];
    [mRePassword resignFirstResponder];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==501){
            NSString *uid=[[response resultJSON]objectForKey:@"uid"];
            [[User getInstance]setUid:uid];
            AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [myDelegate windowRootViewController];
        }
    }
}

@end