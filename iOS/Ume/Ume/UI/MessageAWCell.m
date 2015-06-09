//
//  MessageAWCell.m
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageAWCell.h"
#import "CButton.h"
#import "CLabel.h"

@implementation MessageAWCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 200)];
        [self addSubview:mainView];
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 30, 30)];
        [image setBackgroundColor:[UIColor redColor]];
        [mainView addSubview:image];
        
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(50, 10, 100, 30)];
        [lbl setText:@"爱在西元前"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(210, 10, 100, 30)];
        [lbl setText:@"今天 09:14"];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [mainView addSubview:lbl];
        
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(150, 50, 80, 30)];
        [lbl setText:@"lohas"];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        
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
