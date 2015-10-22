#import "ACContactCell.h"

@implementation ACContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblName=[[AttributedLabel alloc]initWithFrame:CGRectMake1(10, 7, 286, 25)];
        [_lblName setFont:[UIFont systemFontOfSize:19]];
        [_lblName setTextAlignment:NSTextAlignmentLeft];
        [_lblName setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_lblName];
        _lblPhone=[[AttributedLabel alloc]initWithFrame:CGRectMake1(15, 32, 163, 26)];
        [_lblPhone setFont:[UIFont systemFontOfSize:15]];
        [_lblPhone setTextAlignment:NSTextAlignmentLeft];
        [_lblPhone setBackgroundColor:[UIColor clearColor]];
        [_lblPhone setTextColor:RGBCOLOR(150, 150, 150)];
        [self addSubview:_lblPhone];
    }
    return self;
}

@end
