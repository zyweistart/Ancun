//
//  MyInformationViewController.m
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "MyInformationViewController.h"
#import "ModifySingleDataViewController.h"
#import "CameraView.h"

@interface MyInformationViewController ()

@end

@implementation MyInformationViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"我的资料"];
        self.dataItemArray=[[NSMutableArray alloc]init];
        [self.dataItemArray addObjectsFromArray:@[@"头像",@"真实姓名",@"身份证号",@"手机号"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 265)];
        [self.tableView setTableFooterView:contentView];
        [contentView setBackgroundColor:[UIColor whiteColor]];
        UIView *headTitle=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [headTitle setBackgroundColor:BCOLOR(244)];
        XLLabel *lblTitle=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
        [lblTitle setText:@"驾驶证信息"];
        [lblTitle setTextColor:BGCOLOR];
        [lblTitle setFont:GLOBAL_FONTSIZE(15)];
        [headTitle addSubview:lblTitle];
        [contentView addSubview:headTitle];
        CameraView *cameraView4=[[CameraView alloc]initWithFrame:CGRectMake1(0, 40, 320, 200)];
        [cameraView4.currentImageView setImage:[UIImage imageNamed:@"驾照底"]];
        [cameraView4 setControler:self];
        [contentView addSubview:cameraView4];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    [[cell textLabel]setText:[self.dataItemArray objectAtIndex:[indexPath row]]];
    [[cell detailTextLabel]setText:@"张二牛"];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    if(row>0){
        ModifySingleDataViewController *mModifySingleDataViewController=[[ModifySingleDataViewController alloc]initWithType:row WithValue:@""];
        [self.navigationController pushViewController:mModifySingleDataViewController animated:YES];
    }
}

@end