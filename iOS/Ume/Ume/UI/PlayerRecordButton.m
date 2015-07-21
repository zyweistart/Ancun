//
//  PlayerRecordButton.m
//  Ume
//
//  Created by Start on 15/7/21.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "PlayerRecordButton.h"
#import "UIImage+Utils.h"

@implementation PlayerRecordButton

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        self.layer.cornerRadius=self.bounds.size.width/2;
        self.layer.masksToBounds=YES;
        self.layer.borderWidth=1;
        self.layer.borderColor=[[UIColor whiteColor]CGColor];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView.image transformWidth:CGWidth(10) height:CGHeight(10)];
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
