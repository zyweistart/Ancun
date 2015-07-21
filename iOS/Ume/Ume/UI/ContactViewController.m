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
        [self cNavigationRightItemType:2 Title:@"确定" action:@selector(goDone:)];
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
