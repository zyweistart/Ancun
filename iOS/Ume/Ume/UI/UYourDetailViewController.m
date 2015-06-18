//
//  UYourDetailViewController.m
//  Ume
//  懂你详细页
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "UYourDetailViewController.h"
#import "CLabel.h"

@interface UYourDetailViewController ()

@end

@implementation UYourDetailViewController

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        self.data=data;
        self.title=@"懂你详情";
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
        [image setBackgroundColor:[UIColor redColor]];
        [self.view addSubview:image];
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 320, 60)];
        [self.view addSubview:contentView];
        image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [image setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [contentView addSubview:image];
        CLabel *cTitle=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 240, 20) Text:@"lohas"];
        [contentView addSubview:cTitle];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 240, 20) Text:@"感谢您使用懂"];
        [contentView addSubview:lbl];
        contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 160, 320, 60)];
        [self.view addSubview:contentView];
        image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [image setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [contentView addSubview:image];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 240, 20) Text:@"lohas"];
        [contentView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 240, 20) Text:@"感谢您使用懂"];
        [contentView addSubview:lbl];
        contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 220, 320, 40)];
        [self.view addSubview:contentView];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 0, 100, 40) Text:@"21.5KM"];
        [contentView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(100, 0, 60, 40) Text:@"13评论"];
        [contentView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 0, 60, 40) Text:@"13赞"];
        [contentView addSubview:lbl];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 1)];
        [line setBackgroundColor:DEFAUL2COLOR];
        [contentView addSubview:line];
        line=[[UIView alloc]initWithFrame:CGRectMake1(0, 39, 320, 1)];
        [line setBackgroundColor:DEFAUL2COLOR];
        [contentView addSubview:line];
    }
    return self;
}

@end
