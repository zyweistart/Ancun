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
        UIImageView *header=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [header setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [topView addSubview:header];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@"Jackywell"];
        [lbl setFont:[UIFont systemFontOfSize:20]];
        [lbl setTextColor:[UIColor blueColor]];
        [topView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 90, 20) Text:@"15:22"];
        [lbl setFont:[UIFont systemFontOfSize:17]];
        [lbl setTextColor:DEFAULTITLECOLOR(150)];
        [topView addSubview:lbl];
        header=[[UIImageView alloc]initWithFrame:CGRectMake1(160, 10, 90, 40)];
        [header setImage:[UIImage imageNamed:@"personalbg"]];
        [topView addSubview:header];
        header=[[UIImageView alloc]initWithFrame:CGRectMake1(260, 10, 40, 40)];
        [header setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [topView addSubview:header];
        UIImageView *content_image=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 60, 310, 140)];
        [content_image setImage:[UIImage imageNamed:@"personalbg"]];
        [contentView addSubview:content_image];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(107, 10, 106, 40)];
        [button setImage:[UIImage imageNamed:@"tab_live"] forState:UIControlStateNormal];
        [content_image addSubview:button];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 60, 300, 40)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setText:@"寂寞，不是因为独自一人，而是周围的人都无法了解你的感受；寂寞，不是没人..."];
        [lbl setNumberOfLines:2];
        [lbl sizeToFit];
        [content_image addSubview:lbl];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 310, 40)];
        [content_image addSubview:bottomView];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 103, 40)];
        [button setTitle:@"私信" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setImage:[UIImage imageNamed:@"tab_live"] forState:UIControlStateNormal];
        [bottomView addSubview:button];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(103, 5, 1, 30)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [bottomView addSubview:line1];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(104, 0, 103, 40)];
        [button setTitle:@"分享" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setImage:[UIImage imageNamed:@"tab_live"] forState:UIControlStateNormal];
        [bottomView addSubview:button];
        //竖线
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(207, 5, 1, 30)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [bottomView addSubview:line2];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(208, 0, 102, 40)];
        [button setTitle:@"21懂我" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setImage:[UIImage imageNamed:@"tab_live"] forState:UIControlStateNormal];
        [bottomView addSubview:button];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
