//
//  UYourDetailViewController.m
//  Ume
//  懂你详细页
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "UYourDetailViewController.h"
#import "ReplyMDCell.h"
#import "CLabel.h"

@interface UYourDetailViewController ()

@end

@implementation UYourDetailViewController

- (id)initWithData:(NSDictionary*)data
{
    self=[super init];
    if(self){
        self.data=data;
        [self cTitle:@"懂你详情"];
        self.isFirstRefresh=NO;
        UIView *headContent=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 300)];
        [self.view addSubview:headContent];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
        [image setBackgroundColor:DEFAULTITLECOLOR(221)];
        [image setUserInteractionEnabled:YES];
        [headContent addSubview:image];
        //关闭
        UIButton *bClose = [[UIButton alloc]init];
        [bClose setFrame:CGRectMake1(5, 20, 30, 30)];
        [bClose setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
        [bClose setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateHighlighted];
        [bClose addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [image addSubview:bClose];
        //分享
        UIButton *bShare = [[UIButton alloc]init];
        [bShare setFrame:CGRectMake1(285, 20, 30, 30)];
        [bShare setImage:[UIImage imageNamed:@"icon-top-share"] forState:UIControlStateNormal];
        [bShare addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
        [image addSubview:bShare];
        //播放
        self.bPlayer=[[UIButton alloc]initWithFrame:CGRectMake1(140, 60, 40, 40)];
        self.bPlayer.layer.cornerRadius=self.bPlayer.bounds.size.width/2;
        self.bPlayer.layer.masksToBounds=YES;
        self.bPlayer.layer.borderWidth=1;
        self.bPlayer.layer.borderColor=[[UIColor whiteColor]CGColor];
        [self.bPlayer setImage:[UIImage imageNamed:@"icon-play-small"] forState:UIControlStateNormal];
        [self.bPlayer addTarget:self action:@selector(player:) forControlEvents:UIControlEventTouchUpInside];
        [image addSubview:self.bPlayer];
        //内容
        self.lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(10, 130, 300, 40)];
        [self.lblContent setFont:[UIFont systemFontOfSize:15]];
        [self.lblContent setTextColor:[UIColor whiteColor]];
        [self.lblContent setNumberOfLines:2];
        [self.lblContent setText:@"有时候，渴望像孩子一样的生活，高兴时可以毫不掩饰地笑，悲伤时可以无所顾忌地哭，可以快乐地去唱，可以率真地去画，可以胜颗童身份证的心去感受生活，可以用一双清澈的..."];
        [image addSubview:self.lblContent];
        
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 200, 320, 60)];
        [headContent addSubview:contentView];
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        topView.layer.borderWidth=1;
        topView.layer.borderColor=DEFAULTITLECOLOR(221).CGColor;
        [contentView addSubview:topView];
        self.meHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        self.meHeader.layer.cornerRadius=self.meHeader.bounds.size.width/2;
        self.meHeader.layer.masksToBounds=YES;
        self.meHeader.layer.borderWidth=1;
        self.meHeader.layer.borderColor=[[UIColor grayColor]CGColor];
        [topView addSubview:self.meHeader];
        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@""];
        [self.lblName setFont:[UIFont systemFontOfSize:18]];
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(47, 160, 248)];
        [topView addSubview:self.lblName];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 90, 20) Text:@""];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
        [topView addSubview:self.lblTime];
        self.mFelationship=[[UIImageView alloc]initWithFrame:CGRectMake1(160, 10, 90, 40)];
        [topView addSubview:self.mFelationship];
        self.youHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(270, 10, 40, 40)];
        self.youHeader.layer.cornerRadius=self.youHeader.bounds.size.width/2;
        self.youHeader.layer.masksToBounds=YES;
        self.youHeader.layer.borderWidth=1;
        self.youHeader.layer.borderColor=[[UIColor grayColor]CGColor];
        [topView addSubview:self.youHeader];
        UIView *titleHead=[[UIView alloc]initWithFrame:CGRectMake1(0, 60, 320, 40)];
        [titleHead setBackgroundColor:DEFAULTITLECOLOR(245)];
        [topView addSubview:titleHead];
        //总数
        self.lblCount=[[CLabel alloc]initWithFrame:CGRectMake1(10, 0, 150, 40) Text:@"所有懂你(123)"];
        [self.lblCount setFont:[UIFont systemFontOfSize:14]];
        [self.lblCount setTextColor:DEFAULTITLECOLOR(100)];
        [titleHead addSubview:self.lblCount];
        
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [self.lblName setText:@"Jackywell"];
        [self.lblTime setText:@"15:22"];
        [self.youHeader setImage:[UIImage imageNamed:@"img_girl"]];
        [self.tableView setTableHeaderView:headContent];
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(130);
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        ReplyMDCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[ReplyMDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        //        NSDictionary *data=[[self dataItemArray]objectAtIndex:[indexPath row]];
        //        [cell setData:data];
        //        [cell.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        //        [cell.youHeader setImage:[UIImage imageNamed:@"img_girl"]];
        //        [cell.lblName setText:@"Jackywell"];
        //        [cell.lblTime setText:@"15:22"];
        //        [cell.bDM setTitle:[NSString stringWithFormat:@"%@懂我",@"21"] forState:UIControlStateNormal];
        ////        NSString *backgroupUrl=[data objectForKey:@"backgroupUrl"];
        ////        [httpDownload AsynchronousDownloadImageWithUrl:backgroupUrl ShowImageView:cell.mBackground];
        //        NSString *content=[data objectForKey:@"content"];
        //        [cell.lblContent setText:content];
        //        [cell.lblContent sizeToFit];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)player:(id)sender
{
    
}

@end
