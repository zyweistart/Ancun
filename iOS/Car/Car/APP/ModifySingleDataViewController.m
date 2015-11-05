//
//  ModifyNickNameViewController.m
//  XinHu
//
//  Created by Start on 15/8/12.
//  Copyright (c) 2015年 AnCun. All rights reserved.
//

#import "ModifySingleDataViewController.h"

@implementation ModifySingleDataViewController

- (id)initWithType:(NSInteger)type WithValue:(NSString*)value
{
    [self setType:type];
    [self setTextValue:value];
    self=[super init];
    if(self){
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *placeholder;
    UIKeyboardType keyboardType=UIKeyboardTypeDefault;
    if(self.type==1){
        placeholder=@"输入姓名";
        [self setTitle:@"真实姓名"];
    }else if(self.type==2){
        //身份证号
        placeholder=@"输入身份证号";
        [self setTitle:@"身份证号"];
    }else if(self.type==3){
        //手机号
        placeholder=@"输入手机号";
        keyboardType=UIKeyboardTypeNumberPad;
        [self setTitle:@"编辑手机号"];
    }
    UIView *bgFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 10, 320, 40)];
    [bgFrame setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:bgFrame];
    self.tfData=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
//    [self.tfData setStyle:2];
    [self.tfData setPlaceholder:placeholder];
    [self.tfData setKeyboardType:keyboardType];
    [bgFrame addSubview:self.tfData];
    if(![@"" isEqualToString:self.textValue]){
        [self.tfData setText:self.textValue];
    }
    //
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(goSave)];
}

- (void)goSave
{
//    NSString *context=[self.tfData text];
    if(self.rDelegate && [self.rDelegate respondsToSelector:@selector(onControllerResult:requestCode:data:)]){
        [self.rDelegate onControllerResult:500 requestCode:self.type data:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end