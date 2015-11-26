//
//  WaitHandleViewController.m
//  Car
//
//  Created by Start on 11/26/15.
//  Copyright © 2015 Ancun. All rights reserved.
//
#define GLOBAL_SECOND 60*5
#define GLOBAL_GETCODE_STRING @"初审预计还需要%@，请不要退出此界面"

#import "WaitHandleViewController.h"

@implementation WaitHandleViewController{
    int second;
    NSTimer *verificationCodeTime;
    XLLabel *lblTime;
}

- (id)initWithData:(NSDictionary *)data
{
    self.cData=data;
    self=[super init];
    if(self){
        [self setTitle:@"温馨提示"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 70, 300, 30)];
    [lblTime setTextAlignment:NSTextAlignmentCenter];
    [lblTime setTextColor:BGCOLOR];
    [lblTime setFont:GLOBAL_FONTSIZE(15)];
    [self.view addSubview:lblTime];
    XLLabel *lblTip=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 100, 300, 60)];
    [lblTip setText:@"您拍摄的现场取证照片已上传，请勿挪动事故车车辆，平台正在审核是否符合规范，确保您安全情况下，在原地稍后..."];
    [lblTip setTextAlignment:NSTextAlignmentLeft];
    [lblTip setTextColor:BCOLOR(150)];
    [lblTip setFont:GLOBAL_FONTSIZE(14)];
    [lblTip setNumberOfLines:0];
    [self.view addSubview:lblTip];
    UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(5, 170, 307, 200)];
    [image setImage:[UIImage imageNamed:@"提示"]];
    [self.view addSubview:image];
    
    second=GLOBAL_SECOND;
    [lblTime setText:[self secondConvertMin:second]];
    verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
}

- (void)updateTimer
{
    --second;
    if(second%60==0){
        [self goHandle];
    }
    if(second==0){
        if(verificationCodeTime){
            [verificationCodeTime invalidate];
            verificationCodeTime=nil;
        }
    }
    [lblTime setText:[self secondConvertMin:second]];
}

- (NSString *)secondConvertMin:(NSInteger)sec
{
    NSInteger m=sec/60;
    NSInteger s=sec%60;
    NSString *sm,*ss;
    if(m>9){
        sm=[NSString stringWithFormat:@"%d",m];
    }else{
        sm=[NSString stringWithFormat:@"0%d",m];
    }
    if(s>9){
        ss=[NSString stringWithFormat:@"%d",s];
    }else{
        ss=[NSString stringWithFormat:@"0%d",s];
    }
    NSString *va = [NSString stringWithFormat:@"%@:%@",sm,ss];
    return [NSString stringWithFormat:GLOBAL_GETCODE_STRING,va];
}

- (void)goHandle
{
    NSLog(@"处理了");
}

@end