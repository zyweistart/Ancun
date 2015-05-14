//
//  PublishedSpeechSoundViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "PublishedSpeechSoundViewController.h"

@interface PublishedSpeechSoundViewController ()

@end

@implementation PublishedSpeechSoundViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"发布";
        //筛选
        UIButton *bScreening = [[UIButton alloc]init];
        [bScreening setFrame:CGRectMake1(0, 0, 30, 30)];
        [bScreening setTitle:@"返回" forState:UIControlStateNormal];
        [bScreening.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bScreening setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bScreening addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                target:nil action:nil];
        negativeSpacer.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,[[UIBarButtonItem alloc] initWithCustomView:bScreening], nil];
    }
    return self;
}

@end
