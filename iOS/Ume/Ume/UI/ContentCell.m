//
//  ContentCell.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "ContentCell.h"
#import "CLabel.h"
#define LINEBGCOLOR [UIColor colorWithRed:(167/255.0) green:(183/255.0) blue:(216/255.0) alpha:0.5]

@implementation ContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:DEFAULTITLECOLOR(200)];
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(5, 3, 310, 200)];
        [contentView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:contentView];
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 310, 60)];
        [contentView addSubview:topView];
        self.meHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [topView addSubview:self.meHeader];
        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@"Jackywell"];
        [self.lblName setFont:[UIFont systemFontOfSize:18]];
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(47, 160, 248)];
        [topView addSubview:self.lblName];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 90, 20) Text:@"15:22"];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
        [topView addSubview:self.lblTime];
        self.mFelationship=[[UIImageView alloc]initWithFrame:CGRectMake1(160, 10, 90, 40)];
        [self.mFelationship setImage:[UIImage imageNamed:@"personalbg"]];
//        [topView addSubview:self.mFelationship];
        self.youHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(260, 10, 40, 40)];
        [self.youHeader setImage:[UIImage imageNamed:@"img_girl"]];
        [topView addSubview:self.youHeader];
        UIImageView *content_image=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 60, 310, 140)];
//        [content_image setImage:[UIImage imageNamed:@"personalbg"]];
        [content_image setBackgroundColor:DEFAULTITLECOLOR(221)];
        [contentView addSubview:content_image];
        self.bPlayer=[[UIButton alloc]initWithFrame:CGRectMake1(140, 10, 40, 40)];
        self.bPlayer.layer.cornerRadius=self.bPlayer.bounds.size.width/2;
        self.bPlayer.layer.masksToBounds=YES;
        self.bPlayer.layer.borderWidth=1;
        self.bPlayer.layer.borderColor=[[UIColor whiteColor]CGColor];
        [self.bPlayer setImage:[UIImage imageNamed:@"icon-play-small"] forState:UIControlStateNormal];
        [self.bPlayer setImage:[UIImage imageNamed:@"icon-stop-small"] forState:UIControlStateSelected];
        [content_image addSubview:self.bPlayer];
        self.lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(10, 60, 300, 40)];
        [self.lblContent setFont:[UIFont systemFontOfSize:15]];
        [self.lblContent setTextColor:[UIColor whiteColor]];
        [self.lblContent setText:@"寂寞，不是因为独自一人，而是周围的人都无法了解你的感受；寂寞，不是没人..."];
        [self.lblContent setNumberOfLines:2];
        [self.lblContent sizeToFit];
        [content_image addSubview:self.lblContent];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 310, 40)];
        [content_image addSubview:bottomView];
        //私信
        self.bPrivateLetter=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 103, 40)];
        [self.bPrivateLetter setTitle:@"私信" forState:UIControlStateNormal];
        [self.bPrivateLetter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bPrivateLetter.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bPrivateLetter setImage:[UIImage imageNamed:@"icon-home-私信"] forState:UIControlStateNormal];
        [self.bPrivateLetter setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
        [bottomView addSubview:self.bPrivateLetter];
        //分享
        self.bShare=[[UIButton alloc]initWithFrame:CGRectMake1(104, 0, 103, 40)];
        [self.bShare setTitle:@"分享" forState:UIControlStateNormal];
        [self.bShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bShare.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bShare setImage:[UIImage imageNamed:@"icon-home-share"] forState:UIControlStateNormal];
        [self.bShare setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
        [bottomView addSubview:self.bShare];
        //懂我
        self.bDM=[[UIButton alloc]initWithFrame:CGRectMake1(208, 0, 102, 40)];
        [self.bDM setTitle:@"21懂我" forState:UIControlStateNormal];
        [self.bDM setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bDM.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bDM setImage:[UIImage imageNamed:@"icon-home-懂你"] forState:UIControlStateNormal];
        [self.bDM setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
        [bottomView addSubview:self.bDM];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end