//
//  UserCenterViewController.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "UserCenterViewController.h"
#import "SettingViewController.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        self.dataItemArray=[NSMutableArray arrayWithArray:@[@"去电录音",@"录音笔",@"录像存证",@"随手拍",@"设置"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        UIView *headView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
        [headView setBackgroundColor:[UIColor redColor]];
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
    [cell.imageView setImage:[UIImage imageNamed:@"player_s"]];
    cell.textLabel.text = [self.dataItemArray objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger row=[indexPath row];
    [self.navigationController pushViewController:[[SettingViewController alloc]init] animated:YES];
}

@end
