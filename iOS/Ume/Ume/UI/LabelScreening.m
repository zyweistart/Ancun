//
//  LabelScreening.m
//  Ume
//
//  Created by Start on 15/7/15.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "LabelScreening.h"

@implementation LabelScreening

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        self.lblTitle=[[CLabel alloc]initWithFrame:CGRectMake1(10, 0, 60, 30) Text:@""];
        [self.lblTitle setFont:[UIFont systemFontOfSize:15]];
        [self.lblTitle setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblTitle];
        self.ivTag=[[UIImageView alloc]initWithFrame:CGRectMake1(75, 7.5, 15, 15)];
        [self.ivTag setImage:[UIImage imageNamed:@"icon-select"]];
        [self addSubview:self.ivTag];
        
        [self setSelected:NO];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [self.ivTag setHidden:!selected];
}

@end
