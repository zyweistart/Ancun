//
//  MessageListViewController.m
//  Ume
//  消息列表
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageListViewController.h"

@interface MessageListViewController ()

@end

@implementation MessageListViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"官方消息";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
