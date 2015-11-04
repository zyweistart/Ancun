//
//  UserCenterViewController.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "UserCenterViewController.h"
#import "CallListViewController.h"
#import "RecordListViewController.h"
#import "PhotographListViewController.h"
#import "VideoListViewController.h"
#import "SettingViewController.h"
#import "MyInformationViewController.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        self.dataItemArray=[NSMutableArray arrayWithArray:@[@"去电录音",@"录音笔",@"随手拍",@"录像",@"设置"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
        [headView setBackgroundColor:[UIColor redColor]];
        [headView setUserInteractionEnabled:YES];
        XLButton *button=[[XLButton alloc]initWithFrame:CGRectMake1(10, 10, 100, 40) Name:@"完善资料"];
        [button addTarget:self action:@selector(goInformation) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:button];
        [self.tableView setTableHeaderView:headView];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSString *content=[self.dataItemArray objectAtIndex:indexPath.row];
    [cell.imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_s",content]]];
    cell.textLabel.text = content;
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row==0){
        [self.navigationController pushViewController:[[CallListViewController alloc]init] animated:YES];
    }else if(row==1){
        [self.navigationController pushViewController:[[RecordListViewController alloc]init] animated:YES];
    }else if(row==2){
        [self.navigationController pushViewController:[[PhotographListViewController alloc]init] animated:YES];
    }else if(row==3){
        [self.navigationController pushViewController:[[VideoListViewController alloc]init] animated:YES];
    }else{
        [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
    }
}

- (void)goInformation
{
    [self.navigationController pushViewController:[[MyInformationViewController alloc]init] animated:YES];
}

@end