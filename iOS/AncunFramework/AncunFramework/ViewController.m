//
//  ViewController.m
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ViewController.h"
#import "UserEntity.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)onClick:(id)sender {
    NSDictionary *data=@{
                         @"userName":@"zywei_624",
                         @"age":@"13",
                         @"user":@{
                             @"userName":@"wzy19890624",
                             @"age":@"27",
                             @"testName":@"testdata"
                         }
                         };
    UserEntity *user=[UserEntity buildInstanceClass:[UserEntity class] WithData:data];
    NSLog(@"%@",user.userName);
}



@end
