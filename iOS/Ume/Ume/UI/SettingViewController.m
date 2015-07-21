//
//  SettingViewController.m
//  Ume
//  设置
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "SettingViewController.h"
#import "TabBarFrameViewController.h"
#import "SwitchCell.h"
#import "MessageNoticeViewController.h"
#import "UploadSettingViewController.h"
#import "AccountBindViewController.h"
#import "AboutUsViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"设置"];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"消息通知",@"使用应用锁",@"上传设置",@"账号绑定", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"检查新版本",@"关于懂我",@"用户反馈(或加官方群号:57182347)", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"清除缓存", nil]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 10, 320, 60)];
        CButton *buttonLogout=[[CButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Name:@"退出当前账号" Type:7];
        [buttonLogout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:buttonLogout];
        [self.tableView setTableFooterView:bottomView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSString *content=[[self.dataItemArray objectAtIndex:section]objectAtIndex:row];
    if(section==0&&row==1){
        static NSString *cellIdentifier = @"SWITCHCELL";
        SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[SwitchCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        [cell.textLabel setText:content];
        return cell;
    }else{
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        }
        
        [cell.textLabel setText:content];
        if(section==1&&row==0){
            //检查新版本
            [cell.detailTextLabel setText:@"v1.2"];
        }else if(section==2&&row==0){
            //清除缓存
            [cell.detailTextLabel setText:@"18.9M"];
        }else{
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    if(section==0){
        if(row==0){
            //消息通知
            [self.navigationController pushViewController:[[MessageNoticeViewController alloc]init] animated:YES];
        }else if(row==2){
            //上传设置
            [self.navigationController pushViewController:[[UploadSettingViewController alloc]init] animated:YES];
        }else if(row==3){
            //账号绑定
            [self.navigationController pushViewController:[[AccountBindViewController alloc]init] animated:YES];
        }
    }else if(section==1){
        if(row==1){
            //关于我们
            [self.navigationController pushViewController:[[AboutUsViewController alloc]init] animated:YES];
        }
    }else if(section==2){
        if(row==0){
            //清除缓存
            UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:@"确定清除缓存?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"清除缓存",nil];
            [choiceSheet showInView:self.view];
        }
    }
}

- (void)logout:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
    TabBarFrameViewController *mTabBarFrameViewController=(TabBarFrameViewController*)self.tabBarController;
    [mTabBarFrameViewController logout];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        //清除缓存
    }
}

@end