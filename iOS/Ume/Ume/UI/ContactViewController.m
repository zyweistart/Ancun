//
//  ContactViewController.m
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (id)init
{
    self=[super init];
    if(self){
        [self cTitle:@"联系人"];
        //
        UIButton *bPublished = [[UIButton alloc]init];
        [bPublished setFrame:CGRectMake1(0, 0, 50, 30)];
        [bPublished setTitle:@"确定" forState:UIControlStateNormal];
        [bPublished.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [bPublished setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [bPublished addTarget:self action:@selector(goDone:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:bPublished];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)goDone:(id)sender
{
     NSArray *fdatas=[NSArray arrayWithObjects:@"辰羽",@"爱莫能助",@"宝马",@"保时捷",@"上海大众", nil];
    [self.delegate atContactFinisih:fdatas];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
