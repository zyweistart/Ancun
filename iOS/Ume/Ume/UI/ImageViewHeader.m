
//
//  ImageViewHeader.m
//  Ume
//
//  Created by Start on 15/7/15.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "ImageViewHeader.h"

@implementation ImageViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius=self.bounds.size.width/2;
        self.layer.masksToBounds=YES;
        self.layer.borderWidth=1;
        self.layer.borderColor=DEFAULTITLECOLOR(221).CGColor;
        [self setBackgroundColor:DEFAULTITLECOLOR(241)];
        [self setImage:[UIImage imageNamed:@"icon-nomatch"]];
    }
    return self;
}

@end
