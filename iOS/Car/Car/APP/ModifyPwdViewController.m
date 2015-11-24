//
//  ModifyPwdViewController.m
//  Car
//
//  Created by Start on 10/15/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ModifyPwdViewController.h"
#import "DesEncrypt.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController{
    XLTextField *oldPassword;
    XLTextField *newPassword;
    XLTextField *newRePassword;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"密码修改"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    oldPassword=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 20, 300, 40)];
    [oldPassword setPlaceholder:@"请输入旧密码"];
    [oldPassword setReturnKeyType:UIReturnKeyNext];
    [oldPassword setSecureTextEntry:YES];
    [oldPassword setStyle:2];
    [self.view addSubview:oldPassword];
    
    newPassword=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 70, 300, 40)];
    [newPassword setPlaceholder:@"请输入新密码(6-16字)"];
    [newPassword setReturnKeyType:UIReturnKeyNext];
    [newPassword setSecureTextEntry:YES];
    [newPassword setStyle:2];
    [self.view addSubview:newPassword];
    
    newRePassword=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 120, 300, 40)];
    [newRePassword setPlaceholder:@"请再次输入密码"];
    [newRePassword setSecureTextEntry:YES];
    [newRePassword setStyle:2];
    [self.view addSubview:newRePassword];
    
    XLButton *bModify=[[XLButton alloc]initWithFrame:CGRectMake1(10, 170, 300, 40) Name:@"修改密码" Type:3];
    [bModify addTarget:self action:@selector(goModify) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bModify];
    
    [oldPassword setGoNextTextField:newPassword];
    [newPassword setGoNextTextField:newRePassword];
}

- (void)goResignFirstResponder
{
    [oldPassword resignFirstResponder];
    [newPassword resignFirstResponder];
    [newRePassword resignFirstResponder];
}

- (void)goModify
{
    [self goResignFirstResponder];
    NSString *oldPwd=[oldPassword text];
    if([oldPwd isEmpty]){
        [Common alert:@"请输入旧密码"];
        return;
    }
    NSString *newPwd=[newPassword text];
    if([newPwd isEmpty]){
        [Common alert:@"请输入新密码"];
        return;
    }
    NSString *rePassword=[newRePassword text];
    if(![newPwd isEqualToString:rePassword]){
        [Common alert:@"两次密码不相同"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"uppwd" forKey:@"act"];
    [params setObject:[User getInstance].uid forKey:@"uid"];
    [params setObject:[User getInstance].phone forKey:@"mobile"];
    [params setObject:[DesEncrypt encryptEBCWithText:oldPwd] forKey:@"oldpwd"];
    [params setObject:[DesEncrypt encryptEBCWithText:newPwd] forKey:@"newpwd"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end