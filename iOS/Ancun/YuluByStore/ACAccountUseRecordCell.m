#import "ACAccountUseRecordCell.h"

@implementation ACAccountUseRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lblDate=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 60)];
        [_lblDate setFont:[UIFont systemFontOfSize:12]];
        [_lblDate setTextAlignment:NSTextAlignmentCenter];
        [_lblDate setLineBreakMode:NSLineBreakByCharWrapping];
        [_lblDate setNumberOfLines:0];
        [_lblDate setTextColor:FONTCOLOR1];
        [self addSubview:_lblDate];
        
        _lblContent=[[UILabel alloc]initWithFrame:CGRectMake(75, 5, 160, 60)];
        [_lblContent setFont:[UIFont systemFontOfSize:13]];
        [_lblContent setTextAlignment:NSTextAlignmentCenter];
        [_lblContent setLineBreakMode:NSLineBreakByCharWrapping];
        [_lblContent setNumberOfLines:0];
        [_lblContent setTextColor:FONTCOLOR1];
        [self addSubview:_lblContent];
        
        _lblRemark=[[UILabel alloc]initWithFrame:CGRectMake(235, 5, 80, 60)];
        [_lblRemark setFont:[UIFont systemFontOfSize:13]];
        [_lblRemark setTextAlignment:NSTextAlignmentCenter];
        [_lblRemark setLineBreakMode:NSLineBreakByCharWrapping];
        [_lblRemark setNumberOfLines:0];
        [_lblRemark setTextColor:FONTCOLOR2];
        [self addSubview:_lblRemark];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
    }
    return self;
}

@end
