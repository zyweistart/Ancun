//
//  ProcessViewController.m
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ProcessViewController.h"

@interface ProcessViewController ()

@end

@implementation ProcessViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"事故处理流程"];
        [self.view setBackgroundColor:BCOLOR(244)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    XLLabel *lbl=[[XLLabel alloc]initWithFrame:CGRectMake(CGWidth(10), 64, CGWidth(300), CGHeight(50)) Text:@"为更高效的对事故进行处理，建议在我的资料中完善个人信息."];
    [lbl setFont:GLOBAL_FONTSIZE(15)];
    [lbl setTextColor:BGCOLOR];
    [lbl setNumberOfLines:0];
    [self.view addSubview:lbl];
    
    UIScrollView *contentView=[[UIScrollView alloc]initWithFrame:CGRectMake(CGWidth(10), 120, CGWidth(300), self.view.bounds.size.height-125)];
    [contentView setContentSize:CGSizeMake1(300, 375)];
    contentView.layer.cornerRadius=CGWidth(3);
    contentView.layer.masksToBounds=YES;
    contentView.layer.borderColor=BGCOLOR.CGColor;
    contentView.layer.borderWidth=CGWidth(1);
    [contentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:contentView];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGWidth(20), CGHeight(10), 1, CGWidth(355))];
    [line setBackgroundColor:BCOLOR(200)];
    [contentView addSubview:line];
    
    [contentView addSubview:[self createTitleView:5 Number:@"1" Info:@"温馨提示，做好车辆周边的安全防护"]];
    [contentView addSubview:[self createTitleView:45 Number:@"2" Info:@"拨打122进行报警"]];
    [contentView addSubview:[self createTitleView:85 Number:@"3" Info:@"选择事故类型，单方或双方"]];
    [contentView addSubview:[self createTitleView:125 Number:@"4" Info:@"按系统要求拍摄照片上传，等待审核"]];
    [contentView addSubview:[self createTitleView:165 Number:@"5" Info:@"若审核不通过，根据提示完成拍摄；审核通过，进行事故责任认定"]];
    [contentView addSubview:[self createTitleView:205 Number:@"6" Info:@"拍摄交警开具的事故责任认定协议书，并认定责任"]];
    [contentView addSubview:[self createTitleView:245 Number:@"7" Info:@"等待保险公司定损，保险公司给出给个参考价格"]];
    [contentView addSubview:[self createTitleView:285 Number:@"8" Info:@"根据维修参考价格，若没异议，可选择线上定损若有问题，可选择线下定损"]];
    [contentView addSubview:[self createTitleView:325 Number:@"9" Info:@"选择线下定损，找传统定损流程，选择线上定损，可直接将车开到指定的修理店进行修理"]];
}

- (UIView *)createTitleView:(CGFloat)top Number:(NSString*)number Info:(NSString*)info
{
    UIView *itemView=[[UIView alloc]initWithFrame:CGRectMake1(10,top,280,40)];
    UILabel *lblNumber=[[UILabel alloc]initWithFrame:CGRectMake1(0, 10, 20, 20)];
    lblNumber.layer.cornerRadius=lblNumber.bounds.size.width/2;
    lblNumber.layer.masksToBounds=YES;
    [lblNumber setBackgroundColor:BGCOLOR];
    [lblNumber setText:number];
    [lblNumber setTextColor:[UIColor whiteColor]];
    [lblNumber setTextAlignment:NSTextAlignmentCenter];
    [itemView addSubview:lblNumber];
    XLLabel *lblInfo=[[XLLabel alloc]initWithFrame:CGRectMake1(30, 0, 250, 40) Text:info];
    [lblInfo setTextColor:BCOLOR(80)];
    [lblInfo setFont:GLOBAL_FONTSIZE(12)];
    [lblInfo setNumberOfLines:0];
    [itemView addSubview:lblInfo];
    return itemView;
}

@end