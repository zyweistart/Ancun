//
//  PlayerVoiceButton.m
//  Ume
//
//  Created by Start on 15/7/8.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "PlayerVoiceButton.h"

@implementation PlayerVoiceButton

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        CGFloat width=frame.size.width;
        if(width>60){
            self.layer.cornerRadius=CGWidth(15);
        }else{
            self.layer.cornerRadius=CGWidth(10);
        }
        self.layer.masksToBounds=YES;
        self.layer.borderWidth=1;
        self.layer.borderColor=[COLOR2552160 CGColor];
        [self setImage:[UIImage imageNamed:@"语音播放-1"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"语音播放-1"] forState:UIControlStateHighlighted];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, CGWidth(5), 0, 0)];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self setTitle:@"55'" forState:UIControlStateNormal];
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, CGWidth(10), 0, 0)];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.imageView.animationImages = [NSArray arrayWithObjects:
                                                 [UIImage imageNamed:@"语音播放-1"],
                                                 [UIImage imageNamed:@"语音播放-2"],
                                                 [UIImage imageNamed:@"语音播放-3"],
                                                 [UIImage imageNamed:@"语音播放-4"], nil];
        self.imageView.animationDuration = 1.0;
        self.imageView.animationRepeatCount = 0;
    }
    return self;
}

+ (CGFloat)getPlayerWidthToSecond:(int)curSecond
{
    if(curSecond>65){
        return 150;
    }
    return 35+curSecond;
}

@end
