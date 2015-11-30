//
//  ForgetPasswordViewController.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "DesEncrypt.h"
#import "CButtonGetCode.h"
#define GLOBAL_GETCODE_STRING @"%ds后重发"
#define GLOBAL_SECOND 60

@interface ForgetPasswordViewController ()

@end

@implementation ForgetPasswordViewController{
    UIView *viewFrame1;
    UIView *viewFrame2;
    XLTextField *mUserName;
    XLTextField *mCode;
    XLTextField *mPassword;
    CButtonGetCode *bGetCode;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"找回密码"];
        //
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(goDone)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewFrame1=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:viewFrame1];
    viewFrame2=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:viewFrame2];
    [viewFrame1 setHidden:NO];
    [viewFrame2 setHidden:YES];
    
    XLLabel *lbl=[[XLLabel alloc]initWithFrame:CGRectMake1(20, 0, 280, 40) Text:@"密码重置信息将发送到您的手机上"];
    [viewFrame1 addSubview:lbl];
    
    mUserName=[[XLTextField alloc]initWithFrame:CGRectMake1(20, 40, 280, 40)];
    [mUserName setPlaceholder:@"请输入手机号"];
    [mUserName setStyle:2];
    [mUserName setKeyboardType:UIKeyboardTypePhonePad];
    [viewFrame1 addSubview:mUserName];
    
    XLButton *bResetPwd=[[XLButton alloc]initWithFrame:CGRectMake1(20, 90, 280, 40) Name:@"重置密码" Type:3];
    [bResetPwd addTarget:self action:@selector(goGetCode) forControlEvents:UIControlEventTouchUpInside];
    [viewFrame1 addSubview:bResetPwd];
    
    mCode=[[XLTextField alloc]initWithFrame:CGRectMake1(20, 10, 280, 40)];
    [mCode setPlaceholder:@"请输入短信验证码"];
    [mCode setStyle:2];
    [mCode setKeyboardType:UIKeyboardTypeNumberPad];
    [viewFrame2 addSubview:mCode];
    
    mPassword=[[XLTextField alloc]initWithFrame:CGRectMake1(20, 60, 280, 40)];
    [mPassword setPlaceholder:@"请输入6-16位字符新密码"];
    [mPassword setStyle:2];
    [mPassword setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [viewFrame2 addSubview:mPassword];
    
    bGetCode=[[CButtonGetCode alloc]initWithFrame:CGRectMake1(20, 110, 280, 40) View:self.view];
    [bGetCode addTarget:self action:@selector(goGetCode) forControlEvents:UIControlEventTouchUpInside];
    [viewFrame2 addSubview:bGetCode];
    
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
    [bGetCode goGetCode:userName Type:@"2"];
    [viewFrame1 setHidden:YES];
    [viewFrame2 setHidden:NO];
}

- (void)goDone
{
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
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    [self.hRequest setDelegate:self];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"resetPwd" forKey:@"act"];
    [params setObject:userName forKey:@"mobile"];
    [params setObject:code forKey:@"code"];
    [params setObject:[DesEncrypt encryptEBCWithText:password] forKey:@"pwd"];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest setView:self.view];
    [self.hRequest handleWithParams:params];
}

- (void)goResignFirstResponder
{
    [mUserName resignFirstResponder];
    [mCode resignFirstResponder];
    [mPassword resignFirstResponder];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            NSString *uid=[[response resultJSON]objectForKey:@"uid"];
            [[User getInstance]setUid:uid];
            AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            [myDelegate windowRootViewController];
        }
    }
}

@end