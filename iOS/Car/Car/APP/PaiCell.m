//
//  PaiCell.m
//  Car
//
//  Created by Start on 11/25/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "PaiCell.h"

@implementation PaiCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.ivView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 60, 60)];
        [self addSubview:self.ivView];
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(80, 15, 230, 40)];
        [self.lblTitle setFont:GLOBAL_FONTSIZE(14)];
        [self.lblTitle setTextColor:BCOLOR(150)];
        [self.lblTitle setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblTitle];
    }
    return self;
}

@end