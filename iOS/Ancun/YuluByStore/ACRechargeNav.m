#import "ACRechargeNav.h"

#define TEXTCOLOR [UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]
#define NAVTOPCOLOR [UIColor colorWithRed:(255/255.0) green:(142/255.0) blue:(32/255.0) alpha:1]
#define BACKGROUNDCOLOR [UIColor colorWithRed:(233/255.0) green:(233/255.0) blue:(233/255.0) alpha:1]

@implementation ACRechargeNav {
    UIButton *_lblTip1;
    UIButton *_lblTip2;
    UIButton *_lblTip3;
    UIButton *_lblTip4;
}

//CGRectMake1(x,y,320,40);
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:BACKGROUNDCOLOR];
        
        _lblTip1=[[UIButton alloc]initWithFrame:CGRectMake1(0, 0, 80, 40)];
        [_lblTip1.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_lblTip1 setTitle:@"选择套餐" forState:UIControlStateNormal];
        [self addSubview:_lblTip1];
        
        _lblTip2=[[UIButton alloc]initWithFrame:CGRectMake1(80, 0, 80, 40)];
        [_lblTip2.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_lblTip2 setTitle:@"确认信息" forState:UIControlStateNormal];
        [self addSubview:_lblTip2];
        
        _lblTip3=[[UIButton alloc]initWithFrame:CGRectMake1(160, 0, 80, 40)];
        [_lblTip3.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_lblTip3 setTitle:@"支付" forState:UIControlStateNormal];
        [self addSubview:_lblTip3];
        
        _lblTip4=[[UIButton alloc]initWithFrame:CGRectMake1(240, 0, 80, 40)];
        [_lblTip4.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_lblTip4 setTitle:@"成功" forState:UIControlStateNormal];
        [self addSubview:_lblTip4];
        
    }
    return self;
}

- (void)firstStep {
    [_lblTip1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip1 setBackgroundImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
    [_lblTip2 setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [_lblTip2 setBackgroundImage:[self createImageWithColor:BACKGROUNDCOLOR] forState:UIControlStateNormal];
    [_lblTip3 setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [_lblTip3 setBackgroundImage:[self createImageWithColor:BACKGROUNDCOLOR] forState:UIControlStateNormal];
    [_lblTip4 setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [_lblTip4 setBackgroundImage:[self createImageWithColor:BACKGROUNDCOLOR] forState:UIControlStateNormal];
}

- (void)secondStep {
    [_lblTip1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip1 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip2 setBackgroundImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
    [_lblTip3 setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [_lblTip3 setBackgroundImage:[self createImageWithColor:BACKGROUNDCOLOR] forState:UIControlStateNormal];
    [_lblTip4 setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [_lblTip4 setBackgroundImage:[self createImageWithColor:BACKGROUNDCOLOR] forState:UIControlStateNormal];
}

- (void)thirdStep {
    [_lblTip1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip1 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip2 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip3 setBackgroundImage:[UIImage imageNamed:@"nav"] forState:UIControlStateNormal];
    [_lblTip4 setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    [_lblTip4 setBackgroundImage:[self createImageWithColor:BACKGROUNDCOLOR] forState:UIControlStateNormal];
}

- (void)fourthStep {
    [_lblTip1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip1 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip2 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip2 setBackgroundImage:nil forState:UIControlStateNormal];
    [_lblTip3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip3 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip3 setBackgroundImage:nil forState:UIControlStateNormal];
    [_lblTip4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblTip4 setBackgroundColor:NAVTOPCOLOR];
    [_lblTip4 setBackgroundImage:nil forState:UIControlStateNormal];
}

- (UIImage*)createImageWithColor:(UIColor*)color
{
    CGRect rect=CGRectMake1(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end