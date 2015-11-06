//
//  SwitchCell.m
//  Car
//
//  Created by Start on 11/6/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.bSwitch=[[UIButton alloc]initWithFrame:CGRectMake1(260, 11, 50, 24)];
        [self.bSwitch setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [self.bSwitch setImage:[UIImage imageNamed:@"开启"] forState:UIControlStateSelected];
        [self addSubview:self.bSwitch];
    }
    return self;
}

@end