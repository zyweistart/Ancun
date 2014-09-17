#import "ACAccountUseRecordCell.h"

@implementation ACAccountUseRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lblDate=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 60)];
        [_lblDate setFont:[UIFont systemFontOfSize:13]];
        [_lblDate setTextAlignment:NSTextAlignmentLeft];
        [_lblDate setLineBreakMode:UILineBreakModeCharacterWrap];
        [_lblDate setNumberOfLines:0];
        [_lblDate setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [self addSubview:_lblDate];
        
        _lblContent=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 160, 60)];
        [_lblContent setFont:[UIFont systemFontOfSize:13]];
        [_lblContent setTextAlignment:NSTextAlignmentCenter];
        [_lblContent setLineBreakMode:UILineBreakModeCharacterWrap];
        [_lblContent setNumberOfLines:0];
        [_lblContent setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [self addSubview:_lblContent];
        
        _lblRemark=[[UILabel alloc]initWithFrame:CGRectMake(235, 5, 80, 60)];
        [_lblRemark setFont:[UIFont systemFontOfSize:13]];
        [_lblRemark setTextAlignment:NSTextAlignmentRight];
        [_lblRemark setLineBreakMode:UILineBreakModeCharacterWrap];
        [_lblRemark setNumberOfLines:0];
        [_lblRemark setTextColor:[UIColor colorWithRed:(43/255.0) green:(144/255.0) blue:(209/255.0) alpha:1]];
        [self addSubview:_lblRemark];
        
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

@end
