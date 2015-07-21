//
//  MessageNoticeViewController.m
//  Ume
//
//  Created by Start on 15/7/20.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageNoticeViewController.h"
#import "SwitchCell.h"

@interface MessageNoticeViewController ()

@end

@implementation MessageNoticeViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"消息通知"];
        [self.dataItemArray addObject:@"最懂我的"];
        [self.dataItemArray addObject:@"@我的"];
        [self.dataItemArray addObject:@"赞过"];
        [self.dataItemArray addObject:@"评论"];
        [self.dataItemArray addObject:@"私信"];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    static NSString *cellIdentifier = @"SWITCHCELL";
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *content=[self.dataItemArray objectAtIndex:row];
    [cell.textLabel setText:content];
    return cell;
}

@end
