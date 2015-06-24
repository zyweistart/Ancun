//
//  RegisterTestViewController.m
//  Ume
//
//  Created by Start on 15/6/24.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "RegisterTestViewController.h"
#import "RegisterDoneViewController.h"

@interface RegisterTestViewController ()

@end

@implementation RegisterTestViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"测试心情"];
        UIButton *rButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [rButton setFrame:CGRectMake1(0, 0, 30, 30)];
        [rButton setTitle:@"跳过" forState:UIControlStateNormal];
        [rButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [rButton setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        [rButton addTarget:self action:@selector(goDone:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:rButton];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
        [frame setBackgroundColor:COLOR2552160];
        [self.view addSubview:frame];
    }
    return self;
}

- (void)goDone:(id)sender
{
//    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController pushViewController:[[RegisterDoneViewController alloc]init] animated:YES];
}

@end