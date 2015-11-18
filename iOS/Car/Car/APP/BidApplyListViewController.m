//
//  BidApplyListViewController.m
//  Car
//
//  Created by Start on 11/18/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BidApplyListViewController.h"
#import "PhotographDetailViewController.h"
#import "ApplyCell.h"

@implementation BidApplyListViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"已申请"];
    }
    return self;
}

- (void)loadHttp
{
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getNotaryList" forKey:@"act"];
    [params setObject:[User getInstance].uid forKey:@"uid"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        ApplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[ApplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSLog(@"%@",data);
        NSString *type=[data objectForKey:@"type"];
        if([@"4" isEqualToString:type]){
            //去电呼叫
            [cell.lblName setText:[data objectForKey:@"calledNo"]];
            [cell.ivType setImage:[UIImage imageNamed:@"去电录音出证"]];
        }else if([@"1" isEqualToString:type]){
            [cell.lblName setText:[data objectForKey:@"localName"]];
            [cell.ivType setImage:[UIImage imageNamed:@"随手拍出证"]];
        }else if([@"2" isEqualToString:type]){
            [cell.lblName setText:[data objectForKey:@"localName"]];
            [cell.ivType setImage:[UIImage imageNamed:@"录音笔出证"]];
        }else if([@"3" isEqualToString:type]){
            [cell.lblName setText:[data objectForKey:@"localName"]];
            [cell.ivType setImage:[UIImage imageNamed:@"录像出证"]];
        }
        [cell.lblTime setText:[data objectForKey:@"addTime"]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:[[PhotographDetailViewController alloc]initWithData:data] animated:YES];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

@end