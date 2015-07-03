//
//  ReplyMDCell.m
//  Ume
//
//  Created by Start on 15/7/2.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "ReplyMDCell.h"

@implementation ReplyMDCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 130)];
        [self addSubview:contentView];
        self.meHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        self.meHeader.layer.cornerRadius=self.meHeader.bounds.size.width/2;
        self.meHeader.layer.masksToBounds=YES;
        self.meHeader.layer.borderWidth=1;
        self.meHeader.layer.borderColor=[[UIColor grayColor]CGColor];
        [contentView addSubview:self.meHeader];
        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@""];
        [self.lblName setFont:[UIFont systemFontOfSize:18]];
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(47, 160, 248)];
        [contentView addSubview:self.lblName];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 40, 20) Text:@""];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
        [contentView addSubview:self.lblTime];
        self.lblValue=[[CLabel alloc]initWithFrame:CGRectMake1(100, 30, 60, 20) Text:@""];
        [self.lblValue setFont:[UIFont systemFontOfSize:14]];
        [self.lblValue setTextColor:DEFAULTITLECOLOR(150)];
        [contentView addSubview:self.lblValue];
        //语音
        CGFloat width=[self getPlayerWidthToSecond:71];
        UIButton *but=[[UIButton alloc]initWithFrame:CGRectMake1(30, 60, width, 30)];
        if(width>60){
            but.layer.cornerRadius=CGWidth(15);
        }else{
            but.layer.cornerRadius=CGWidth(10);
        }
        but.layer.masksToBounds=YES;
        but.layer.borderWidth=1;
        but.layer.borderColor=[COLOR2552160 CGColor];
        [but setImage:[UIImage imageNamed:@"icon-nav-me2"] forState:UIControlStateNormal];
        [but setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        [but setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [contentView addSubview:but];
        //线
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(20, 100, 280, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(240)];
        [contentView addSubview:line];
        //评论
        self.lblPCount=[[CLabel alloc]initWithFrame:CGRectMake1(180, 100, 60, 30) Text:@""];
        [self.lblPCount setFont:[UIFont systemFontOfSize:14]];
        [self.lblPCount setTextColor:DEFAULTITLECOLOR(150)];
        [self.lblPCount setTextAlignment:NSTextAlignmentRight];
        [contentView addSubview:self.lblPCount];
        //赞
        self.lblZCount=[[CLabel alloc]initWithFrame:CGRectMake1(240, 100, 60, 30) Text:@""];
        [self.lblZCount setFont:[UIFont systemFontOfSize:14]];
        [self.lblZCount setTextColor:DEFAULTITLECOLOR(150)];
        [self.lblZCount setTextAlignment:NSTextAlignmentRight];
        [contentView addSubview:self.lblZCount];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [self.lblName setText:@"Jackywell"];
        [self.lblTime setText:@"15:22"];
        [self.lblValue setText:@"开心70%"];
        [self.lblPCount setText:@"评论"];
        [self.lblZCount setText:@"37123赞"];
    }
    return self;
}

- (CGFloat)getPlayerWidthToSecond:(int)curSecond
{
    if(curSecond>65){
        return 150;
    }
    return 35+curSecond;
}

@end
