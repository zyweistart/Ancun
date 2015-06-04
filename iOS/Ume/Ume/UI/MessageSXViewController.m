//
//  MessageSXViewController.m
//  Ume
//  私信
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageSXViewController.h"

@interface MessageSXViewController ()

@end

@implementation MessageSXViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"私信";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
