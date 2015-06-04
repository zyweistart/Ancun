//
//  MessagePLViewController.m
//  Ume
//  评论
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessagePLViewController.h"

@interface MessagePLViewController ()

@end

@implementation MessagePLViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"评论";
        self.isFirstRefresh=NO;
    }
    return self;
}

@end
