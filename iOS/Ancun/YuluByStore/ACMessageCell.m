//
//  ACMessageCell.m
//  Ancun
//
//  Created by Start on 15/9/21.
//
//

#import "ACMessageCell.h"

@implementation ACMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.lblTitle=[[UILabel alloc]initWithFrame:CGRectMake1(10, 0, 300, 25)];
        [self.lblTitle setFont:[UIFont systemFontOfSize:16]];
        [self.lblTitle setTextColor:[UIColor blackColor]];
        [self.lblTitle setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblTitle];
        self.lblContent=[[UILabel alloc]initWithFrame:CGRectMake1(10, 25, 290, 20)];
        [self.lblContent setFont:[UIFont systemFontOfSize:15]];
        [self.lblContent setTextColor:[UIColor grayColor]];
        [self.lblContent setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:self.lblContent];
        self.lblDate=[[UILabel alloc]initWithFrame:CGRectMake1(20, 45, 270, 20)];
        [self.lblDate setFont:[UIFont systemFontOfSize:13]];
        [self.lblDate setTextColor:[UIColor grayColor]];
        [self.lblDate setTextAlignment:NSTextAlignmentRight];
        [self addSubview:self.lblDate];
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

@end