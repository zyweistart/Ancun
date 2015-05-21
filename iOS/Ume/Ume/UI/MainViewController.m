//
//  MainViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController{
    UIView *downRefresh;
}

- (id)init{
    self=[super init];
    if(self){
        self.title=@"懂你";
        self.isFirstRefresh=NO;
        //筛选
        UIButton *bScreening = [[UIButton alloc]init];
        [bScreening setFrame:CGRectMake1(0, 0, 30, 30)];
        [bScreening setTitle:@"筛选" forState:UIControlStateNormal];
        [bScreening.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bScreening setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [bScreening addTarget:self action:@selector(goScreening) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacerRight = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacerRight.width = -10;
        self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacerRight, [[UIBarButtonItem alloc] initWithCustomView:bScreening], nil];
        //筛选
        downRefresh=[[UIView alloc]initWithFrame:CGRectMake1(219, 1, 100, 120)];
        downRefresh.layer.borderWidth=1;
        downRefresh.layer.borderColor=DEFAULTITLECOLOR(190).CGColor;
        [downRefresh setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:downRefresh];
        [downRefresh setHidden:YES];
        UIButton *button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 100, 30)];
        [button1 setTitle:@"最新" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=1;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 30, 100, 30)];
        [button1 setTitle:@"最热" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=2;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 60, 100, 30)];
        [button1 setTitle:@"离我最近" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=3;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        button1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 90, 100, 30)];
        [button1 setTitle:@"只看异性" forState:UIControlStateNormal];
        [button1.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button1 setTitleColor:DEFAULTITLECOLOR(130) forState:UIControlStateNormal];
        button1.tag=4;
        [button1 addTarget:self action:@selector(hScreening:) forControlEvents:UIControlEventTouchUpInside];
        [downRefresh addSubview:button1];
        
    }
    return self;
}

- (void)loadHttp
{
    [super loadHttp];
}

- (void)goScreening
{
    [downRefresh setHidden:![downRefresh isHidden]];
}

- (void)hScreening:(UIButton*)sender
{
    NSLog(@"筛选条件%d",sender.tag);
}

@end
