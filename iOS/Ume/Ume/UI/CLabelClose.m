//
//  CLabelClose.m
//  Ume
//
//  Created by Start on 15/7/13.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "CLabelClose.h"

@implementation CLabelClose

- (id)initWithFrame:(CGRect)rect Text:(NSString*)text
{
    self=[super initWithFrame:rect];
    if(self){
        self.lblText=[[CLabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40) Text:text];
        [self.lblText setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.lblText];
        self.bClose=[[UIButton alloc]initWithFrame:CGRectMake(45, 0, 20, 20)];
        [self.bClose setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [self addSubview:self.bClose];
    }
    return self;
}

@end
