#import "ACContactCell.h"

@implementation ACContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 7, 286, 25)];
        [_lblName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        [_lblName setTextAlignment:NSTextAlignmentLeft];
        [_lblName setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_lblName];
        _lblPhone=[[UILabel alloc]initWithFrame:CGRectMake(15, 32, 163, 26)];
        [_lblPhone setFont:[UIFont systemFontOfSize:15]];
        [_lblPhone setTextAlignment:NSTextAlignmentLeft];
        [_lblPhone setBackgroundColor:[UIColor clearColor]];
        [_lblPhone setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self addSubview:_lblPhone];
    }
    return self;
}

@end
