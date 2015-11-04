//
//  BeinDangerHistoryViewController.m
//  Car
//
//  Created by Start on 11/2/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerHistoryViewController.h"
#import "BeinDangerHistoryCell.h"

@interface BeinDangerHistoryViewController ()

@end

@implementation BeinDangerHistoryViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"历史出险"];
//        [self.dataItemArray addObjectsFromArray:@[@"去电录音",@"录音笔",@"随手拍",@"录像存证",@"设置"]];
//        [self buildTableViewWithView:self.view];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headTitle=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [headTitle setBackgroundColor:BCOLOR(244)];
    XLLabel *lblTitle=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
    [lblTitle setText:@"2016-10-20"];
    [lblTitle setTextColor:BGCOLOR];
    [lblTitle setFont:GLOBAL_FONTSIZE(15)];
    [headTitle addSubview:lblTitle];
    return headTitle;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(115);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        BeinDangerHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[BeinDangerHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        //删除子视图
        for(UIView *view in [cell.scrollView subviews]){
            [view removeFromSuperview];
        }
        //添加出出险图片
        [cell addSubImage:@"警示牌"];
        [cell addSubImage:@"双跳灯"];
        [cell addSubImage:@"警示牌"];
        [cell addSubImage:@"交警拍照片"];
        [cell addSubImage:@"交警认定责任"];
        [cell addSubImage:@"双跳灯"];
        return cell;
    }else{
        return [tableView cellForRowAtIndexPath:indexPath];
    }
}

@end