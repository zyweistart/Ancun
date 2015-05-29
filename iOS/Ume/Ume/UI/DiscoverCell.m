//
//  DiscoverCell.m
//  Ume
//
//  Created by Start on 5/29/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "DiscoverCell.h"
#import "CLabel.h"

@implementation DiscoverCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 60)];
        [self addSubview:contentView];
        self.image=[[UIImageView alloc]initWithFrame:CGRectMake1(10, 10, 40, 40)];
        [self.image setImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
        [contentView addSubview:self.image];
        self.cTitle=[[CLabel alloc]initWithFrame:CGRectMake1(60, 10, 240, 20) Text:@"lohas"];
        [contentView addSubview:self.cTitle];
        self.cDescription=[[CLabel alloc]initWithFrame:CGRectMake1(60, 30, 240, 20) Text:@"感谢您使用懂"];
        [contentView addSubview:self.cDescription];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

@end
