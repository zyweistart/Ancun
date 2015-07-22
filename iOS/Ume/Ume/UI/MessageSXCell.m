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
        self.meHeader=[[ImageViewHeader alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [mainView addSubview:self.meHeader];
        self.lblName=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 150, 20)];
        [self.lblName setFont:[UIFont systemFontOfSize:18]];
        [self.lblName setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.lblName];
        self.lblContent=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 150, 20)];
        [self.lblContent setTextColor:DEFAUL1COLOR];
        [self.lblContent setFont:[UIFont systemFontOfSize:14]];
        [self.lblContent setTextAlignment:NSTextAlignmentLeft];
        [mainView addSubview:self.lblContent];
        self.lblTime=[[CLabel alloc]initWithFrame:CGRectMake1(210, 10, 100, 20)];
        [self.lblTime setTextColor:DEFAUL1COLOR];
        [self.lblTime setFont:[UIFont systemFontOfSize:14]];
        [self.lblTime setTextAlignment:NSTextAlignmentRight];
        [mainView addSubview:self.lblTime];
        
        [self.meHeader setImage:[UIImage imageNamed:@"img_boy"]];
        [self.lblName setText:@"果冻官方"];
        [self.lblContent setText:@"最近情绪为沮丧"];
        [self.lblTime setText:@"14-09-08"];
    }
    return self;
}

@end
