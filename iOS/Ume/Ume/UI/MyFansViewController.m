//
//  MyFansViewController.m
//  Ume
//  我的粉丝
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyFansViewController.h"
#import "MessageSXCell.h"

@interface MyFansViewController ()

@end

@implementation MyFansViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"我的粉丝";
        self.isFirstRefresh=NO;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(60);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    MessageSXCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[MessageSXCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
