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
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 190)];
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
        
        self.bFelationShip=[[UIButton alloc]initWithFrame:CGRectMake1(250, 17.5, 60, 25)];
        //
        [self.bFelationShip setTitle:@"已关注" forState:UIControlStateNormal];
        self.bFelationShip.layer.borderWidth=1;
        self.bFelationShip.layer.borderColor=DEFAULTITLECOLOR(150).CGColor;
        [self.bFelationShip setTitleColor:DEFAULTITLECOLOR(150) forState:UIControlStateNormal];
        //
//        [self.bFelationShip setTitle:@"加关注" forState:UIControlStateNormal];
//        [self.bFelationShip setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self.bFelationShip setBackgroundColor:COLOR2552160];
        
        self.bFelationShip.layer.cornerRadius = CGWidth(2);
        self.bFelationShip.layer.masksToBounds = YES;
        [self.bFelationShip.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self.bFelationShip.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self.bFelationShip addTarget:self action:@selector(felationship:) forControlEvents:UIControlEventTouchUpInside];
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
        self.lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(130, 100, 180, 80)];
        [self.lblContent setText:@"这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述"];
        [self.lblContent setTextColor:DEFAUL1COLOR];
        [self.lblContent setFont:[UIFont systemFontOfSize:16]];
        [self.lblContent setNumberOfLines:5];
        [self.lblContent sizeToFit];
        [contentView addSubview:self.lblContent];
        
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [self.lblName setText:@"天使之城"];
        [self.lblTime setText:@"2015-04-10 15:24"];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

- (void)felationship:(id)sender
{
    
}

@end
