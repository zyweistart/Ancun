//
//  PublishedSpeechSoundViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "PublishedSpeechSoundViewController.h"
#import "CLabel.h"

@interface PublishedSpeechSoundViewController ()

@end

@implementation PublishedSpeechSoundViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"发布";
        //
        UIButton *bClose = [[UIButton alloc]init];
        [bClose setFrame:CGRectMake1(0, 0, 30, 30)];
        [bClose setTitle:@"关闭" forState:UIControlStateNormal];
        [bClose.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bClose setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bClose addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bClose];
        //
        UIButton *bPublished = [[UIButton alloc]init];
        [bPublished setFrame:CGRectMake1(0, 0, 30, 30)];
        [bPublished setTitle:@"发布" forState:UIControlStateNormal];
        [bPublished.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bPublished setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bPublished addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bPublished];
        
        UIImageView *imageHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 150)];
        [imageHeader setUserInteractionEnabled:YES];
        [imageHeader setImage:[UIImage imageNamed:@"personalbg"]];
        [self.view addSubview:imageHeader];
        UIButton *bSwitch=[[UIButton alloc]initWithFrame:CGRectMake1(270, 5, 40, 30)];
        [bSwitch setTitle:@"换一张" forState:UIControlStateNormal];
        [bSwitch setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bSwitch.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [bSwitch addTarget:self action:@selector(goSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [imageHeader addSubview:bSwitch];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 60, 200, 30) Text:@"说说我的心情，寻找懂我的人"];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [imageHeader addSubview:lbl];
        
        CGFloat topHeight=568-30-64;
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, topHeight, 150, 30) Text:@"同步到：微信 QQ Sina"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [self.view addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(160, topHeight, 150, 30) Text:@"保存到心情轨迹"];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [self.view addSubview:lbl];
    }
    return self;
}

- (void)goSwitch:(id)sender
{
    NSLog(@"换一张");
}

@end
