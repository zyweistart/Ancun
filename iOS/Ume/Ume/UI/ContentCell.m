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
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
        [self addSubview:contentView];
        
        UIView *topView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [contentView addSubview:topView];
        UIImageView *header=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [header setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [topView addSubview:header];
        UIImageView *content_image=[[UIImageView alloc]initWithFrame:CGRectMake1(0, 60, 320, 100)];
        [content_image setImage:[UIImage imageNamed:@"personalbg"]];
        [contentView addSubview:content_image];
        UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake1(0, 160, 320, 40)];
        [contentView addSubview:bottomView];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(0, 0, 106, 40) Text:@"私信"];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomView addSubview:lbl];
        //竖线
        UIView *line1=[[UIView alloc]initWithFrame:CGRectMake1(107, 5, 1, 30)];
        [line1 setBackgroundColor:LINEBGCOLOR];
        [bottomView addSubview:line1];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(109, 0, 100, 40) Text:@"分享"];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomView addSubview:lbl];
        //竖线
        UIView *line2=[[UIView alloc]initWithFrame:CGRectMake1(210, 5, 1, 30)];
        [line2 setBackgroundColor:LINEBGCOLOR];
        [bottomView addSubview:line2];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(212, 0, 108, 40) Text:@"21懂我"];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [bottomView addSubview:lbl];
    }
    return self;
}

@end
