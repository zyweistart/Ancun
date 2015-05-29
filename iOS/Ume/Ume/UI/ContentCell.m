//
//  ContentCell.m
//  Ume
//
//  Created by Start on 5/20/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "ContentCell.h"
#import "CLabel.h"

@implementation ContentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *contentView=[[UIView alloc]initWithFrame:CGRectMake1(0, 0, 320, 100)];
        [self addSubview:contentView];
        CLabel *lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 10, 80, 20) Text:@"11.5KM"];
        [contentView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(220, 10, 80, 20) Text:@"98'"];
        [contentView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(10, 80, 80, 20) Text:@"私信"];
        [contentView addSubview:lbl];
        lbl=[[CLabel alloc]initWithFrame:CGRectMake1(220, 80, 80, 20) Text:@"0懂我"];
        [contentView addSubview:lbl];
    }
    return self;
}

@end
