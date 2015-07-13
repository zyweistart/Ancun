//
//  CommentCell.m
//  Ume
//
//  Created by Start on 15/7/10.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "CommentCell.h"
#import "CommentViewController.h"

@implementation CommentCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 130)];
        [contentView setUserInteractionEnabled:YES];
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
        CGFloat width=[PlayerVoiceButton getPlayerWidthToSecond:71];
        self.player=[[PlayerVoiceButton alloc]initWithFrame:CGRectMake1(30, 60, width, 30)];
        [contentView addSubview:self.player];
        //线
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(20, 100, 280, 0.5)];
        [line setBackgroundColor:DEFAULTITLECOLOR(240)];
        [contentView addSubview:line];
        //评论
        self.lblPCount=[[UIButton alloc]initWithFrame:CGRectMake1(180,100, 60,30)];
        [self.lblPCount.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.lblPCount setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [self.lblPCount addTarget:self action:@selector(goComment:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:self.lblPCount];
        //赞
        self.lblZCount=[[UIButton alloc]initWithFrame:CGRectMake1(240, 100, 60, 30)];
        [self.lblZCount.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.lblZCount setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        [self.lblZCount addTarget:self action:@selector(goLove:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:self.lblZCount];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [self.lblName setText:@"Jackywell"];
        [self.lblTime setText:@"15:22"];
        [self.lblValue setText:@"开心70%"];
        [self.lblPCount setTitle:@"评论" forState:UIControlStateNormal];
        [self.lblZCount setTitle:@"37123赞" forState:UIControlStateNormal];
    }
    return self;
}

- (void)goComment:(id)sender
{
    CommentViewController *mCommentViewController=[[CommentViewController alloc]initWithData:nil];
    [self.currentViewController.navigationController pushViewController:mCommentViewController animated:YES];
}

- (void)goLove:(id)sender
{
    NSLog(@"爱");
}

@end

