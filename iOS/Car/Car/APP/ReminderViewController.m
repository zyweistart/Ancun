//
//  ReminderViewController.m
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ReminderViewController.h"
#import "HandleProcessViewController.h"

@interface ReminderViewController ()

@end

@implementation ReminderViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"温馨提示"];
        [self.view setBackgroundColor:BCOLOR(244)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    XLLabel *lbl=[[XLLabel alloc]initWithFrame:CGRectMake(CGWidth(10), 0, CGWidth(300), CGHeight(20)) Text:@"遇事别急，先做好安全防范:"];
//    [lbl setFont:GLOBAL_FONTSIZE(15)];
    [lbl setTextColor:BGCOLOR];
    [lbl setNumberOfLines:0];
    [self.view addSubview:lbl];
    
    UIScrollView *contentView=[[UIScrollView alloc]initWithFrame:CGRectMake(CGWidth(10), CGHeight(20), CGWidth(300), self.view.bounds.size.height-64-CGHeight(20))];
    [contentView setContentSize:CGSizeMake1(300, 400)];
    [contentView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    contentView.layer.cornerRadius=CGWidth(3);
    contentView.layer.masksToBounds=YES;
    contentView.layer.borderColor=BGCOLOR.CGColor;
    contentView.layer.borderWidth=CGWidth(1);
    [contentView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:contentView];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGWidth(20), CGHeight(10), 1, CGWidth(380))];
    [line setBackgroundColor:BCOLOR(200)];
    [contentView addSubview:line];
    
    [contentView addSubview:[self createTitleView:5 ImageNamed:@"双跳灯" Info:@"打开双跳灯(夜间把示廓灯也打开)"]];
    [contentView addSubview:[self createTitleView:176 ImageNamed:@"警示牌" Info:@"车后50至100米之间放置随车三脚架(确保自身安全)"]];
    [contentView addSubview:[self createTitleView:347 ImageNamed:nil Info:@"无人员伤亡，车辆后续可移动"]];
    
    XLButton *bOK=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(10), self.view.bounds.size.height-64-CGHeight(45), CGWidth(300),CGHeight(40)) Name:@"确定" Type:3];
    [bOK addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bOK];
}

- (UIView *)createTitleView:(CGFloat)top ImageNamed:(NSString*)imageNamed Info:(NSString*)info
{
    UIView *itemView=[[UIView alloc]init];
    if(imageNamed){
        [itemView setFrame:CGRectMake1(10,top,280,171)];
    }else{
        [itemView setFrame:CGRectMake1(10,top,280,40)];
    }
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 10, 20, 20)];
    [icon setImage:[UIImage imageNamed:@"圆点_提示"]];
    [itemView addSubview:icon];
    XLLabel *lblInfo=[[XLLabel alloc]initWithFrame:CGRectMake1(30, 0, 250, 40) Text:info];
    [lblInfo setTextColor:BCOLOR(80)];
    [lblInfo setFont:GLOBAL_FONTSIZE(12)];
    [lblInfo setNumberOfLines:0];
    [itemView addSubview:lblInfo];
    if(imageNamed){
        UIImageView *iImage=[[UIImageView alloc]initWithFrame:CGRectMake1(25, 40, 255, 131)];
        [iImage setImage:[UIImage imageNamed:imageNamed]];
        [itemView addSubview:iImage];
    }
    return itemView;
}

- (void)goNext
{
    HandleProcessViewController *mHandleProcessViewController=[[HandleProcessViewController alloc]init];
    [mHandleProcessViewController setMapData:self.mapData];
    [mHandleProcessViewController setInsuranceData:self.insuranceData];
    [mHandleProcessViewController setInsuranceOData:self.insuranceOData];
    [self.navigationController pushViewController:mHandleProcessViewController animated:YES];
}

@end