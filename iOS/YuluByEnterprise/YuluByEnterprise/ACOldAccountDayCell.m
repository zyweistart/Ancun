#import "ACOldAccountDayCell.h"

@implementation ACOldAccountDayCell

//高为60
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lblMonth=[[UILabel alloc]initWithFrame:CGRectMake(40, 5, 50, 25)];
        [_lblMonth setFont:[UIFont systemFontOfSize:20]];
        [_lblMonth setTextAlignment:NSTextAlignmentCenter];
        [_lblMonth setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [self addSubview:_lblMonth];
        
        _lblTime=[[UILabel alloc]initWithFrame:CGRectMake(40, 30, 50, 25)];
        [_lblTime setFont:[UIFont systemFontOfSize:15]];
        [_lblTime setTextAlignment:NSTextAlignmentCenter];
        [_lblTime setTextColor:[UIColor colorWithRed:(163/255.0) green:(163/255.0) blue:(163/255.0) alpha:1]];
        [self addSubview:_lblTime];
        
        _lblRemark=[[UILabel alloc]initWithFrame:CGRectMake(150, 10, 35, 30)];
        [_lblRemark setFont:[UIFont systemFontOfSize:15]];
        [_lblRemark setTextColor:[UIColor colorWithRed:(238/255.0) green:(126/255.0) blue:(7/255.0) alpha:1]];
        [self addSubview:_lblRemark];
        
        _lblValue=[[UILabel alloc]initWithFrame:CGRectMake(215, 10, 80, 30)];
        [_lblValue setFont:[UIFont systemFontOfSize:15]];
        [_lblValue setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [_lblValue setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:_lblValue];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
