//
//  RecordCell.m
//  Car
//
//  Created by Start on 10/27/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "RecordCell.h"

@implementation RecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lblName=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 0, 320, 25)];
        [self.lblName setFont:GLOBAL_FONTSIZE(15)];
        [self.lblName setTextColor:BCOLOR(50)];
        [self addSubview:self.lblName];
        self.lblSize=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 25, 150, 20)];
        [self addSubview:self.lblSize];
        self.lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(160, 25, 130, 20)];
        [self addSubview:self.lblTime];
        self.icUp=[[UIImageView alloc]initWithFrame:CGRectMake1(295, 25, 15, 15)];
        [self.icUp setImage:[UIImage imageNamed:@"上传"]];
        [self addSubview:self.icUp];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //设置背景色
    for (UIView *subView in self.subviews) {
        if ([NSStringFromClass([subView class]) isEqualToString:@"UITableViewCellDeleteConfirmationView"]) {
            ((UIView *)[subView.subviews firstObject]).backgroundColor = BGCOLOR;
        }
    }
}

@end
