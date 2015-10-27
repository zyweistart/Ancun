//
//  XLButton.m
//  XinHu
//
//  Created by Start on 15/8/11.
//  Copyright (c) 2015年 AnCun. All rights reserved.
//

#import "XLButton.h"
#import "UIColor+Utils.h"

@implementation XLButton

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name
{
    return [self initWithFrame:rect Name:name Type:1];
}

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name Type:(NSInteger)type
{
    self=[super initWithFrame:rect];
    if(self){
        self.layer.cornerRadius = CGWidth(10);
        self.layer.masksToBounds = YES;
        [self setTitle:name forState:UIControlStateNormal];
        [self.titleLabel setFont:GLOBAL_FONTSIZE(16)];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [self setType:type];
    }
    return self;
}

- (void)setType:(NSInteger)type
{
    if(type==1){
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[RGBCOLOR(120, 150, 250) TransformationWithImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[RGBCOLOR(120, 150, 250) TransformationWithImage] forState:UIControlStateHighlighted];
    }else if(type==2){
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[BCOLOR(153) TransformationWithImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[BCOLOR(204) TransformationWithImage] forState:UIControlStateHighlighted];
    }else if(type==3){
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[RGBCOLOR(51, 155, 154) TransformationWithImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[RGBCOLOR(149, 207, 206) TransformationWithImage] forState:UIControlStateHighlighted];
    }else{
        [self setBackgroundImage:[[UIColor clearColor] TransformationWithImage] forState:UIControlStateNormal];
        [self setBackgroundImage:[[UIColor clearColor] TransformationWithImage] forState:UIControlStateHighlighted];
    }
}

@end