#import "ACRecordingCell.h"

@implementation ACRecordingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblOppno=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 183, 21)];
        [_lblOppno setFont:[UIFont fontWithName:@"Helvetica-Bold" size:22]];
        [self addSubview:_lblOppno];
        _lblLcalltime=[[UILabel alloc]initWithFrame:CGRectMake(200, 19, 100, 21)];
        [_lblLcalltime setFont:[UIFont systemFontOfSize:19]];
        [_lblLcalltime setTextColor:NAVCOLOR];
        [self addSubview:_lblLcalltime];
        _lblRtcount=[[UILabel alloc]initWithFrame:CGRectMake(14, 34, 75, 21)];
        [_lblRtcount setFont:[UIFont systemFontOfSize:15]];
        [_lblRtcount setTextColor:[UIColor colorWithRed:(50/255.0) green:(50/255.0) blue:(50/255.0) alpha:1]];
        [self addSubview:_lblRtcount];
        _lblOrttime=[[UILabel alloc]initWithFrame:CGRectMake(97, 34, 95, 21)];
        [_lblOrttime setFont:[UIFont systemFontOfSize:15]];
        [_lblOrttime setTextColor:[UIColor colorWithRed:(50/255.0) green:(50/255.0) blue:(50/255.0) alpha:1]];
        [self addSubview:_lblOrttime];
        
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

@end
