#import "ACMoreCell.h"

@implementation ACMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(20, 9, 30, 30)];
        [self addSubview:_imgView];
        _lblName=[[UILabel alloc]initWithFrame:CGRectMake(58, 13, 242, 21)];
        [_lblName setFont:[UIFont systemFontOfSize:18]];
        [_lblName setTextAlignment:NSTextAlignmentLeft];
        [_lblName setBackgroundColor:[UIColor clearColor]];
        [_lblName setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self addSubview:_lblName];
    }
    return self;
}

@end
