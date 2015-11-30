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
#import "ReUploadAccidentImageViewController.h"
#import "BeinDangerOneCarConfirmViewController.h"
#import "BeinDangerTwoCarConfirmViewController.h"

@implementation WaitHandleViewController{
    int second;
    NSTimer *verificationCodeTime;
    XLLabel *lblTime;
    NSDictionary *data;
}

- (id)initWithData:(NSDictionary *)da
{
    self.cData=da;
    self=[super init];
    if(self){
        [self setTitle:@"温馨提示"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.backBarButtonItem=nil;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)updateTimer
{
    --second;
    if(second%60==0){
        [self goHandle];
    }
    if(second==0){
        [self endWaiting];
    }
    [lblTime setText:[self secondConvertMin:second]];
}

- (NSString *)secondConvertMin:(NSInteger)sec
{
    NSInteger m=sec/60;
    NSInteger s=sec%60;
    NSString *sm,*ss;
    if(m>9){
        sm=[NSString stringWithFormat:@"%ld",m];
    }else{
        sm=[NSString stringWithFormat:@"0%ld",m];
    }
    if(s>9){
        ss=[NSString stringWithFormat:@"%ld",s];
    }else{
        ss=[NSString stringWithFormat:@"0%ld",s];
    }
    NSString *va = [NSString stringWithFormat:@"%@:%@",sm,ss];
    return [NSString stringWithFormat:GLOBAL_GETCODE_STRING,va];
}

- (void)goHandle
{
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

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    NSLog(@"%@",[response responseString]);
    if([response successFlag]){
        if(reqCode==500){
            data=[[response resultJSON]objectForKey:@"data"];
            NSString *status=[data objectForKey:@"status"];
            if([@"1" isEqualToString:status]){
                NSArray *picData=[data  objectForKey:@"picData"];
                if([picData count]>0){
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"信息"
                                          message:@"您拍摄的照中有不符合规范的"
                                          delegate:self
                                          cancelButtonTitle:@"查看详情"
                                          otherButtonTitles:nil, nil];
                    [alert setTag:1];
                    [alert show];
                    return;
                }
            }else if([@"2" isEqualToString:status]){
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle:@"信息"
                                      message:@"初审已通过，请确认《事故责任认定协议》"
                                      delegate:self
                                      cancelButtonTitle:@"事故责任认定"
                                      otherButtonTitles:nil, nil];
                NSString *type=[data objectForKey:@"type"];
                if([@"2" isEqualToString:type]){
                    //多车事故
                    NSString *reportPic=[data  objectForKey:@"reportPic"];
                    if([reportPic isEmpty]){
                        [alert setTag:2];
                        [alert show];
                        return;
                    }
                }else{
                    [alert setTag:3];
                    [alert show];
                    return;
                }
            }
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self endWaiting];
}

- (void)endWaiting
{
    if(verificationCodeTime){
        [verificationCodeTime invalidate];
        verificationCodeTime=nil;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger tag=[alertView tag];
    if(tag==1){
        [self.navigationController pushViewController:[[ReUploadAccidentImageViewController alloc]initWithData:data] animated:YES];
    }else if(tag==2){
        [self.navigationController pushViewController:[[BeinDangerTwoCarConfirmViewController alloc]initWithData:data] animated:YES];
    }else if(tag==3){
        [self.navigationController pushViewController:[[BeinDangerOneCarConfirmViewController alloc]initWithData:data] animated:YES];
    }
}

@end