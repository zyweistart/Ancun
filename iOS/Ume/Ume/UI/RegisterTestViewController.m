//
//  RegisterTestViewController.m
//  Ume
//
//  Created by Start on 15/6/24.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "RegisterTestViewController.h"
#import "RegisterDoneViewController.h"
#import "CLabel.h"
#import "CButton.h"

@interface RegisterTestViewController ()

@end

@implementation RegisterTestViewController{
    CLabel *lblContent;
}

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"测试心情"];
        UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rButton setFrame:CGRectMake1(0, 0, 30, 30)];
        [rButton setTitle:@"跳过" forState:UIControlStateNormal];
        [rButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [rButton setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [rButton addTarget:self action:@selector(goSkip:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:rButton];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
        [frame setBackgroundColor:COLOR2552160];
        [self.view addSubview:frame];
        lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(10, 20, 300, 140) Text:@"在岁月中跋涉，每个人都有自己的故事，看淡心境才会秀丽，看开心情才会明媚。累时歇一歇，随清风漫舞，烦时静一静，与花草凝眸，急时缓一缓，和自己微笑。"];
        [lblContent setFont:[UIFont systemFontOfSize:20]];
        [lblContent setTextColor:DEFAULTITLECOLOR(100)];
        [lblContent setNumberOfLines:0];
        [lblContent sizeToFit];
        [frame addSubview:lblContent];
        CButton *button=[[CButton alloc]initWithFrame:CGRectMake1(210, 160, 100, 30) Name:@"换一段" Type:6];
        button.layer.cornerRadius = 18;
        [button setTitleColor:DEFAULTITLECOLOR(100) forState:UIControlStateNormal];
        [frame addSubview:button];
        //录音
        UIButton *recording=[[UIButton alloc]initWithFrame:CGRectMake1(120, 250, 80.0f, 80.0f)];
        recording.layer.cornerRadius = recording.bounds.size.width/2;
        recording.layer.masksToBounds = YES;
        [recording setImage:[UIImage imageNamed:@"icon-luyin"] forState:UIControlStateNormal];
        [recording setBackgroundColor:COLOR2552160];
        [recording addTarget:self action:@selector(goRecording:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:recording];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 330, 300, 40) Text:@"按住录音"];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextColor:DEFAULTITLECOLOR(100)];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [self.view addSubview:lbl];
    }
    return self;
}

- (void)goRecording:(id)sender
{
    [self.navigationController pushViewController:[[RegisterDoneViewController alloc]init] animated:YES];
}

- (void)goSkip:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end