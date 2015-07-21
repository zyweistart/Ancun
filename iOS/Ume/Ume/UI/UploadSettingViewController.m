//
//  UploadSettingViewController.m
//  Ume
//
//  Created by Start on 15/7/21.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "UploadSettingViewController.h"
#import "SwitchCell.h"

@interface UploadSettingViewController ()

@end

@implementation UploadSettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"上传设置"];
        [self.dataItemArray addObject:@"3G/4G自动上传"];
        [self.dataItemArray addObject:@"Wifi自动上传"];
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
