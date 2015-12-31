//
//  PhotoTableCell.m
//  Witness
//
//  Created by Start on 12/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "PhotoTableCell.h"

@implementation PhotoTableCell

//布局
- (void)layoutCell
{
    [self setBackgroundColor:[UIColor clearColor]];
    self.photo=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 60)];
    self.photo.layer.cornerRadius=3;
    self.photo.layer.masksToBounds=YES;
    [self addSubview:self.photo];
    
    self.lblName=[[UILabel alloc]initWithFrame:CGRectMake(100, 15, CGWidth(150), 25)];
//    [self.lblName setStyle:1];
    [self addSubview:self.lblName];
    
    self.ivLocal=[[UIImageView alloc]initWithFrame:CGRectMake(100, 45, 17, 22)];
    [self.ivLocal setImage:[UIImage imageNamed:@"locationd"]];
    [self addSubview:self.ivLocal];
    
    self.lblAddress=[[UILabel alloc]initWithFrame:CGRectMake(100+22, 45, CGWidth(190), 20)];
//    [self.lblAddress setStyle:2];
    [self addSubview:self.lblAddress];
    
    self.lblTime=[[UILabel alloc]initWithFrame:CGRectMake(CGWidth(250), 10, CGWidth(60), 25)];
//    [self.lblTime setStyle:2];
    [self.lblTime setTextAlignment:NSTextAlignmentRight];
    [self addSubview:self.lblTime];
    
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(CGWidth(10), 79, CGWidth(300), 1)];
//    [line setBackgroundColor:[Theme getInstance].tableLineColor];
    [self addSubview:line];
}

//设置Cell数据
- (void)setCellData:(Photo*)entity
{
    [self.lblName setText:entity.title];
    [self.lblAddress setText:entity.address];
    [self.lblTime setText:entity.addTime];
}

- (CGFloat)layoutHeight
{
    return 80;
}

@end
