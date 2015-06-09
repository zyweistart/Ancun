//
//  MessageZGCell.m
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageZGCell.h"
#import "CButton.h"
#import "CLabel.h"

@implementation MessageZGCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
        [self addSubview:mainView];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 30, 30)];
        [image setBackgroundColor:[UIColor redColor]];
        [mainView addSubview:image];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 10, 100, 30)];
        [lbl setText:@"lohas"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(210, 10, 100, 30)];
        [lbl setText:@"今天 09:14"];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [mainView addSubview:lbl];
        
        CButton *button=[[CButton alloc]initWithFrame:CGRectMake1(230, 50, 80, 30) Name:@"关注" Type:1];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [mainView addSubview:button];
        
        image=[[UIImageView alloc]initWithFrame:CGRectMake1(30, 90, 100, 100)];
        [image setBackgroundColor:[UIColor redColor]];
        [mainView addSubview:image];
        
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(140, 90, 170, 100)];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setText:@"这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述这里为当前用户发表语音文字的描述"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setNumberOfLines:7];
        [lbl sizeToFit];
        [mainView addSubview:lbl];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
