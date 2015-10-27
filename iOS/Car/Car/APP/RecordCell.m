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
        self.lblName=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 0, 320, 25) Text:@"20151023163253"];
        [self.lblName setFont:GLOBAL_FONTSIZE(15)];
        [self.lblName setTextColor:BCOLOR(50)];
        [self addSubview:self.lblName];
        self.lblSize=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 25, 150, 20) Text:@"206.45KB"];
        [self addSubview:self.lblSize];
        self.lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(160, 25, 160, 20) Text:@"2015-1-23 16:33:56"];
        [self addSubview:self.lblTime];
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
