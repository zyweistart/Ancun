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

@interface RegisterGetCheckCodeViewController ()

@end

@implementation RegisterGetCheckCodeViewController{
    UITextField *textField;
    CButton *button;
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
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(110, 0, 90, 40) Text:@"13750820210"];
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
        button=[[CButton alloc]initWithFrame:CGRectMake1(175, 5, 120, 30) Name:@"59秒后重新获取" Type:2];
        [button setTitleColor:DEFAULTITLECOLOR(120) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(get:) forControlEvents:UIControlEventTouchUpInside];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [frame addSubview:button];
    }
    return self;
}

- (void)goDone:(id)sender
{
    [self.navigationController pushViewController:[[RegisterTestViewController alloc]init] animated:YES];
}

- (void)get:(id)sender
{
    
}

@end