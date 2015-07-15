//
//  ContentCell.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "ContentCell.h"
#import "PlayerButton.h"
#import "CLabel.h"
#define LINEBGCOLOR [UIColor colorWithRed:(167/255.0) green:(183/255.0) blue:(216/255.0) alpha:0.5]

@implementation ContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:DEFAULTITLECOLOR(243)];
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(5, 3, 310, 200)];
        contentView.layer.cornerRadius=CGWidth(5);
        contentView.layer.masksToBounds=YES;
        contentView.layer.borderWidth=1;
        contentView.layer.borderColor=[DEFAULTITLECOLOR(221)CGColor];
        [contentView setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:contentView];
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 310, 60)];
        [contentView addSubview:topView];
        
        self.meHeader=[[ImageViewHeader alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
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
        self.youHeader=[[ImageViewHeader alloc]initWithFrame:CGRectMake1(260, 10, 40, 40)];
        [topView addSubview:self.youHeader];
        self.mBackground=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 60, 310, 140)];
        self.mBackground.layer.masksToBounds=YES;
        [self.mBackground setContentMode:UIViewContentModeScaleAspectFill];
        [self.mBackground setUserInteractionEnabled:YES];
        [self.mBackground setBackgroundColor:DEFAULTITLECOLOR(221)];
        
        [contentView addSubview:self.mBackground];
        self.bPlayer=[[PlayerButton alloc]initWithFrame:CGRectMake1(140, 10, 40, 40)];
        [self.mBackground addSubview:self.bPlayer];
        self.lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(10, 60, 300, 40)];
        [self.lblContent setFont:[UIFont systemFontOfSize:15]];
        [self.lblContent setTextColor:[UIColor whiteColor]];
        [self.lblContent setNumberOfLines:2];
        [self.mBackground addSubview:self.lblContent];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 100, 310, 40)];
        [bottomView setUserInteractionEnabled:YES];
        [self.mBackground addSubview:bottomView];
        //私信
        self.bPrivateLetter=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 103, 40)];
        [self.bPrivateLetter setTitle:@"私信" forState:UIControlStateNormal];
        [self.bPrivateLetter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bPrivateLetter.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bPrivateLetter setImage:[UIImage imageNamed:@"icon-home-私信"] forState:UIControlStateNormal];
        [self.bPrivateLetter setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
        [self.bPrivateLetter addTarget:self action:@selector(privatel:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.bPrivateLetter];
        //分享
        self.bShare=[[UIButton alloc]initWithFrame:CGRectMake1(104, 0, 103, 40)];
        [self.bShare setTitle:@"分享" forState:UIControlStateNormal];
        [self.bShare setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bShare.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bShare setImage:[UIImage imageNamed:@"icon-home-share"] forState:UIControlStateNormal];
        [self.bShare setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
        [self.bShare addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:self.bShare];
        //懂我
        self.bDM=[[UIButton alloc]initWithFrame:CGRectMake1(208, 0, 102, 40)];
        [self.bDM setTitle:@"懂我" forState:UIControlStateNormal];
        [self.bDM setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.bDM.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bDM setImage:[UIImage imageNamed:@"icon-home-懂你"] forState:UIControlStateNormal];
        [self.bDM setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(-5), 0, 0)];
        [bottomView addSubview:self.bDM];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)player:(id)sender
{
    NSString *pstatus=[self.data objectForKey:@"pstatus"];
    //判断状态是否为播放(1:播放0:暂停)
    if([@"1" isEqualToString:pstatus]){
        //暂停标记
        [self.data setValue:@"0" forKey:@"pstatus"];
        //暂停播放
        [self.bPlayer.imageView stopAnimating];
    }else{
        //播放标记
        [self.data setValue:@"1" forKey:@"pstatus"];
        //开始播放
        [self.bPlayer.imageView startAnimating];
    }
}

- (void)privatel:(id)sender
{
    NSLog(@"私信");
}

- (void)share:(id)sender
{
    NSLog(@"共享");
    //    [self.bPlayer setSelected:self.bPlayer.selected];
}

- (void)setFelationshipStat:(int)status
{
    if(status==1){
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(242, 82, 159)];
        [self.mFelationship setImage:[UIImage imageNamed:@"icon-match"]];
    }else{
        [self.lblName setTextColor:DEFAULTITLECOLORRGB(47, 160, 248)];
        [self.mFelationship setImage:[UIImage imageNamed:@"icon-match-gray-1"]];
        self.mFelationship.animationImages = [NSArray arrayWithObjects:
                                              [UIImage imageNamed:@"icon-match-gray-1"],
                                              [UIImage imageNamed:@"icon-match-gray-2"],
                                              [UIImage imageNamed:@"icon-match-gray-3"],
                                              [UIImage imageNamed:@"icon-match-gray-4"], nil];
        self.mFelationship.animationDuration = 1.0;
        self.mFelationship.animationRepeatCount = 0;
        [self.mFelationship startAnimating];
    }
}

@end