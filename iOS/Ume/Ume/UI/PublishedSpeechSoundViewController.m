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
    }
    return self;
}

@end
