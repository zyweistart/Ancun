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
#import "PaiCell.h"
#import "ReUploadAccidentImageViewController.h"
#import "BeinDangerOneCarConfirmViewController.h"

@interface BeinDangerDetailViewController ()

@end

@implementation BeinDangerDetailViewController{
    UIView *buttonView1;
    UIView *buttonView2;
    XLButton *bAgreement;
    XLButton *bSubmitRe;
    XLButton *bSubmitRePic;
    XLLabel *lblInformation;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"出险详情"];
    }
    return self;
}

- (id)initWithData:(NSDictionary *)data
{
    self.cData=data;
    return [self init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataItemArray =[[NSMutableArray alloc]init];
    [self buildTableViewWithView:self.view];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *footView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 85)];
    [self.tableView setTableFooterView:footView];
    
    buttonView1=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 50)];
    [footView addSubview:buttonView1];
    
    buttonView2=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 85)];
    [footView addSubview:buttonView2];
    
    lblInformation=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
    [lblInformation setTextAlignment:NSTextAlignmentCenter];
    [buttonView1 addSubview:lblInformation];
    
    bAgreement=[[XLButton alloc]initWithFrame:CGRectMake1(10, 0, 300, 40) Name:@"我已阅读并同意《车安存车车辆线上定损协议》" Type:6];
    [bAgreement.titleLabel setFont:GLOBAL_FONTSIZE(13)];
    [bAgreement setTitleColor:BCOLOR(150) forState:UIControlStateNormal];
    [bAgreement setImage:[UIImage imageNamed:@"单勾未选"] forState:UIControlStateNormal];
    [bAgreement setImage:[UIImage imageNamed:@"单勾选中"] forState:UIControlStateSelected];
    [bAgreement setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
    [bAgreement addTarget:self action:@selector(goAgreement) forControlEvents:UIControlEventTouchUpInside];
    [buttonView2 addSubview:bAgreement];
    [bAgreement setSelected:YES];
    
    XLButton *bSubmit=[[XLButton alloc]initWithFrame:CGRectMake1(10,40,145,40) Name:@"线下定损" Type:2];
    [bSubmit addTarget:self action:@selector(goOfflineConfirm) forControlEvents:UIControlEventTouchUpInside];
    [buttonView2 addSubview:bSubmit];
    
    bSubmit=[[XLButton alloc]initWithFrame:CGRectMake1(160,40,145,40) Name:@"线上定损" Type:3];
    [bSubmit addTarget:self action:@selector(goOnlineConfirm) forControlEvents:UIControlEventTouchUpInside];
    [buttonView2 addSubview:bSubmit];
    
    bSubmitRePic=[[XLButton alloc]initWithFrame:CGRectMake1(10,5,300,40) Name:@"重新拍摄" Type:3];
    [bSubmitRePic addTarget:self action:@selector(goRePai) forControlEvents:UIControlEventTouchUpInside];
    [buttonView1 addSubview:bSubmitRePic];
    
    bSubmitRe=[[XLButton alloc]initWithFrame:CGRectMake1(10,5,300,40) Name:@"重新认定" Type:3];
    [bSubmitRe addTarget:self action:@selector(goReCarConfirm) forControlEvents:UIControlEventTouchUpInside];
    [buttonView1 addSubview:bSubmitRe];
    
    self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
    //
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"历史出险" style:UIBarButtonItemStylePlain target:self action:@selector(goHistory)];
    
    [buttonView1 setHidden:YES];
    [bSubmitRe setHidden:YES];
    [bSubmitRePic setHidden:YES];
    [lblInformation setHidden:YES];
    [buttonView2 setHidden:YES];
    NSString *status=[self.cData objectForKey:@"status"];
    if([@"1" isEqualToString:status]){
        [buttonView1 setHidden:NO];
        [lblInformation setHidden:NO];
        NSArray *picData=[self.cData objectForKey:@"picData"];
        if([picData count]>0){
            [buttonView1 setHidden:NO];
            [bSubmitRePic setHidden:NO];
        }else{
            [lblInformation setText:@"初审中,请等待处理结果..."];
        }
    }else if([@"2" isEqualToString:status]){
        [buttonView1 setHidden:NO];
        [bSubmitRe setHidden:NO];
    }else if([@"3" isEqualToString:status]){
        [buttonView1 setHidden:NO];
        [lblInformation setHidden:NO];
        [lblInformation setText:@"保险定损中,请等待处理结果..."];
    }else if([@"6" isEqualToString:status]){
        [buttonView1 setHidden:NO];
        [lblInformation setHidden:NO];
        [lblInformation setText:@"请将车辆开到指定修理点，完成理赔、修理"];
    }else if([@"7" isEqualToString:status]){
        [buttonView2 setHidden:NO];
    }
    [self.tableView reloadData];
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
        NSString *time=[self.cData objectForKey:@"time"];
        time=[TimeUtils timestampConvertDate13Format:@"yyyy年MM月dd日" WithTime:time];
        [lblTitle setText:time];
    }else{
        NSString *status=[self.cData objectForKey:@"status"];
        if([@"1" isEqualToString:status]){
            [lblTitle setText:@"初审未通过原因"];
        }else if([@"2" isEqualToString:status]){
            [lblTitle setText:@"责任认定未通过原因"];
        }else if([@"3" isEqualToString:status]){
            [lblTitle setText:@"保险定损中"];
        }else if([@"6" isEqualToString:status]){
            NSString *remark=[self.cData objectForKey:@"remark"];
            if([@"1" isEqualToString:remark]){
                [lblTitle setText:@"保险定损结案"];
            }else{
                NSString *priceCount=[self.cData objectForKey:@"priceCount"];
                [lblTitle setText:[NSString stringWithFormat:@"保险定损共%@元，已确认",priceCount]];
            }
        }else if([@"7" isEqualToString:status]){
            NSString *priceCount=[self.cData objectForKey:@"priceCount"];
            [lblTitle setText:[NSString stringWithFormat:@"保险定损共%@元",priceCount]];
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
        NSString *status=[self.cData objectForKey:@"status"];
        if(![@"1" isEqualToString:status]){
            //多车事故
            NSString *responsibility=[self.cData objectForKey:@"responsibility"];
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
        NSString *status=[self.cData objectForKey:@"status"];
        if([@"1" isEqualToString:status]||[@"2" isEqualToString:status]||[@"3" isEqualToString:status]||[@"4" isEqualToString:status]||[@"5" isEqualToString:status]){
            NSArray *picData=[self.cData objectForKey:@"picData"];
            return [picData count];
        }else if([@"6" isEqualToString:status]||[@"7" isEqualToString:status]){
            if([@"6" isEqualToString:status]){
                NSString *remark=[self.cData objectForKey:@"remark"];
                if([@"1" isEqualToString:remark]){
                    //线下定损
                    return 0;
                }
            }
            NSArray *priceData=[self.cData objectForKey:@"priceData"];
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
        NSString *status=[self.cData objectForKey:@"status"];
        if([@"8" isEqualToString:status]){
            NSArray *arr=[self.cData objectForKey:@"damageData"];
            NSInteger count=[arr count];
            return CGHeight((count/2+count%2)*132+60);
        }else if([@"1" isEqualToString:status]){
            return CGHeight(70);
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
        NSString *address=[self.cData objectForKey:@"address"];
        [cell.lblAddress setText:[NSString stringWithFormat:@"事故地址:%@",address]];
        //图片
        for(UIView *v in cell.scrollView.subviews){
            [v removeFromSuperview];
        }
        NSString *images=[self.cData objectForKey:@"images"];
        NSArray *foo=[images componentsSeparatedByString:@","];
        for(NSString *u in foo){
            [cell addSubImage:u];
        }
        NSString *status=[self.cData objectForKey:@"status"];
        if([@"1" isEqualToString:status]){
            [cell setCurrentType:1];
        }else if([@"2" isEqualToString:status]){
            [cell setCurrentType:2];
        }else{
            [cell setCurrentType:3];
        }
        return cell;
    }else{
        NSString *status=[self.cData objectForKey:@"status"];
        if([@"1" isEqualToString:status]||[@"2" isEqualToString:status]||[@"3" isEqualToString:status]||[@"4" isEqualToString:status]||[@"5" isEqualToString:status]){
            NSArray *picData=[self.cData objectForKey:@"picData"];
            static NSString *cellIdentifier = @"PICSAMPLECell";
            PaiCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[PaiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            }
            NSDictionary *data=[picData objectAtIndex:[indexPath row]];
            NSString *url=[data objectForKey:@"pic"];
            [self.hDownload AsynchronousDownloadWithUrl:url RequestCode:500 Object:cell.ivView];
            [cell.lblTitle setText:[data objectForKey:@"reason"]];
            return cell;
        }else if([@"6" isEqualToString:status]||[@"7" isEqualToString:status]){
            NSArray *priceData=[self.cData objectForKey:@"priceData"];
            static NSString *cellIdentifier = @"PRICESAMPLECell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
            }
            NSDictionary *data=[priceData objectAtIndex:[indexPath row]];
            [cell.textLabel setText:[data objectForKey:@"name"]];
            [cell.detailTextLabel setText:[NSString stringWithFormat:@"%@元",[data objectForKey:@"price"]]];
            [cell.textLabel setTextColor:BCOLOR(150)];
            [cell.detailTextLabel setTextColor:[UIColor orangeColor]];
            return cell;
        }else if([@"8" isEqualToString:status]){
            static NSString *cellIdentifier = @"CAMERASAMPLECell";
            NSArray *arr=[self.cData objectForKey:@"damageData"];
            CameraViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell) {
                cell = [[CameraViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier WithArray:arr Controller:self];
            }
            [cell setCData:self.cData];
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

- (void)goAgreement
{
    [bAgreement setSelected:!bAgreement.isSelected];
}

- (void)goRePai
{
    [self.navigationController pushViewController:[[ReUploadAccidentImageViewController alloc]initWithData:self.cData] animated:YES];
}

- (void)goReCarConfirm
{
    [self.navigationController pushViewController:[[BeinDangerOneCarConfirmViewController alloc]init] animated:YES];
}

//线下确认
- (void)goOfflineConfirm
{
    if(bAgreement.isSelected){
        NSString *cid=[self.cData objectForKey:@"id"];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"offlineConfirm" forKey:@"act"];
        [params setObject:[User getInstance].uid forKey:@"uid"];
        [params setObject:cid forKey:@"id"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
        [self.hRequest setDelegate:self];
        [self.hRequest setView:self.view];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }else{
        [Common alert:@"请勾选协议"];
    }
}

//线上确认
- (void)goOnlineConfirm
{
    if(bAgreement.isSelected){
        NSString *cid=[self.cData objectForKey:@"id"];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"onlineConfirm" forKey:@"act"];
        [params setObject:[User getInstance].uid forKey:@"uid"];
        [params setObject:cid forKey:@"id"];
        [params setObject:@"1" forKey:@"type"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
        [self.hRequest setDelegate:self];
        [self.hRequest setView:self.view];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }else{
        [Common alert:@"请勾选协议"];
    }
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    NSLog(@"%@",[response responseString]);
    if([response successFlag]){
        if(reqCode==500){
            //线下确认
            [self.navigationController popViewControllerAnimated:YES];
        }else if(reqCode==501){
            //线上确认
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end