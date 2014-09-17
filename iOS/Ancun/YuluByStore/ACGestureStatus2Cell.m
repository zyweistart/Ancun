//
//  ACGestureStatus2Cell.m
//  Ancun
//
//  Created by Start on 4/14/14.
//
//

#import "ACGestureStatus2Cell.h"

@implementation ACGestureStatus2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 25)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setText:@"手势密码设置"];
        [lbl setTextColor:FONTCOLOR1];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [self addSubview:lbl];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

@end
