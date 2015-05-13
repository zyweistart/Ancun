//
//  LoginViewController.m
//  Ume
//
//  Created by Start on 5/13/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)init{
    self=[super init];
    if(self){
        self.isFirstRefresh=NO;
    }
    return self;
}

- (void)loadHttp
{
    [super loadHttp];
}

@end
