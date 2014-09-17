#import "LoadingCell.h"

//高度50
@implementation LoadingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 10, 200, 30)];
        [_lbl setTextAlignment:NSTextAlignmentCenter];
        [_lbl setFont:[UIFont systemFontOfSize:15]];
        [self addSubview:_lbl];
        
        _loading =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_loading setFrame:CGRectMake(265, 15, 20, 20)];
        [self addSubview:_loading];
    }
    return self;
}

@end
