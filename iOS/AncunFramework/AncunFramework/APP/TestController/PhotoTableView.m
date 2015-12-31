//
//  PhotoTableView.m
//  Witness
//
//  Created by Start on 12/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "PhotoTableView.h"
#import "PhotoTableCell.h"

@implementation PhotoTableView

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getFileList" forKey:@"iCode"];
//    [params setObject:[User getInstance].uid forKey:@"uId"];
    [params setObject:@"1" forKey:@"type"];
    [params setObject:[NSNumber numberWithInteger:self.currentPage] forKey:@"page"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest setFilterCode:@[@"-100002",@"-100003"]];
    [self.hRequest handleWithParams:params];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoTableCell *cell=(PhotoTableCell*)[self getInstanceClass:[PhotoTableCell class] Cell:indexPath];
    return [cell layoutHeight];
}

- (BaseTableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"=====");
    Photo *photo=[self.cellDataArray objectAtIndex:indexPath.row];
//    if([indexPath row]==0){
//        XLTableViewCell *cell=[self getInstanceClass:[XLTableViewCell class] Cell:indexPath];
//        [cell setCellData:photo];
//        return cell;
//    }else{
        PhotoTableCell *cell=(PhotoTableCell*)[self getInstanceClass:[PhotoTableCell class] Cell:indexPath];
        [cell setCellData:photo];
        return cell;
//    }
}

@end