//
//  PlayerButton.m
//  Ume
//
//  Created by Start on 15/7/7.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "PlayerButton.h"

@implementation PlayerButton

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius=self.bounds.size.width/2;
        self.layer.masksToBounds=YES;
        self.layer.borderWidth=1;
        self.layer.borderColor=[[UIColor whiteColor]CGColor];
        [self setImage:[UIImage imageNamed:@"icon-play-small"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"icon-play-small"] forState:UIControlStateHighlighted];
        self.imageView.animationImages = [NSArray arrayWithObjects:
                                                  [UIImage imageNamed:@"播放中-1"],
                                                  [UIImage imageNamed:@"播放中-2"],
                                                  [UIImage imageNamed:@"播放中-3"],
                                                  [UIImage imageNamed:@"播放中-4"], nil];
        self.imageView.animationDuration = 1.0;
        self.imageView.animationRepeatCount = 0;
    }
    return self;
}

@end
