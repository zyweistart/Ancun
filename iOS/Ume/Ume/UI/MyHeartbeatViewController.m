//
//  MyHeartbeatViewController.m
//  Ume
//  我的心动
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyHeartbeatViewController.h"

@interface MyHeartbeatViewController ()

@end

@implementation MyHeartbeatViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"我的心动"];
        self.isFirstRefresh=NO;
    }
    return self;
}
@end
