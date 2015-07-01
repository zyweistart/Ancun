//
//  MessageCell.m
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 8, 24, 24)];
        [self addSubview:self.image];
        
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(44, 0, 100, 45)];
        [self.lblTitle setFont:[UIFont systemFontOfSize:16]];
        [self.lblTitle setTextColor:DEFAULTITLECOLOR(30)];
        [self.lblTitle setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblTitle];
        
        self.lblCount=[[UILabel alloc]initWithFrame:CGRectMake1(270, 12.5, 20, 20)];
        self.lblCount.layer.cornerRadius = self.lblCount.bounds.size.width/2;
        self.lblCount.layer.masksToBounds = YES;
        [self.lblCount setFont:[UIFont systemFontOfSize:16]];
        [self.lblCount setTextColor:[UIColor whiteColor]];
        [self.lblCount setBackgroundColor:[UIColor redColor]];
        [self.lblCount setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblCount];
        
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

@end
