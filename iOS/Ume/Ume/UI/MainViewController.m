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

@implementation MainViewController

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
    }
    return self;
}

- (void)loadHttp
{
    [super loadHttp];
}

- (void)goScreening
{
    NSLog(@"筛选");
}

@end
