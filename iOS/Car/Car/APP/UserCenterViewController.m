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

@implementation UserCenterViewController{
    UIImageView *header;
    XLLabel *lblName;
    XLLabel *lblInformation;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        self.dataItemArray=[NSMutableArray arrayWithArray:@[@"去电录音",@"录音笔",@"随手拍",@"录像",@"设置"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        UIImageView *headView=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 160)];
        [headView setUserInteractionEnabled:YES];
        [headView setImage:[UIImage imageNamed:@"广告"]];
        header=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        header.layer.cornerRadius=header.bounds.size.width/2;
        header.layer.masksToBounds=YES;
        [header setImage:[UIImage imageNamed:@"未上传人像"]];
        [headView addSubview:header];
        //姓名
        lblName=[[XLLabel alloc]initWithFrame:CGRectMake1(60, 10, 200, 20)];
        [lblName setText:@"黄晓明"];
        [lblName setTextColor:[UIColor whiteColor]];
        [headView addSubview:lblName];
        //信息
        lblInformation=[[XLLabel alloc]initWithFrame:CGRectMake1(60, 30, 200, 20)];
        [lblInformation setText:@"今日限行尾号:0和5"];
        [lblInformation setTextColor:[UIColor whiteColor]];
        [headView addSubview:lblInformation];
        
        XLButton *button=[[XLButton alloc]initWithFrame:CGRectMake1(60, 55, 100, 30) Name:@"完善资料" Type:3];
        [button addTarget:self action:@selector(goInformation) forControlEvents:UIControlEventTouchUpInside];
        [headView addSubview:button];
        [self.tableView setTableHeaderView:headView];
        //
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"上传中" style:UIBarButtonItemStylePlain target:self action:@selector(goUploading)];
        
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.hDownload AsynchronousDownloadWithUrl:[[User getInstance]headPic] RequestCode:500 Object:header];
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
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)goUploading
{
    NSLog(@"上传中。。。。。");
}

- (void)goInformation
{
    [self.navigationController pushViewController:[[MyInformationViewController alloc]init] animated:YES];
}

@end