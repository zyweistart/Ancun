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
#import "BeinDangerHeader.h"

@interface BeinDangerDetailViewController ()

@end

@implementation BeinDangerDetailViewController{
    NSDictionary *resultJSON;
}

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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGHeight(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headTitle=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [headTitle setBackgroundColor:BCOLOR(244)];
    XLLabel *lblTitle=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 5, 300, 30)];
    if(section==0){
        NSString *time=[resultJSON objectForKey:@"time"];
        time=[TimeUtils timestampConvertDate13Format:@"yyyy年MM月dd日" WithTime:time];
        NSString *responsibility=[resultJSON objectForKey:@"responsibility"];
        NSString *content=time;
        if([@"1" isEqualToString:responsibility]){
            content=[NSString stringWithFormat:@"%@---全责",time];
        }else if([@"2" isEqualToString:responsibility]){
            content=[NSString stringWithFormat:@"%@---无责",time];
        }else if([@"3" isEqualToString:responsibility]){
            content=[NSString stringWithFormat:@"%@---同等责任",time];
        }
        [lblTitle setText:content];
    }else{
        NSString *picStatus=[resultJSON objectForKey:@"picStatus"];
        if([@"" isEqualToString:picStatus]){
            
        }else{
            
        }
        [lblTitle setText:@"初审未通过原因"];
    }
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
    if(section==0){
        return 1;
    }else{
        NSArray *priceData=[resultJSON objectForKey:@"priceData"];
        if([priceData count]>0){
            return [priceData count];
        }else{
            return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath section]==0){
        return CGHeight(180);
    }else{
        return CGHeight(45);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath section]==0){
        static NSString *cellIdentifier = @"BeinDangerHeaderCell";
        BeinDangerHeader *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[BeinDangerHeader alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSString *address=[resultJSON objectForKey:@"address"];
        [cell.lblAddress setText:address];
        //图片
        for(UIView *v in cell.scrollView.subviews){
            [v removeFromSuperview];
        }
        NSString *images=[resultJSON objectForKey:@"images"];
        NSArray *foo=[images componentsSeparatedByString:@","];
        for(NSString *u in foo){
            [cell addSubImage:u];
        }
        NSString *status=[resultJSON objectForKey:@"status"];
        if([@"1" isEqualToString:status]){
            [cell setCurrentType:1];
        }else if([@"2" isEqualToString:status]){
            [cell setCurrentType:2];
        }else{
            [cell setCurrentType:3];
        }
        return cell;
    }else{
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSArray *priceData=[resultJSON objectForKey:@"priceData"];
        if([priceData count]>0){
            NSDictionary *data=[priceData objectAtIndex:[indexPath row]];
            [cell.textLabel setText:[NSString stringWithFormat:@"%@---%@",[data objectForKey:@"name"],[data objectForKey:@"price"]]];
        }else{
          [cell.textLabel setText:@"初审中，请等待处理结果..."];
        }
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
        return cell;
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
    if([response successFlag]){
        if(reqCode==500){
            resultJSON=[[response resultJSON] objectForKey:@"data"];;
            NSLog(@"%@",resultJSON);
            [self.tableView reloadData];
        }
    }
}

@end
