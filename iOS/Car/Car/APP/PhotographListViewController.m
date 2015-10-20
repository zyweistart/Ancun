//
//  PhotographListViewController.m
//  Car
//
//  Created by Start on 10/20/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "PhotographListViewController.h"

@interface PhotographListViewController ()

@end

@implementation PhotographListViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"随手拍"];
        self.dataItemArray=[NSMutableArray arrayWithArray:@[@"去电录音",@"录音笔",@"随手拍",@"录像存证",@"设置"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
    }
    return self;
}

@end
