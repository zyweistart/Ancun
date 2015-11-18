//
//  ApplyCell.m
//  Car
//
//  Created by Start on 11/18/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "ApplyCell.h"

@implementation ApplyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.ivType=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 15, 15, 15)];
        [self addSubview:self.ivType];
        self.lblName=[[XLLabel alloc]initWithFrame:CGRectMake1(30, 0, 200, 25)];
        [self.lblName setFont:GLOBAL_FONTSIZE(15)];
        [self.lblName setTextColor:BCOLOR(50)];
        [self addSubview:self.lblName];
        self.lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(30, 25, 200, 20)];
        [self addSubview:self.lblTime];
        
        self.bStatus=[[UIButton alloc]initWithFrame:CGRectMake1(235, 0, 80, 45)];
        [self.bStatus setTitle:@"已出证" forState:UIControlStateNormal];
        [self.bStatus.titleLabel setFont:GLOBAL_FONTSIZE(13)];
        [self.bStatus setTitleColor:BGCOLOR forState:UIControlStateNormal];
        [self.bStatus setImage:[UIImage imageNamed:@"审核通过"] forState:UIControlStateNormal];
        [self.bStatus setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
        [self addSubview:self.bStatus];
    }
    return self;
}



@end
