//
//  CButtonAgreement.m
//  Car
//
//  Created by Start on 11/26/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "CButtonAgreement.h"

@implementation CButtonAgreement

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name
{
    self=[super initWithFrame:rect Name:name Type:6];
    if(self){
        [self.titleLabel setFont:GLOBAL_FONTSIZE(13)];
        [self setTitleColor:BCOLOR(150) forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"单勾未选"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"单勾选中"] forState:UIControlStateSelected];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        [self addTarget:self action:@selector(goAgreement) forControlEvents:UIControlEventTouchUpInside];
        [self setSelected:YES];
    }
    return self;
}

- (void)goAgreement
{
    [self setSelected:!self.selected];
}

@end