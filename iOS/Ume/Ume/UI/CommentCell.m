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
        MessageViewFrame *contentView=[[MessageViewFrame alloc]initWithFrame:CGRectMake1(0, 0, 320, 190)];
        [contentView setBackgroundColor:DEFAULTITLECOLOR(245)];
        [contentView setUserInteractionEnabled:YES];
        [self addSubview:contentView];
        
        
//        self.meHeader=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
//        self.meHeader.layer.cornerRadius=self.meHeader.bounds.size.width/2;
//        self.meHeader.layer.masksToBounds=YES;
//        self.meHeader.layer.borderWidth=1;
//        self.meHeader.layer.borderColor=[[UIColor grayColor]CGColor];
//        [contentView addSubview:self.meHeader];
//        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 90, 20) Text:@""];
//        [self.lblName setFont:[UIFont systemFontOfSize:18]];
//        [self.lblName setTextColor:DEFAULTITLECOLORRGB(47, 160, 248)];
//        [contentView addSubview:self.lblName];
//        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 40, 20) Text:@""];
//        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
//        [self.lblTime setTextColor:DEFAULTITLECOLOR(150)];
//        [contentView addSubview:self.lblTime];
//        self.lblValue=[[CLabel alloc]initWithFrame:CGRectMake1(100, 30, 60, 20) Text:@""];
//        [self.lblValue setFont:[UIFont systemFontOfSize:14]];
//        [self.lblValue setTextColor:DEFAULTITLECOLOR(150)];
//        [contentView addSubview:self.lblValue];
//        //语音
//        CGFloat width=[PlayerVoiceButton getPlayerWidthToSecond:71];
//        self.player=[[PlayerVoiceButton alloc]initWithFrame:CGRectMake1(30, 60, width, 30)];
//        [contentView addSubview:self.player];
//        
//        self.ivImage=[[UIImageView alloc]initWithFrame:CGRectMake1(40, 100, 80, 80)];
//                [contentView addSubview:self.ivImage];
//        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
//
//        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
//        [self.lblName setText:@"Jackywell"];
//        [self.lblTime setText:@"15:22"];
//        [self.lblValue setText:@"开心70%"];
//        [self.lblPCount setTitle:@"评论" forState:UIControlStateNormal];
//        [self.lblZCount setTitle:@"37123赞" forState:UIControlStateNormal];
//        [self.ivImage setImage:[UIImage imageNamed:@"personalbg"]];

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

