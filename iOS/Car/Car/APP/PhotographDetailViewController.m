//
//  PhotographDetailViewController.m
//  Car
//
//  Created by Start on 11/12/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "PhotographDetailViewController.h"
#import "UIButton+Utils.h"
#import "XLButtonPICTEXT.h"
#import "SJAvatarBrowser.h"

@implementation PhotographDetailViewController{
    UIImageView *pImageV;
    UILabel *lblName;
    NSString *fid;
    NSString *name;
    NSString *type;
    
}

- (id)initWithData:(NSDictionary*)data
{
    self.cData=data;
    self.hDownload=[[HttpDownload alloc]initWithDelegate:self];
    fid=[self.cData objectForKey:@"id"];
    type=[self.cData objectForKey:@"type"];
    self=[super init];
    if(self){
        [self setTitle:@"随手拍"];
        [self.view setBackgroundColor:BCOLOR(244)];
        NSLog(@"%@",self.cData);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lblName=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 320, 30)];
    [lblName setFont:GLOBAL_FONTSIZE(13)];
    [lblName setTextColor:[UIColor whiteColor]];
    [lblName setBackgroundColor:BCOLOR(30)];
    [self.view addSubview:lblName];
    pImageV=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 30, 320, 150)];
    [pImageV setBackgroundColor:[UIColor redColor]];
    [pImageV setUserInteractionEnabled:YES];
    [pImageV addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goPlayer)]];
    [self.view addSubview:pImageV];
    UIView *operatorView=[[UIView alloc]initWithFrame:CGRectMake1(0, 180, 320, 80)];
    [operatorView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:operatorView];
    
    XLButtonPICTEXT *bPlayer=[[XLButtonPICTEXT alloc]initWithFrame:CGRectMake1(70, 15, 60, 40)];
    [bPlayer.titleLabel setFont:GLOBAL_FONTSIZE(13)];
    [bPlayer setTitle:@"播放" forState:UIControlStateNormal];
    [bPlayer setTitleColor:BCOLOR(150) forState:UIControlStateNormal];
    [bPlayer setImage:[UIImage imageNamed:@"播放_开始"] forState:UIControlStateNormal];
    [bPlayer addTarget:self action:@selector(goPlayer) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:bPlayer];
    XLButtonPICTEXT *bName=[[XLButtonPICTEXT alloc]initWithFrame:CGRectMake1(130, 15, 60, 40)];
    [bName.titleLabel setFont:GLOBAL_FONTSIZE(13)];
    [bName setTitle:@"重命名" forState:UIControlStateNormal];
    [bName setTitleColor:BCOLOR(150) forState:UIControlStateNormal];
    [bName setImage:[UIImage imageNamed:@"重命名"] forState:UIControlStateNormal];
    [bName addTarget:self action:@selector(goReName) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:bName];
    XLButtonPICTEXT *bDel=[[XLButtonPICTEXT alloc]initWithFrame:CGRectMake1(190, 15, 60, 40)];
    [bDel.titleLabel setFont:GLOBAL_FONTSIZE(13)];
    [bDel setTitle:@"删除" forState:UIControlStateNormal];
    [bDel setTitleColor:BCOLOR(150) forState:UIControlStateNormal];
    [bDel setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [bDel addTarget:self action:@selector(goDelete) forControlEvents:UIControlEventTouchUpInside];
    [operatorView addSubview:bDel];
    
    XLLabel *lblFileSize=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 270,300, 30)];
    [self.view addSubview:lblFileSize];
    XLLabel *lblRes=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 300,300, 30)];
    [self.view addSubview:lblRes];
    XLLabel *lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 330,300, 30)];
    [self.view addSubview:lblTime];
    
    name=[self.cData objectForKey:@"localName"];
    [lblName setText:name];
    NSString *fileSize=[self.cData objectForKey:@"fileSize"];
    NSString *responsibility=[self.cData objectForKey:@"attchStatus"];
    NSString *addTime=[self.cData objectForKey:@"addTime"];
    [lblFileSize setText:[NSString stringWithFormat:@"文件大小:%@",fileSize]];
    if([@"1" isEqualToString:responsibility]){
        [lblRes setText:@"文件类型:云端存证"];
    }else{
        [lblRes setText:@"文件类型:本地存证"];
    }
    [lblTime setText:[NSString stringWithFormat:@"存证时间:%@",addTime]];
    if([@"1" isEqualToString:type]){
        NSString *imageUrl=[self.cData objectForKey:@"attchUrl"];
        [self.hDownload AsynchronousDownloadWithUrl:imageUrl RequestCode:500 Object:pImageV];
    }else if([@"3" isEqualToString:type]){
        NSString *imageUrl=[self.cData objectForKey:@"videoThumbnail"];
        [self.hDownload AsynchronousDownloadWithUrl:imageUrl RequestCode:500 Object:pImageV];
    }else{
        //录音
        [pImageV setImage:[UIImage imageNamed:@"录音笔出证"]];
    }
}

- (void)goPlayer
{
    if([@"1" isEqualToString:type]){
        [SJAvatarBrowser showImage:pImageV];
    }else if([@"2" isEqualToString:type]){
        //下载
    }
}

- (void)goReName
{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"重命名" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}

- (void)goDelete
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil,nil];
    [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *tf=[alertView textFieldAtIndex:0];
    [tf resignFirstResponder];
    if(buttonIndex==1){
        name=[tf text];
        if(![name isEmpty]){
            self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
            NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
            [params setObject:@"reName" forKey:@"act"];
            [params setObject:[User getInstance].uid forKey:@"uid"];
            [params setObject:fid forKey:@"id"];
            [params setObject:name forKey:@"localName"];
//            [params setObject:@"1" forKey:@"localUrl"];
            [self.hRequest setDelegate:self];
            [self.hRequest setIsShowFailedMessage:YES];
            [self.hRequest handleWithParams:params];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0){
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"delSecurity" forKey:@"act"];
        [params setObject:[User getInstance].uid forKey:@"uid"];
        [params setObject:fid forKey:@"id"];
        [params setObject:type forKey:@"type"];
        [self.hRequest setDelegate:self];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            [lblName setText:name];
        }else if(reqCode==501){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end