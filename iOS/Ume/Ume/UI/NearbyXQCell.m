//
//  NearbyXQCell.m
//  Ume
//
//  Created by Start on 15/6/11.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "NearbyXQCell.h"

@implementation NearbyXQCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 120)];
        [self addSubview:contentView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [self.image setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [contentView addSubview:self.image];
        self.cTitle=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 210, 20) Text:@"今天 09:14 心情沮丧"];
        [contentView addSubview:self.cTitle];
        self.cDescription=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 210, 20) Text:@"东来东往"];
        [self.cDescription setFont:[UIFont systemFontOfSize:18]];
        [contentView addSubview:self.cDescription];
        //播放
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(270, 10, 40, 40)];
        [self.image setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [contentView addSubview:self.image];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 50, 240, 40) Text:@"人生是一场孤独旅行，因此第一步我们不用刻意的追求信息的全面。"];
        [lbl setNumberOfLines:2];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [contentView addSubview:lbl];
        UIView *frame=[[UIView alloc]initWithFrame:CGRectMake1(60, 90, 240, 30)];
        UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 60, 30)];
        [button setTitle:@"私信" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:button];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(60, 0, 60, 30)];
        [button setTitle:@"分享" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:button];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(120, 0, 60, 30)];
        [button setTitle:@"关注" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:button];
        button=[[UIButton alloc]initWithFrame:CGRectMake1(180, 0, 60, 30)];
        [button setTitle:@"送鲜花" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(go:) forControlEvents:UIControlEventTouchUpInside];
        [frame addSubview:button];
        [contentView addSubview:frame];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)go:(id)sender
{
    NSLog(@"djfkdjf");
}

@end
