//
//  SettingViewController.m
//  Ume
//  设置
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "SettingViewController.h"
#import "TabBarFrameViewController.h"
#import "CButton.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"设置";
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"消息通知",@"使用应用锁",@"上传设置",@"账号绑定", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"检查新版本",@"关于懂我",@"用户反馈(或加官方群号:57182347)", nil]];
        [self.dataItemArray addObject:[NSArray arrayWithObjects:@"清除缓存", nil]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 10, 320, 60)];
        CButton *buttonLogout=[[CButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Name:@"退出当前账号" Type:1];
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
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSInteger section=[indexPath section];
    NSInteger row=[indexPath row];
    NSString *content=[[self.dataItemArray objectAtIndex:section]objectAtIndex:row];
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

- (void)logout:(id)sender
{
    [self.tabBarController setSelectedIndex:0];
    TabBarFrameViewController *mTabBarFrameViewController=(TabBarFrameViewController*)self.tabBarController;
    [mTabBarFrameViewController logout];
}

@end