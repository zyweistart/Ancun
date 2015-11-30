//
//  BeinDangerOneCarConfirmViewController.m
//  Car
//
//  Created by Start on 11/25/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerOneCarConfirmViewController.h"
#import "CButtonGetCode.h"

@interface BeinDangerOneCarConfirmViewController ()

@end

@implementation BeinDangerOneCarConfirmViewController{
    XLTextField *mCode;
    XLTextField *mUserName;
    CButtonGetCode *bGetCode;
    CButtonAgreement *bAgreement;
}

- (id)initWithData:(NSDictionary *)data
{
    self.cData=data;
    self=[super init];
    if(self){
        [self setTitle:@"责任认定"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XLLabel *lblHead=[[XLLabel alloc]initWithFrame:CGRectMake1(20, 0, 280, 40) Text:@"当事人"];
    [lblHead setTextColor:BGCOLOR];
    [lblHead setFont:GLOBAL_FONTSIZE(15)];
    [self.view addSubview:lblHead];
    
    mUserName=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 40, 150, 40)];
    [mUserName setPlaceholder:@"请输入手机号"];
    [mUserName setKeyboardType:UIKeyboardTypePhonePad];
    [mUserName setReturnKeyType:UIReturnKeyNext];
    [mUserName setStyle:2];
    [self.view addSubview:mUserName];
    
    bGetCode=[[CButtonGetCode alloc]initWithFrame:CGRectMake1(170, 40, 140, 40) View:self.view];
    [bGetCode addTarget:self action:@selector(goGetCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bGetCode];
    
    mCode=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 90, 300, 40)];
    [mCode setPlaceholder:@"请输入验证码"];
    [mCode setKeyboardType:UIKeyboardTypeNumberPad];
    [mCode setReturnKeyType:UIReturnKeyNext];
    [mCode setStyle:2];
    [self.view addSubview:mCode];
    
    bAgreement=[[CButtonAgreement alloc]initWithFrame:CGRectMake1(10, 130, 280, 40) Name:@"我已阅读并同意《车安存车辆线上定损协议》"];
    [self.view addSubview:bAgreement];
    
    XLButton *bRegister=[[XLButton alloc]initWithFrame:CGRectMake1(10, 170, 300, 40) Name:@"提交" Type:3];
    [bRegister addTarget:self action:@selector(goRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bRegister];
    
    [mUserName setGoNextTextField:mCode];
}

- (void)goGetCode
{
    NSString *userName=[mUserName text];
    if([userName isEmpty]){
        [Common alert:@"请输入手机号"];
        return;
    }
    [bGetCode goGetCode:userName Type:@"3"];
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
        NSString *cid=[self.cData objectForKey:@"id"];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"oneCarConfirm" forKey:@"act"];
        [params setObject:userName forKey:@"mobile"];
        [params setObject:code forKey:@"code"];
        [params setObject:cid forKey:@"id"];
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
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==501){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end