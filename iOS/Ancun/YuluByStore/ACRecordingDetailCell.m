#import "ACRecordingDetailCell.h"

@implementation ACRecordingDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblDate=[[UILabel alloc]initWithFrame:CGRectMake(10, 8, 200, 21)];
        [_lblDate setFont:[UIFont systemFontOfSize:19]];
        [self addSubview:_lblDate];
        _lblDownloadflag=[[UILabel alloc]initWithFrame:CGRectMake(210, 20, 71, 21)];
        [_lblDownloadflag setFont:[UIFont systemFontOfSize:15]];
        [_lblDownloadflag setTextAlignment:NSTextAlignmentCenter];
        [_lblDownloadflag setTextColor:FONTCOLOR2];
        [self addSubview:_lblDownloadflag];
        _lblRemark=[[UILabel alloc]initWithFrame:CGRectMake(14, 32, 196, 21)];
        [_lblRemark setFont:[UIFont systemFontOfSize:15]];
        [_lblRemark setTextColor:FONTCOLOR2];
        [self addSubview:_lblRemark];
        [self setSelectionStyle:UITableViewCellSelectionStyleBlue];
        if(IOS7){
            [self setAccessoryType:UITableViewCellAccessoryDetailButton];
        }else{
            [self setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        }
    }
    return self;
}

@end
