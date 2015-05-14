//
//  MessageViewController.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"

#define DISNAME @"DISNAME"
#define DISVALUE @"DISVALUE"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"消息";
        
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"最懂我的",DISNAME,@"0",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"对我心动的",DISNAME,@"0",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"@我的",DISNAME,@"2",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"赞过",DISNAME,@"13",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"评论",DISNAME,@"0",DISVALUE, nil]];
        [self.dataItemArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"私信",DISNAME,@"0",DISVALUE, nil]];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [bottomView setBackgroundColor:[UIColor redColor]];
        [self.tableView setTableFooterView:bottomView];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
    NSString *name=[data objectForKey:DISNAME];
    [cell.lblTitle setText:name];
    NSString *value=[data objectForKey:DISVALUE];
    if(value!=nil&&![@""isEqualToString:value]&&![@"0"isEqualToString:value]){
        [cell.lblCount setHidden:NO];
        [cell.lblCount setText:value];
    }else{
        [cell.lblCount setHidden:YES];
    }
    return cell;
}

@end