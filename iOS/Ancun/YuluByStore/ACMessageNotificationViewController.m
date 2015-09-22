//
//  ACMessageNotificationViewController.m
//  Ancun
//
//  Created by Start on 15/9/21.
//
//

#import "ACMessageNotificationViewController.h"
#import "MessageNotificationDetailViewController.h"
#import "ACMessageCell.h"
#import "Message.h"

@interface ACMessageNotificationViewController ()

@end

@implementation ACMessageNotificationViewController{
    SQLiteOperate *db;
}

- (id)init{
    self = [super init];
    if (self) {
        self.title=@"消息通知";
        [self.view setBackgroundColor:[UIColor whiteColor]];
        db=[[SQLiteOperate alloc]init];
        [self buildTableView];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([db openDB]){
        if([db createTableMessageNotification]){
            self.dataItemArray=[[NSMutableArray alloc]initWithArray:[db getAllMessageNotification]];
            [self.tableView reloadData];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(65);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellReuseIdentifier=@"ACMessageCellReuseIdentifier";
    ACMessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell) {
        cell = [[ACMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    Message *message=[self.dataItemArray objectAtIndex:[indexPath row]];
    [cell.lblTitle setText:message.title];
    [cell.lblContent setText:message.content];
    [cell.lblDate setText:message.date];
    if([@"0" isEqualToString:message.read]){
        //未读
        [cell.lblTitle setTextColor:[UIColor blackColor]];
    }else{
        //已读
        [cell.lblTitle setTextColor:[UIColor grayColor]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message *message=[self.dataItemArray objectAtIndex:[indexPath row]];
    if([db openDB]){
        if([db updateMessageNotification:message]){
            MessageNotificationDetailViewController *mMessageNotificationDetailViewController=[[MessageNotificationDetailViewController alloc]initWithMessage:message];
            [self.navigationController pushViewController:mMessageNotificationDetailViewController animated:YES];
        }
    }
}

@end