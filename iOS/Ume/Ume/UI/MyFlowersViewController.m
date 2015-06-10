//
//  MyFlowersViewController.m
//  Ume
//  我的鲜花墙
//  Created by Start on 15/6/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyFlowersViewController.h"
#import "MessageSXCell.h"
#import "CLabel.h"

@interface MyFlowersViewController ()

@end

@implementation MyFlowersViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"我的鲜花墙";
        self.isFirstRefresh=NO;
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 10, 300, 20) Text:@"今天获得鲜花数23朵，总数1895朵"];
        [topView addSubview:lbl];
        [self.tableView setTableHeaderView:topView];
    }
    return self;
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
