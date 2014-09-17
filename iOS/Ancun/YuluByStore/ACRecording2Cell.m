#import "ACRecording2Cell.h"

@implementation ACRecording2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 4, 195, 24)];
        [_lblName setFont:[UIFont systemFontOfSize:19]];
        [_lblName setTextColor:FONTCOLOR1];
        [self addSubview:_lblName];
        _lblOppno=[[UILabel alloc]initWithFrame:CGRectMake(14, 28, 136, 21)];
        [_lblOppno setFont:[UIFont systemFontOfSize:17]];
        [_lblOppno setTextColor:FONTCOLOR1];
        [self addSubview:_lblOppno];
        _lblLcalltime=[[UILabel alloc]initWithFrame:CGRectMake(200, 26, 100, 21)];
        [_lblLcalltime setFont:[UIFont systemFontOfSize:15]];
        [_lblLcalltime setTextAlignment:NSTextAlignmentCenter];
        [_lblLcalltime setTextColor:FONTCOLOR2];
        [self addSubview:_lblLcalltime];
        _lblRtcount=[[UILabel alloc]initWithFrame:CGRectMake(14, 51, 75, 21)];
        [_lblRtcount setFont:[UIFont systemFontOfSize:15]];
        [_lblRtcount setTextColor:FONTCOLOR2];
        [self addSubview:_lblRtcount];
        _lblOrttime=[[UILabel alloc]initWithFrame:CGRectMake(97, 51, 112, 21)];
        [_lblOrttime setFont:[UIFont systemFontOfSize:15]];
        [_lblOrttime setTextColor:FONTCOLOR2];
        [self addSubview:_lblOrttime];
        
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return self;
}

@end