//
//  RegisterDoneViewController.m
//  Ume
//
//  Created by Start on 15/6/24.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "RegisterDoneViewController.h"
#import "CLabel.h"
#import "CButton.h"

@interface RegisterDoneViewController ()

@end

@implementation RegisterDoneViewController{
    CLabel *lblMood;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"测试心情"];
        //
        [self cNavigationRightItemType:2 Title:@"跳过" action:@selector(goDone:)];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(130, 60, 60, 60)];
        [image setImage:[UIImage imageNamed:@"qx-tianmi"]];
        [self.view addSubview:image];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(55, 135, 80, 35) Text:@"今天情绪为"];
        [lbl setTextColor:DEFAULTITLECOLOR(150)];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [self.view addSubview:lbl];
        lblMood=[[CLabel alloc]initWithFrame:CGRectMake1(135, 130, 40, 40) Text:@"开心"];
        [lblMood setTextColor:COLOR2552160];
        [lblMood setFont:[UIFont systemFontOfSize:22]];
        [self.view addSubview:lblMood];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(175, 135, 100, 35) Text:@",约会正当时！"];
        [lbl setTextColor:DEFAULTITLECOLOR(150)];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [self.view addSubview:lbl];
        
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(20, 230, 280, 25) Text:@"微信、QQ、sina关注果冻社区微信号，"];
        [lbl setTextColor:DEFAULTITLECOLOR(150)];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(20, 255, 280, 25) Text:@"可获得话费奖励，赶紧行动哦！"];
        [lbl setTextColor:DEFAULTITLECOLOR(150)];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:lbl];
        CButton *button=[[CButton alloc]initWithFrame:CGRectMake1(10, 330, 300, 40) Name:@"分享" Type:2];
        [button addTarget:self action:@selector(goShare:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:DEFAULTITLECOLOR(100) forState:UIControlStateNormal];
        [self.view addSubview:button];
    }
    return self;
}

- (void)goDone:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)goShare:(id)sender
{
    NSLog(@"分享");
}

@end