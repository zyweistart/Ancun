//
//  ButtonCell.m
//  Ume
//
//  Created by Start on 15/7/21.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "ButtonCell.h"

@implementation ButtonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.rightButton=[[CButton alloc]initWithFrame:CGRectMake1(240, 7.5, 70, 30) Name:@"解除绑定" Type:8];
        self.rightButton.layer.cornerRadius = CGWidth(2);
        [self.rightButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:self.rightButton];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
