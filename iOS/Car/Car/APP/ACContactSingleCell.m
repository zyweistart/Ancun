//
//  ACContactSingleCell.m
//  Ancun
//
//  Created by Start on 4/22/15.
//
//

#import "ACContactSingleCell.h"

@implementation ACContactSingleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblPhone=[[AttributedLabel alloc]initWithFrame:CGRectMake1(10, 7, 163, 26)];
        [_lblPhone setFont:[UIFont systemFontOfSize:15]];
        [_lblPhone setTextAlignment:NSTextAlignmentLeft];
        [_lblPhone setBackgroundColor:[UIColor clearColor]];
        [_lblPhone setTextColor:RGBCOLOR(150, 150, 150)];
        [self addSubview:_lblPhone];
    }
    return self;
}

@end
