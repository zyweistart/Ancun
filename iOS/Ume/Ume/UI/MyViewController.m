//
//  MyViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"我的";
        [self.view setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}

@end
