//
//  MyImagesCell.m
//  Ume
//
//  Created by Start on 15/6/12.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MyImagesCell.h"

@implementation MyImagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.scrollViewFrame=[[UIScrollView alloc]initWithFrame:CGRectMake1(0, 0, 320, 80)];
        [self.scrollViewFrame setContentSize:CGSizeMake1(800, 80)];
        [self.scrollViewFrame setShowsHorizontalScrollIndicator:NO];
        [self addSubview:self.scrollViewFrame];
    }
    return self;
}

@end
