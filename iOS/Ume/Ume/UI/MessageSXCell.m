//
//  MessageSXCell.m
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageSXCell.h"
#import "CButton.h"
#import "CLabel.h"

@implementation MessageSXCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *mainView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [self addSubview:mainView];
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [image setBackgroundColor:[UIColor redColor]];
        [mainView addSubview:image];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 150, 20)];
        [lbl setText:@"果冻官方"];
        [lbl setFont:[UIFont systemFontOfSize:18]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 150, 20)];
        [lbl setText:@"最近情绪为沮丧"];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(210, 10, 100, 30)];
        [lbl setText:@"14-09-08"];
        [lbl setTextColor:DEFAUL1COLOR];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [lbl setTextAlignment:NSTextAlignmentRight];
        [mainView addSubview:lbl];
    }
    return self;
}

@end
