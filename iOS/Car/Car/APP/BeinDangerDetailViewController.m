//
//  BeinDangerDetailViewController.m
//  Car
//
//  Created by Start on 11/2/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerDetailViewController.h"
#import "BeinDangerHistoryViewController.h"
#import "HandleViewController.h"
#import "BeinDangerHistoryCell.h"

@interface BeinDangerDetailViewController ()

@end

@implementation BeinDangerDetailViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"出险详情"];
        self.dataItemArray =[[NSMutableArray alloc]init];
        [self buildTableViewWithView:self.view];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
        //
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"历史出险" style:UIBarButtonItemStylePlain target:self action:@selector(goHistory)];
    }
    return self;
}

- (id)initWithData:(NSDictionary *)data
{
    self.cData=data;
    return [self init];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.cData){
        NSString *cid=[self.cData objectForKey:@"id"];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"getAccidentInfo" forKey:@"act"];
        [params setObject:[User getInstance].uid forKey:@"uid"];
        [params setObject:cid forKey:@"id"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
        [self.hRequest setDelegate:self];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }
}

- (void)loadHttp
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getAccidentList" forKey:@"act"];
    [params setObject:[User getInstance].uid forKey:@"uid"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
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
    UIView *headTitle=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [headTitle setBackgroundColor:BCOLOR(244)];
    XLLabel *lblTitle=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
    [lblTitle setText:@"2015年11月04日"];
    [lblTitle setTextColor:BGCOLOR];
    [lblTitle setFont:GLOBAL_FONTSIZE(15)];
    [headTitle addSubview:lblTitle];
    return headTitle;
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(115);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        BeinDangerHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[BeinDangerHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)goHistory
{
    [self.navigationController pushViewController:[[BeinDangerHistoryViewController alloc]init] animated:YES];
}

- (void)goRePai
{
    HandleViewController *mHandleViewController=[[HandleViewController alloc]initWithData:nil];
//    [mHandleViewController setMapData:self.mapData];
//    [mHandleViewController setInsuranceData:self.insuranceData];
    //    [mHandleViewController setInsuranceOData:self.insuranceOData];
    [self.navigationController pushViewController:mHandleViewController animated:YES];
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    NSLog(@"%@",[response resultJSON]);
    if([response successFlag]){
        if(reqCode==500){
            
        }
    }
}

@end
