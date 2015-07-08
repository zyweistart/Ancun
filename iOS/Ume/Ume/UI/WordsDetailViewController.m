//
//  WordsDetailViewController.m
//  Ume
//  文字详细
//  Created by Start on 15/7/8.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "WordsDetailViewController.h"

@interface WordsDetailViewController ()

@end

@implementation WordsDetailViewController

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        self.data=data;
        NSLog(@"%@",self.data);
    }
    return self;
}

@end
