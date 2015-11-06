//
//  UploadSettingViewController.m
//  Car
//
//  Created by Start on 10/15/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "UploadSettingViewController.h"
#import "SwitchCell.h"

@interface UploadSettingViewController ()

@end

@implementation UploadSettingViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"上传设置"];
        self.dataItemArray=[[NSMutableArray alloc]initWithArray:@[@"2G/3G自动上传",@"WiFi自动上传"]];
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
    NSString *content=[self.dataItemArray objectAtIndex:row];
    [cell.textLabel setText:content];
    [cell.bSwitch addTarget:self action:@selector(goSwitch:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)goSwitch:(UIButton*)sender
{
    [sender setSelected:!sender.selected];
}

@end