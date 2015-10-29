//
//  BidViewController.m
//  Car
//
//  Created by Start on 10/15/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BidViewController.h"

@interface BidViewController ()

@end

@implementation BidViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        self.dataItemArray=[NSMutableArray arrayWithArray:@[@"去电录音",@"录音笔",@"录像",@"随手拍"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
        //
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"已申请" style:UIBarButtonItemStylePlain target:self action:@selector(goApply)];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (void)goApply
{
    
}

@end
