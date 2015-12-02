//
//  BeinDangerHistoryCell.m
//  Car
//
//  Created by Start on 11/3/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerHistoryCell.h"

@implementation BeinDangerHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //时间
        self.lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(5, 5, 35, 20)];
        [self.lblTime setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblTime];
        //地址
        self.lblAddress=[[XLLabel alloc]initWithFrame:CGRectMake1(40, 5, 200, 20)];
        [self addSubview:self.lblAddress];
        //状态
        self.lblStatus=[[XLLabel alloc]initWithFrame:CGRectMake1(245, 5, 70, 20)];
        [self.lblStatus setTextColor:RGBCOLOR(219, 83, 35)];
        [self.lblStatus setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lblStatus];
        //图片
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake1(5, 25, 310, 90)];
        [self.scrollView setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.scrollView];
        UIView *line=[[UIView alloc]initWithFrame:CGRectMake1(0, 115, 320, 1)];
        [line setBackgroundColor:BCOLOR(207)];
        [self addSubview:line];
    }
    return self;
}

- (void)addSubImage:(NSString*)imageNamed
{
    NSInteger count=[[self.scrollView subviews]count];
    CGFloat width=count*80+count*5;
    XLImageView *imv=[[XLImageView alloc]initWithFrame:CGRectMake1(width, 5, 80, 80)];
    [imv loadImageNetUrl:imageNamed];
    [self.scrollView setContentSize:CGSizeMake1(width+80, 90)];
    [self.scrollView addSubview:imv];
}

@end