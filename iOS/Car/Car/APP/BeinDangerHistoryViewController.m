//
//  BeinDangerHistoryViewController.m
//  Car
//
//  Created by Start on 11/2/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerHistoryViewController.h"
#import "BeinDangerDetailViewController.h"
#import "BeinDangerHistoryCell.h"

@interface BeinDangerHistoryViewController ()

@end

@implementation BeinDangerHistoryViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"历史出险"];
        self.dataKeys=[[NSMutableArray alloc]init];
        self.dataResults=[[NSMutableDictionary alloc]init];
        [self buildTableViewWithView:self.view];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:0.5];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getAccidentList" forKey:@"act"];
    [params setObject:[User getInstance].uid forKey:@"uid"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *dateTime=[self.dataKeys objectAtIndex:section];
    UIView *headTitle=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [headTitle setBackgroundColor:BCOLOR(244)];
    XLLabel *lblTitle=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
    [lblTitle setText:dateTime];
    [lblTitle setTextColor:BGCOLOR];
    [lblTitle setFont:GLOBAL_FONTSIZE(15)];
    [headTitle addSubview:lblTitle];
    return headTitle;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return [self.dataKeys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key=[self.dataKeys objectAtIndex:section];
    NSArray *array=[self.dataResults objectForKey:key];
    return [array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(115);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataResults] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        BeinDangerHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[BeinDangerHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSString *key=[self.dataKeys objectAtIndex:[indexPath section]];
        NSArray *array=[self.dataResults objectForKey:key];
        NSDictionary *data=[array objectAtIndex:[indexPath row]];
        
        NSString *time=[data objectForKey:@"time"];
        NSString *dateTime=[TimeUtils timestampConvertDate13Format:@"MM-dd" WithTime:time];
        [cell.lblTime setText:dateTime];
        [cell.lblAddress setText:[data objectForKey:@"address"]];
        NSString *status=[data objectForKey:@"status"];
        [cell.lblStatus setText:[Utility getBeinDangerStatus:status]];
        //图片
        for(UIView *v in cell.scrollView.subviews){
            [v removeFromSuperview];
        }
        NSString *images=[data objectForKey:@"images"];
        NSArray *foo=[images componentsSeparatedByString:@","];
        for(NSString *u in foo){
            [cell addSubImage:u];
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.dataResults count]>0){
        NSString *key=[self.dataKeys objectAtIndex:[indexPath section]];
        NSArray *array=[self.dataResults objectForKey:key];
        NSDictionary *data=[array objectAtIndex:[indexPath row]];
        [self.navigationController pushViewController:[[BeinDangerDetailViewController alloc]initWithData:data] animated:YES];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}


- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(reqCode==500){
        if([response successFlag]){
            NSDictionary *rData=[[response resultJSON] objectForKey:@"data"];
            if(rData){
                //获取数据列表
                NSDictionary *tabData=rData;
                if(tabData){
                    if([self currentPage]==0){
                        [[self dataResults] removeAllObjects];
                    }
                    for(id data in tabData){
                        NSString *time=[data objectForKey:@"time"];
                        NSString *dateTime=[TimeUtils timestampConvertDate13Format:@"yyyy-MM" WithTime:time];
                        NSMutableArray *mutable=[self.dataResults objectForKey:dateTime];
                        if(mutable==nil){
                            mutable=[[NSMutableArray alloc]init];
                        }
                        [mutable addObject:data];
                        [self.dataResults setObject:mutable forKey:dateTime];
                    }
                    self.dataKeys = [[NSMutableArray alloc] initWithArray:[[self.dataResults allKeys]sortedArrayUsingSelector:@selector(compare:)]];
                }
            }
        }
        [self loadDone];
    }
}

@end