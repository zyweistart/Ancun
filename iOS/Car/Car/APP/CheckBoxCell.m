//
//  CheckBoxCell.m
//  Car
//
//  Created by Start on 11/18/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "CheckBoxCell.h"

@implementation CheckBoxCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lblName=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 0, 265, 25)];
        [self.lblName setFont:GLOBAL_FONTSIZE(15)];
        [self.lblName setTextColor:BCOLOR(50)];
        [self addSubview:self.lblName];
        self.lblTime=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 25, 265, 20)];
        [self addSubview:self.lblTime];
        self.bCheckBox=[[UIButton alloc]initWithFrame:CGRectMake1(280, 7, 30, 30)];
        [self.bCheckBox setImage:[UIImage imageNamed:@"单勾未选"] forState:UIControlStateNormal];
        [self.bCheckBox setImage:[UIImage imageNamed:@"单勾选中"] forState:UIControlStateSelected];
        [self.bCheckBox addTarget:self action:@selector(goSwitch:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.bCheckBox];
    }
    return self;
}

- (void)goSwitch:(UIButton*)sender
{
    [sender setSelected:!sender.selected];
}

@end
