//
//  RegisterGetCheckCodeViewController.m
//  Ume
//
//  Created by Start on 15/6/24.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "RegisterGetCheckCodeViewController.h"
#import "RegisterTestViewController.h"
#import "CLabel.h"
#import "CButton.h"

#define SECOND 60

@interface RegisterGetCheckCodeViewController ()

@end

@implementation RegisterGetCheckCodeViewController{
    UITextField *textField;
    CButton *button;
    int second;
    NSTimer *verificationCodeTime;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"注册"];
        UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rButton setFrame:CGRectMake1(0, 0, 30, 30)];
        [rButton setTitle:@"完成" forState:UIControlStateNormal];
        [rButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [rButton setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [rButton addTarget:self action:@selector(goDone:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:rButton];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40) Text:@"验证码已发送到"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [self.view addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(110, 0, 90, 40) Text:[[User Instance]phone]];
        [lbl setTextColor:DEFAULTITLECOLORRGB(163,200,236)];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [self.view addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(200, 0, 100, 40) Text:@",请输入验证码"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [self.view addSubview:lbl];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(10, 40, 300, 40)];
        frame.layer.cornerRadius = 5;
        frame.layer.masksToBounds = YES;
        frame.layer.borderWidth=1;
        frame.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [self.view addSubview:frame];
        textField=[[UITextField alloc]initWithFrame:CGRectMake1(10, 0, 160, 40)];
        [textField setPlaceholder:@"请输入验证码"];
        [textField setTextColor:DEFAULTITLECOLOR(190)];
        [textField setFont:[UIFont systemFontOfSize:16]];
        [textField setTextAlignment:NSTextAlignmentLeft];
        [textField setClearButtonMode:UITextFieldViewModeWhileEditing];
        [frame addSubview:textField];
        button=[[CButton alloc]initWithFrame:CGRectMake1(175, 5, 120, 30) Name:@"发送校验码" Type:2];
        [button setTitleColor:DEFAULTITLECOLOR(120) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(get:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [frame addSubview:button];
    }
    return self;
}

- (void)goDone:(id)sender
{
    NSString *code=[textField text];
    if([@"" isEqualToString:code]){
        [Common alert:@"请输入校验码"];
        return;
    }
    [self.navigationController pushViewController:[[RegisterTestViewController alloc]init] animated:YES];
}

- (void)get:(id)sender
{
    NSString *phone=[[User Instance]phone];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:phone forKey:@"mobile"];
    [params setObject:@"sendcode" forKey:@"act"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setRequestCode:502];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest handle:nil requestParams:params];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            second=SECOND;
            verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }
    }
}

- (void)updateTimer{
    --second;
    if(second==0){
        [button setEnabled:YES];
        [button setTitle:@"发送校验码" forState:UIControlStateNormal];
        if(verificationCodeTime){
            [verificationCodeTime invalidate];
        }
    }else{
        [button setEnabled:NO];
        [button setTitle:[NSString stringWithFormat:@"%d秒后重新获取",second] forState:UIControlStateNormal];
    }
}

@end