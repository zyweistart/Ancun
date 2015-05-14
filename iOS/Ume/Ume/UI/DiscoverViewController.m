//
//  DiscoverViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"发现";
        [self.dataItemArray addObject:@"123"];
        [self.dataItemArray addObject:@"123"];
        [self.dataItemArray addObject:@"123"];
        [self.dataItemArray addObject:@"123"];
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [topView setBackgroundColor:[UIColor redColor]];
        [self.tableView setTableHeaderView:topView];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"数据项";
    cell.detailTextLabel.text=@"数据项详细";
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
