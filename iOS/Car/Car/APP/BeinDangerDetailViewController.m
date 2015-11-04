//
//  BeinDangerDetailViewController.m
//  Car
//
//  Created by Start on 11/2/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerDetailViewController.h"
#import "BeinDangerHistoryViewController.h"

@interface BeinDangerDetailViewController ()

@end

@implementation BeinDangerDetailViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"出险详情"];
        //
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"历史出险" style:UIBarButtonItemStylePlain target:self action:@selector(goHistory)];
    }
    return self;
}

- (void)goHistory
{
    [self.navigationController pushViewController:[[BeinDangerHistoryViewController alloc]init] animated:YES];
}

@end
