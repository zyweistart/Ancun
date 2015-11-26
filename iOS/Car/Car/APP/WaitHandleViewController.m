//
//  WaitHandleViewController.m
//  Car
//
//  Created by Start on 11/26/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "WaitHandleViewController.h"

@implementation WaitHandleViewController

- (id)initWithData:(NSDictionary *)data
{
    self.cData=data;
    self=[super init];
    if(self){
        [self setTitle:@"等待处理"];
    }
    return self;
}

@end
