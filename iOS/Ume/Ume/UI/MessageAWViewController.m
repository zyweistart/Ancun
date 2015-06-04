//
//  MessageAWViewController.m
//  Ume
//  @我的
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageAWViewController.h"

@interface MessageAWViewController ()

@end

@implementation MessageAWViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"@我的";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
