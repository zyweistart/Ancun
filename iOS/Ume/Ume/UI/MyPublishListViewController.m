//
//  MyPublishListViewController.m
//  Ume
//  我发布的
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyPublishListViewController.h"

@interface MyPublishListViewController ()

@end

@implementation MyPublishListViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"我发布的"];
        self.isFirstRefresh=NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
