//
//  AccountBindViewController.m
//  Ume
//
//  Created by Start on 15/7/21.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "AccountBindViewController.h"
#import "ButtonCell.h"

@interface AccountBindViewController ()

@end

@implementation AccountBindViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"上传设置"];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"新浪微博",@"QQ",@"微信", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"手机号", nil]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headFrame=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    CLabel *lblTitle=[[CLabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Text:@""];
    [lblTitle setFont:[UIFont systemFontOfSize:16]];
    [headFrame addSubview:lblTitle];
    if(section==0){
        [lblTitle setText:@"绑定第三方账号，可用该账号快速登录和同步分享"];
    }else{
        [lblTitle setText:@"绑定手机号，可找到更多熟悉朋友"];
    }
    return headFrame;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"BUTTONCELL";
    ButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[ButtonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(row==2){
        [cell.rightButton setType:2];
    }
    NSString *content=[[self.dataItemArray objectAtIndex:section]objectAtIndex:row];
    [cell.textLabel setText:content];
    return cell;
}

@end
