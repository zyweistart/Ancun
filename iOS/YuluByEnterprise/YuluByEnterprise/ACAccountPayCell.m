#import "ACAccountPayCell.h"

@implementation ACAccountPayCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lblName=[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 160, 30)];
        [_lblName setFont:[UIFont systemFontOfSize:15]];
        [_lblName setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
//        [_lblName setText:@"基础套餐"];
        [self addSubview:_lblName];
        _lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 160, 30)];
        [_lblInfo setFont:[UIFont systemFontOfSize:15]];
        [_lblInfo setTextColor:[UIColor colorWithRed:(43/255.0) green:(144/255.0) blue:(209/255.0) alpha:1]];
//        [_lblInfo setText:@"1分钟 2MB"];
//        [self addSubview:_lblInfo];
        
        if([@"ACAccountPayCell" isEqualToString:reuseIdentifier]) {
            UILabel *lblStart=[[UILabel alloc]initWithFrame:CGRectMake(195, 5, 35, 30)];
            [lblStart setFont:[UIFont systemFontOfSize:15]];
            [lblStart setTextColor:[UIColor colorWithRed:(119/255.0) green:(127/255.0) blue:(145/255.0) alpha:1]];
            [lblStart setText:@"生效"];
            [self addSubview:lblStart];
            _lblStartTime=[[UILabel alloc]initWithFrame:CGRectMake(230, 5, 80, 30)];
            [_lblStartTime setFont:[UIFont systemFontOfSize:15]];
            [_lblStartTime setTextColor:[UIColor colorWithRed:(119/255.0) green:(127/255.0) blue:(145/255.0) alpha:1]];
//            [_lblStartTime setText:@"2013-08-06"];
            [self addSubview:_lblStartTime];
            UILabel *lblEnd=[[UILabel alloc]initWithFrame:CGRectMake(195, 35, 35, 30)];
            [lblEnd setFont:[UIFont systemFontOfSize:15]];
            [lblEnd setTextColor:[UIColor colorWithRed:(119/255.0) green:(127/255.0) blue:(145/255.0) alpha:1]];
            [lblEnd setText:@"到期"];
            [self addSubview:lblEnd];
            _lblEndTime=[[UILabel alloc]initWithFrame:CGRectMake(230, 35, 80, 30)];
            [_lblEndTime setFont:[UIFont systemFontOfSize:15]];
            [_lblEndTime setTextColor:[UIColor colorWithRed:(238/255.0) green:(126/255.0) blue:(7/255.0) alpha:1]];
//            [_lblEndTime setText:@"2013-09-06"];
            [self addSubview:_lblEndTime];
        } else if([@"ACAccountPayCellTimeLong" isEqualToString:reuseIdentifier]) {
            UILabel *lblTimeLong=[[UILabel alloc]initWithFrame:CGRectMake(250, 20, 60, 30)];
            [lblTimeLong setFont:[UIFont systemFontOfSize:15]];
            [lblTimeLong setTextColor:[UIColor colorWithRed:(238/255.0) green:(126/255.0) blue:(7/255.0) alpha:1]];
            [lblTimeLong setText:@"不限时长"];
            [self addSubview:lblTimeLong];
        }
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

@end
