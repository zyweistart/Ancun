//
//  MyImageViewController.m
//  Ume
//  我的形象
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyImageViewController.h"

@interface MyImageViewController ()

@end

@implementation MyImageViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"我的形象";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
