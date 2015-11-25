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
#import "CameraViewCell.h"

@interface BeinDangerDetailViewController ()

@end

@implementation BeinDangerDetailViewController{
    NSDictionary *resultJSON;
    XLLabel *lblInformation;
    XLButton *bSubmit;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"出险详情"];
        self.dataItemArray =[[NSMutableArray alloc]init];
        [self buildTableViewWithView:self.view];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [self.tableView setTableFooterView:footView];
        
        lblInformation=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
        [lblInformation setTextAlignment:NSTextAlignmentCenter];
        [footView addSubview:lblInformation];
        
        bSubmit=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(10), self.tableView.bounds.size.height-CGHeight(50)-64, CGWidth(300), CGHeight(40)) Name:@"提交" Type:3];
//        [self.view addSubview:bSubmit];
        
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
        [self.hRequest setView:self.view];
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
    XLLabel *lblTitle=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 5, 200, 30)];
    if(section==0){
        NSString *time=[resultJSON objectForKey:@"time"];
        time=[TimeUtils timestampConvertDate13Format:@"yyyy年MM月dd日" WithTime:time];
        [lblTitle setText:time];
    }else{
        NSString *status=[resultJSON objectForKey:@"status"];
        if([@"1" isEqualToString:status]){
            [lblTitle setText:@"初审未通过原因"];
        }else if([@"2" isEqualToString:status]){
            [lblTitle setText:@"责任认定未通过原因"];
        }else if([@"3" isEqualToString:status]){
            [lblTitle setText:@"保险定损中"];
        }else if([@"6" isEqualToString:status]){
            NSString *priceCount=[resultJSON objectForKey:@"priceCount"];
            [lblTitle setText:[NSString stringWithFormat:@"保险定损共%@元，已确认",priceCount]];
        }else if([@"8" isEqualToString:status]){
            [lblTitle setText:@"定损需补拍以下局部照"];
        }else{
        }
    }
    [lblTitle setTextColor:BGCOLOR];
    [lblTitle setFont:GLOBAL_FONTSIZE(14)];
    [headTitle addSubview:lblTitle];
    XLLabel *lblInfo=[[XLLabel alloc]initWithFrame:CGRectMake1(210, 5, 100, 30)];
    [lblInfo setTextColor:BGCOLOR];
    [lblInfo setFont:GLOBAL_FONTSIZE(14)];
    [lblInfo setTextAlignment:NSTextAlignmentRight];
    [lblInfo setHidden:YES];
    [headTitle addSubview:lblInfo];
    if(section==0){
        NSString *status=[resultJSON objectForKey:@"status"];
        if(![@"1" isEqualToString:status]){
            //多车事故
            NSString *responsibility=[resultJSON objectForKey:@"responsibility"];
            if([@"1" isEqualToString:responsibility]){
                [lblInfo setText:@"本人为全部责任"];
                [lblInfo setHidden:NO];
            }else if([@"2" isEqualToString:responsibility]){
                [lblInfo setText:@"本人为无责"];
                [lblInfo setHidden:NO];
            }else if([@"3" isEqualToString:responsibility]){
                [lblInfo setText:@"本人为同等责任"];
                [lblInfo setHidden:NO];
            }
        }
    }
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
        NSString *status=[resultJSON objectForKey:@"status"];
        if([@"1" isEqualToString:status]||[@"2" isEqualToString:status]||[@"3" isEqualToString:status]||[@"4" isEqualToString:status]||[@"5" isEqualToString:status]){
            NSArray *picData=[resultJSON objectForKey:@"picData"];
            return [picData count];
        }else if([@"6" isEqualToString:status]){
            NSArray *priceData=[resultJSON objectForKey:@"priceData"];
            return [priceData count];
        }else if([@"8" isEqualToString:status]){
            return 1;
        }else{
            return 0;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([indexPath section]==0){
        return CGHeight(180);
    }else{
        NSString *status=[resultJSON objectForKey:@"status"];
        if([@"8" isEqualToString:status]){
            NSArray *arr=[resultJSON objectForKey:@"damageData"];
            return CGHeight(([arr count]/2+[arr count]%2)*132+60);
        }else{
            return CGHeight(45);
        }
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
        [cell.lblAddress setText:[NSString stringWithFormat:@"事故地址:%@",address]];
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
        NSString *status=[resultJSON objectForKey:@"status"];
        if([@"1" isEqualToString:status]||[@"2" isEqualToString:status]||[@"3" isEqualToString:status]||[@"4" isEqualToString:status]||[@"5" isEqualToString:status]){
            NSArray *picData=[resultJSON objectForKey:@"picData"];
            static NSString *cellIdentifier = @"PICSAMPLECell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
            NSDictionary *data=[picData objectAtIndex:[indexPath row]];
            NSString *url=[data objectForKey:@"pic"];
            [self.hDownload AsynchronousDownloadWithUrl:url RequestCode:500 Object:cell.imageView];
            [cell.textLabel setText:[data objectForKey:@"reason"]];
            [cell.textLabel setTextColor:BCOLOR(150)];
            return cell;
        }else if([@"6" isEqualToString:status]){
            NSArray *priceData=[resultJSON objectForKey:@"priceData"];
            static NSString *cellIdentifier = @"PRICESAMPLECell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            }
            NSDictionary *data=[priceData objectAtIndex:[indexPath row]];
            [cell.textLabel setText:[data objectForKey:@"name"]];
            [cell.textLabel setTextColor:BCOLOR(150)];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@元",[data objectForKey:@"price"]]];
            [cell.textLabel setTextColor:BCOLOR(150)];
            return cell;
        }else if([@"8" isEqualToString:status]){
            static NSString *cellIdentifier = @"CAMERASAMPLECell";
            NSArray *arr=[resultJSON objectForKey:@"damageData"];
            CameraViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[CameraViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier WithArray:arr Controller:self];
            }
            return cell;
        }else{
            return nil;
        }
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
            NSLog(@"%@",[response resultJSON]);
            NSString *status=[resultJSON objectForKey:@"status"];
            if([@"1" isEqualToString:status]){
                [lblInformation setText:@"初审中,请等待处理结果..."];
            }else if([@"3" isEqualToString:status]){
                [lblInformation setText:@"保险定损中,请等待处理结果..."];
            }else if([@"6" isEqualToString:status]){
                [lblInformation setText:@"请将车辆开到指定修理点，完成理赔、修理"];
            }else if([@"8" isEqualToString:status]){
                [bSubmit setTitle:@"提交照片" forState:UIControlStateNormal];
            }
            NSArray *picData=[resultJSON objectForKey:@"picData"];
            if([picData count]>0){
                [lblInformation setHidden:YES];
            }
            [self.tableView reloadData];
        }
    }
}

@end
