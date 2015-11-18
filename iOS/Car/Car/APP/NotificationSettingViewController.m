//
//  NotificationSettingViewController.m
//  Car
//
//  Created by Start on 10/15/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "NotificationSettingViewController.h"
#import "SwitchCell.h"

@interface NotificationSettingViewController ()

@end

@implementation NotificationSettingViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"消息通知"];
        self.dataItemArray=[[NSMutableArray alloc]initWithArray:@[@"平台公告",@"出险动态"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItemArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSInteger row=indexPath.row;
    if(row==0){
        [cell.bSwitch setSelected:[[User getInstance]configMessageNotice]];
    }else if(row==1){
        [cell.bSwitch setSelected:[[User getInstance]configMessageDynamic]];
    }
    NSString *content=[self.dataItemArray objectAtIndex:row];
    [cell.textLabel setText:content];
    [cell.bSwitch addTarget:self action:@selector(goSwitch:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)goSwitch:(UIButton*)sender
{
    [sender setSelected:!sender.selected];
    NSInteger tag=[sender tag];
    if(tag==0){
        [[User getInstance]setConfigMessageNotice:sender.selected];
    }else if(tag==1){
        [[User getInstance]setConfigMessageDynamic:sender.selected];
    }
}

@end