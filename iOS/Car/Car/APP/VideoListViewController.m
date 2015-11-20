//
//  VideoListViewController.m
//  Car
//
//  Created by Start on 10/20/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "VideoListViewController.h"
#import "PhotographDetailViewController.h"
#import "VideoCell.h"
#import "XLZoomImage.h"

@interface VideoListViewController ()

@end

@implementation VideoListViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"录像存证"];
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
    }
    return self;
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getSecurityList" forKey:@"act"];
    [params setObject:[User getInstance].uid forKey:@"uid"];
    [params setObject:@"3" forKey:@"type"];
    [params setObject:[NSString stringWithFormat:@"%ld",self.currentPage] forKey:@"page"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSString *url=[data objectForKey:@"videoThumbnail"];
        [self.hDownload AsynchronousDownloadWithUrl:url RequestCode:500 Object:cell.ivIcon];
        [cell.lblName setText:[data objectForKey:@"localName"]];
        [cell.lblSize setText:[data objectForKey:@"fileSize"]];
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

        NSString *attchUrl=[data objectForKey:@"attchUrl"];
        NSLog(@"%@",attchUrl);
        XLZoomImage *zoomImage=[[XLZoomImage alloc]initWithBounds:self.navigationController.view withImageURL:attchUrl];
        [zoomImage showView];
        
//        [self.navigationController pushViewController:[[PhotographDetailViewController alloc]initWithData:data] animated:YES];
//        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        NSDictionary *data=[self.dataItemArray objectAtIndex:[indexPath row]];
        NSString *fid=[data objectForKey:@"id"];
        NSString *type=[data objectForKey:@"type"];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"delSecurity" forKey:@"act"];
        [params setObject:[User getInstance].uid forKey:@"uid"];
        [params setObject:fid forKey:@"id"];
        [params setObject:type forKey:@"type"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
        [self.hRequest setDelegate:self];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }
}

-(void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    if(reqCode==501){
        if([response successFlag]){
            if(!self.tableView.pullTableIsRefreshing) {
                self.tableView.pullTableIsRefreshing = YES;
                [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.5];
            }
        }
    }else{
        [super requestFinishedByResponse:response requestCode:reqCode];
    }
}

@end