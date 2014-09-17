#import "ACRechargeNav.h"

#define NAVTOPCOLOR [UIColor colorWithRed:(255/255.0) green:(142/255.0) blue:(32/255.0) alpha:1]
#define BACKGROUNDCOLOR [UIColor colorWithRed:(233/255.0) green:(233/255.0) blue:(233/255.0) alpha:1]
#define TEXTCOLOR [UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]

@implementation ACRechargeNav {
    UILabel *_lblTip1;
    UILabel *_lblTip2;
    UILabel *_lblTip3;
    UILabel *_lblTip4;
}

//CGRectMake(x,y,320,40);
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:(233/255.0) green:(233/255.0) blue:(233/255.0) alpha:1]];
        
        _lblTip1=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
        [_lblTip1 setFont:[UIFont systemFontOfSize:13]];
        [_lblTip1 setTextAlignment:NSTextAlignmentCenter];
        [_lblTip1 setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"nav"]]];
        [_lblTip1 setTextColor:[UIColor whiteColor]];
        [_lblTip1 setText:@"选择套餐"];
        [self addSubview:_lblTip1];
        
        _lblTip2=[[UILabel alloc]initWithFrame:CGRectMake(80, 0, 80, 40)];
        [_lblTip2 setFont:[UIFont systemFontOfSize:13]];
        [_lblTip2 setTextAlignment:NSTextAlignmentCenter];
        [_lblTip2 setTextColor:TEXTCOLOR];
        [_lblTip2 setText:@"确认信息"];
        [self addSubview:_lblTip2];
        
        _lblTip3=[[UILabel alloc]initWithFrame:CGRectMake(160, 0, 80, 40)];
        [_lblTip3 setFont:[UIFont systemFontOfSize:13]];
        [_lblTip3 setTextAlignment:NSTextAlignmentCenter];
        [_lblTip3 setTextColor:TEXTCOLOR];
        [_lblTip3 setText:@"支付"];
        [self addSubview:_lblTip3];
        
        _lblTip4=[[UILabel alloc]initWithFrame:CGRectMake(240, 0, 80, 40)];
        [_lblTip4 setFont:[UIFont systemFontOfSize:13]];
        [_lblTip4 setTextAlignment:NSTextAlignmentCenter];
        [_lblTip4 setTextColor:TEXTCOLOR];
        [_lblTip4 setText:@"成功"];
        [self addSubview:_lblTip4];
    }
    return self;
}

- (void)firstStep {
    [_lblTip1 setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"nav"]]];
    [_lblTip1 setTextColor:[UIColor whiteColor]];
    [_lblTip2 setBackgroundColor:BACKGROUNDCOLOR];
    [_lblTip2 setTextColor:TEXTCOLOR];
    [_lblTip3 setBackgroundColor:BACKGROUNDCOLOR];
    [_lblTip3 setTextColor:TEXTCOLOR];
    [_lblTip4 setBackgroundColor:BACKGROUNDCOLOR];
    [_lblTip4 setTextColor:TEXTCOLOR];
}

- (void)secondStep {
    [_lblTip1 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip1 setTextColor:[UIColor whiteColor]];
    [_lblTip2 setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"nav"]]];
    [_lblTip2 setTextColor:[UIColor whiteColor]];
    [_lblTip3 setBackgroundColor:BACKGROUNDCOLOR];
    [_lblTip3 setTextColor:TEXTCOLOR];
    [_lblTip4 setBackgroundColor:BACKGROUNDCOLOR];
    [_lblTip4 setTextColor:TEXTCOLOR];
}

- (void)thirdStep {
    [_lblTip1 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip1 setTextColor:[UIColor whiteColor]];
    [_lblTip2 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip2 setTextColor:[UIColor whiteColor]];
    [_lblTip3 setBackgroundColor:[[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"nav"]]];
    [_lblTip3 setTextColor:[UIColor whiteColor]];
    [_lblTip4 setBackgroundColor:BACKGROUNDCOLOR];
    [_lblTip4 setTextColor:TEXTCOLOR];
}

- (void)fourthStep {
    [_lblTip1 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip1 setTextColor:[UIColor whiteColor]];
    [_lblTip2 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip2 setTextColor:[UIColor whiteColor]];
    [_lblTip3 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip3 setTextColor:[UIColor whiteColor]];
    [_lblTip4 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip4 setTextColor:[UIColor whiteColor]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
