//
//  MessageZDWDCell.m
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageZDWDCell.h"

@implementation MessageZDWDCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
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
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(242, 82, 159)];
        [contentView addSubview:self.lblName];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 150, 20) Text:@""];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
        [contentView addSubview:self.lblTime];
        
        self.bFelationShip=[[CButton alloc]initWithFrame:CGRectMake1(230, 15, 80, 30) Name:@"已关注" Type:3];
        [self.bFelationShip.titleLabel setFont:[UIFont systemFontOfSize:14]];
//        [self.bFelationShip setTitle:@"" forState:UIControlStateNormal];
        [contentView addSubview:self.bFelationShip];
        
        //语音
        CGFloat width=[PlayerVoiceButton getPlayerWidthToSecond:71];
        self.player=[[PlayerVoiceButton alloc]initWithFrame:CGRectMake1(30, 60, width, 30)];
        [contentView addSubview:self.player];
        //
        self.mFelationship=[[UIImageView alloc]initWithFrame:CGRectMake1(220, 60, 90, 40)];
        [self.mFelationship setImage:[UIImage imageNamed:@"icon-match"]];
        [contentView addSubview:self.mFelationship];
        //图片
        self.ivImage=[[ImageViewGesture alloc]initWithFrame:CGRectMake1(40, 100, 80, 80)];
        [self.ivImage setImage:[UIImage imageNamed:@"personalbg"]];
        [contentView addSubview:self.ivImage];
        //文字
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(130, 100, 180, 80)];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setFont:[UIFont systemFontOfSize:16]];
        [lbl setNumberOfLines:4];
        [lbl sizeToFit];
        [contentView addSubview:lbl];
        
        
        
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [self.lblName setText:@"天使之城"];
        [self.lblTime setText:@"2015-04-10 15:24"];
        
        [lbl setText:@"这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述"];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        
        
        
        
    }
    return self;
}

@end
