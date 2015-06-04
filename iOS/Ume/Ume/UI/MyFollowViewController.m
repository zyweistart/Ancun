//
//  MyFollowViewController.m
//  Ume
//  我的关注
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyFollowViewController.h"

@interface MyFollowViewController ()

@end

@implementation MyFollowViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"我的关注";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
