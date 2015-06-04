//
//  MoodTrackViewController.m
//  Ume
//  心情轨迹
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MoodTrackViewController.h"

@interface MoodTrackViewController ()

@end

@implementation MoodTrackViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"心情轨迹";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
