//
//  CommentViewController.m
//  Ume
//
//  Created by Start on 15/7/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        self.data=data;
        [self cTitle:@"评论"];
        
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 130)];
        [contentView setUserInteractionEnabled:YES];
        [self.view addSubview:contentView];
        self.meHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        self.meHeader.layer.cornerRadius=self.meHeader.bounds.size.width/2;
        self.meHeader.layer.masksToBounds=YES;
        self.meHeader.layer.borderWidth=1;
        self.meHeader.layer.borderColor=[[UIColor grayColor]CGColor];
        [contentView addSubview:self.meHeader];
        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@""];
        [self.lblName setFont:[UIFont systemFontOfSize:18]];
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(47, 160, 248)];
        [contentView addSubview:self.lblName];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 40, 20) Text:@""];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
        [contentView addSubview:self.lblTime];
        self.lblValue=[[CLabel alloc]initWithFrame:CGRectMake1(100, 30, 60, 20) Text:@""];
        [self.lblValue setFont:[UIFont systemFontOfSize:14]];
        [self.lblValue setTextColor:DEFAULTITLECOLOR(150)];
        [contentView addSubview:self.lblValue];
        //语音
        CGFloat width=[PlayerVoiceButton getPlayerWidthToSecond:71];
        self.player=[[PlayerVoiceButton alloc]initWithFrame:CGRectMake1(30, 60, width, 30)];
        [contentView addSubview:self.player];
        
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
