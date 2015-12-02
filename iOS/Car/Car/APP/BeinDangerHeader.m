//
//  BeinDangerHeader.m
//  Car
//
//  Created by Start on 11/24/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BeinDangerHeader.h"
#import "XLButtonPICTEXT.h"

@implementation BeinDangerHeader

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lblAddress=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 40)];
        [self addSubview:self.lblAddress];
        self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake1(5, 40, 310, 90)];
        [self addSubview:self.scrollView];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(CGWidth(25), CGHeight(140), CGWidth(270), 1)];
        [lineView setBackgroundColor:BCOLOR(150)];
        [self addSubview:lineView];
        
        self.ivStepOne=[[UIImageView alloc]initWithFrame:CGRectMake1(65, 135, 10, 10)];
        [self addSubview:self.ivStepOne];
        self.ivStepTwo=[[UIImageView alloc]initWithFrame:CGRectMake1(155, 135, 10, 10)];
        [self addSubview:self.ivStepTwo];
        self.ivStepThree=[[UIImageView alloc]initWithFrame:CGRectMake1(245, 135, 10, 10)];
        [self addSubview:self.ivStepThree];
        
        self.lblStepOne=[[XLLabel alloc]initWithFrame:CGRectMake1(25, 140, 90, 40)];
        [self.lblStepOne setText:@"初审中"];
        [self.lblStepOne setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblStepOne];
        
        self.lblStepTwo=[[XLLabel alloc]initWithFrame:CGRectMake1(115, 140, 90, 40)];
        [self.lblStepTwo setText:@"责任认定"];
        [self.lblStepTwo setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblStepTwo];
        
        self.lblStepThree=[[XLLabel alloc]initWithFrame:CGRectMake1(205, 140, 90, 40)];
        [self.lblStepThree setText:@"保险定损"];
        [self.lblStepThree setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblStepThree];
    }
    return self;
}

- (void)setCurrentType:(NSInteger)type
{
    [self.ivStepOne setImage:[UIImage imageNamed:@"灰点"]];
    [self.ivStepTwo setImage:[UIImage imageNamed:@"灰点"]];
    [self.ivStepThree setImage:[UIImage imageNamed:@"灰点"]];
    [self.lblStepOne setTextColor:BCOLOR(150)];
    [self.lblStepTwo setTextColor:BCOLOR(150)];
    [self.lblStepThree setTextColor:BCOLOR(150)];
    if(type==1){
        [self.ivStepOne setImage:[UIImage imageNamed:@"圆点_提示"]];
        [self.lblStepOne setTextColor:BGCOLOR];
    }else if(type==2){
        [self.ivStepTwo setImage:[UIImage imageNamed:@"圆点_提示"]];
        [self.lblStepTwo setTextColor:BGCOLOR];
    }else{
        [self.ivStepThree setImage:[UIImage imageNamed:@"圆点_提示"]];
        [self.lblStepThree setTextColor:BGCOLOR];
    }
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