//
//  XLLabel.m
//  XinHu
//
//  Created by Start on 15/8/11.
//  Copyright (c) 2015年 AnCun. All rights reserved.
//

#import "XLLabel.h"

@implementation XLLabel

- (id)initWithFrame:(CGRect)rect
{
    self=[self initWithFrame:rect Text:@""];
    if(self){
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)rect Text:(NSString*)text
{
    self=[super initWithFrame:rect];
    if(self){
        [self setText:text];
        [self setFont:GLOBAL_FONTSIZE(13)];
        [self setTextColor:BCOLOR(120)];
        [self setTextAlignment:NSTextAlignmentLeft];
//        [self setBackgroundColor:[UIColor redColor]];
    }
    return self;
}

//- (void)setText:(NSString *)text
//{
//    [super setText:text];
//    CGSize fontSize = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName, nil]];
//    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, fontSize.width, self.frame.size.height)];
//}

@end