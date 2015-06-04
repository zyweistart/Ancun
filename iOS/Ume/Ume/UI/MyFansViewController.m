//
//  MyFansViewController.m
//  Ume
//  我的粉丝
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyFansViewController.h"

@interface MyFansViewController ()

@end

@implementation MyFansViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"我的粉丝";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
