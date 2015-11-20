//
//  BidListViewController.m
//  Car
//
//  Created by Start on 11/18/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BidListViewController.h"
#import "PhotographDetailViewController.h"
#import "CheckBoxCell.h"

@implementation BidListViewController{
    NSString *currentType;
}

- (id)initWithType:(NSString*)type
{
    currentType=type;
    self=[super init];
    if(self){
        if([@"1" isEqualToString:currentType]){
            [self setTitle:@"随手拍"];
        }else if([@"2" isEqualToString:currentType]){
            [self setTitle:@"录音笔"];
        }else{
            [self setTitle:@"录像"];
        }
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
        //
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(goOKSelected)];
    }
    return self;
}

- (void)loadHttp
{
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getSecurityList" forKey:@"act"];
    [params setObject:[User getInstance].uid forKey:@"uid"];
    [params setObject:currentType forKey:@"type"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        CheckBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[CheckBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        [cell.lblName setText:[data objectForKey:@"localName"]];
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

- (void)goOKSelected
{
    NSMutableArray *selectedData=[[NSMutableArray alloc]init];
    NSInteger sections = self.tableView.numberOfSections;
    for (int section = 0; section < sections; section++) {
        NSInteger rows =  [self.tableView numberOfRowsInSection:section];
        for (int row = 0; row < rows; row++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            CheckBoxCell *checkBoxCell=[self.tableView cellForRowAtIndexPath:indexPath];
            if([checkBoxCell.bCheckBox isSelected]){
                NSDictionary *data=[self.dataItemArray objectAtIndex:row];
                [selectedData addObject:data];
            }
        }
    }
//    for(NSDictionary *d in selectedData){
//        
//    }
}

@end