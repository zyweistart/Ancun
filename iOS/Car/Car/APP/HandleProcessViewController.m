//
//  HandleProcessViewController.m
//  Car
//
//  Created by Start on 10/30/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "HandleProcessViewController.h"
#import "HandleViewController.h"

@interface HandleProcessViewController ()

@end

@implementation HandleProcessViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"处理流程"];
        [self.view setBackgroundColor:BCOLOR(244)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    XLLabel *lbl=[[XLLabel alloc]initWithFrame:CGRectMake(CGWidth(10), 0, CGWidth(300), CGHeight(20)) Text:@"请按以下步骤处理此次事故:"];
    [lbl setTextColor:BGCOLOR];
    [lbl setNumberOfLines:0];
    [self.view addSubview:lbl];
    
    UIScrollView *contentView=[[UIScrollView alloc]initWithFrame:CGRectMake(CGWidth(10), CGHeight(20), CGWidth(300), self.view.bounds.size.height-64-CGHeight(100))];
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
    
    [contentView addSubview:[self createTitleView:5 ImageNamed:nil Info:@"双方事故请拨打122报警" Call:YES]];
    [contentView addSubview:[self createTitleView:45 ImageNamed:@"交警拍照片" Info:@"拍照取证" Call:NO]];
    [contentView addSubview:[self createTitleView:185 ImageNamed:@"交警认定责任" Info:@"责任认定" Call:NO]];
    [contentView addSubview:[self createTitleView:325 ImageNamed:nil Info:@"线上定损" Call:NO]];
    
    XLButton *bOK=[[XLButton alloc]initWithFrame:CGRectMake(CGWidth(10), self.view.bounds.size.height-64-CGHeight(75), CGWidth(300),CGHeight(40)) Name:@"开始处理" Type:3];
    [bOK addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bOK];
    lbl=[[XLLabel alloc]initWithFrame:CGRectMake(CGWidth(15), self.view.bounds.size.height-64-CGHeight(30), CGWidth(290), CGHeight(30)) Text:@"注意:拍照过程中请留意周边来往车辆"];
    [lbl setTextColor:BGCOLOR];
    [self.view addSubview:lbl];
}

- (UIView *)createTitleView:(CGFloat)top ImageNamed:(NSString*)imageNamed Info:(NSString*)info Call:(BOOL)callF
{
    UIView *itemView=[[UIView alloc]init];
    if(imageNamed){
        [itemView setFrame:CGRectMake1(10,top,280,140)];
    }else{
        [itemView setFrame:CGRectMake1(10,top,280,40)];
    }
    UIImageView *icon=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 10, 20, 20)];
    [icon setImage:[UIImage imageNamed:@"圆点_提示"]];
    [itemView addSubview:icon];
    XLLabel *lblInfo=[[XLLabel alloc]initWithFrame:CGRectMake1(30, 0, 140, 40) Text:info];
    [lblInfo setTextColor:BCOLOR(80)];
    [lblInfo setFont:GLOBAL_FONTSIZE(12)];
    [lblInfo setNumberOfLines:0];
    [itemView addSubview:lblInfo];
    if(callF){
        XLButton *call=[[XLButton alloc]initWithFrame:CGRectMake1(170, 7, 60, 25) Name:@"拨打122" Type:3];
        call.layer.cornerRadius=CGWidth(3);
        [call.titleLabel setFont:GLOBAL_FONTSIZE(12)];
        [call setImage:[UIImage imageNamed:@"拨打"] forState:UIControlStateNormal];
        [call setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [call addTarget:self action:@selector(goCall) forControlEvents:UIControlEventTouchUpInside];
        [itemView addSubview:call];
    }
    if(imageNamed){
        UIImageView *iImage=[[UIImageView alloc]initWithFrame:CGRectMake1(25, 40, 255, 100)];
        [iImage setImage:[UIImage imageNamed:imageNamed]];
        [itemView addSubview:iImage];
    }
    return itemView;
}

- (void)goCall
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",@"122"]]];
}

- (void)goNext
{
    [self.navigationController pushViewController:[[HandleViewController alloc]init] animated:YES];
}

@end