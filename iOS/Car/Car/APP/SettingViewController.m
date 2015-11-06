//
//  SettingViewController.m
//  Car
//
//  Created by Start on 10/15/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "SettingViewController.h"
#import "NotificationSettingViewController.h"
#import "UploadSettingViewController.h"
#import "ModifyPwdViewController.h"
#import "FeedbackViewController.h"
#import "AboutViewController.h"
#import "XLButton.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"设置"];
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObject:@[@"消息通知",@"上传设置",@"修改密码"]];
        [self.dataItemArray addObject:@[@"关于车安存",@"用户反馈"]];
        
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [self.tableView setTableFooterView:footView];
        XLButton *button=[[XLButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Name:@"账号退出" Type:3];
        [button addTarget:self action:@selector(goLogout) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:button];
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.dataItemArray objectAtIndex:section]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    NSArray *datas=[self.dataItemArray objectAtIndex:section];
    [cell.textLabel setText:[datas objectAtIndex:row]];
    if(section==1&&row==0){
        NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
        NSString *versionString=[infoDict objectForKey:@"CFBundleShortVersionString"];
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"v%@",versionString]];
    }
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=indexPath.row;
    NSInteger section=indexPath.section;
    if(section==0){
        if(row==0){
            [self.navigationController pushViewController:[[NotificationSettingViewController alloc]init] animated:YES];
        }else if(row==1){
            [self.navigationController pushViewController:[[UploadSettingViewController alloc]init] animated:YES];
        }else if(row==2){
            [self.navigationController pushViewController:[[ModifyPwdViewController alloc]init] animated:YES];
        }
    }else if(section==1){
        if(row==0){
            [self.navigationController pushViewController:[[AboutViewController alloc]init] animated:YES];
        }else if(row==1){
            [self.navigationController pushViewController:[[FeedbackViewController alloc]init] animated:YES];
        }
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)goLogout
{
    [User resetConfig];
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [myDelegate windowRootViewController];
}

@end