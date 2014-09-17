//
//  ACAccountPay1Cell.m
//  Ancun
//
//  Created by Start on 4/4/14.
//
//

#import "ACAccountPay1Cell.h"
#import <QuartzCore/QuartzCore.h>
#import "ACPaymentViewController.h"

@implementation ACAccountPay1Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:147 green:222 blue:250 alpha:1]];
        
        _lblName=[[UILabel alloc]initWithFrame:CGRectMake(8, 5, 150, 25)];
        [_lblName setFont:[UIFont systemFontOfSize:15]];
        [_lblName setTextAlignment:NSTextAlignmentLeft];
        [_lblName setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [self addSubview:_lblName];
        
        _lblTimeLong=[[UILabel alloc]initWithFrame:CGRectMake(8, 30, 150, 25)];
        [_lblTimeLong setFont:[UIFont systemFontOfSize:13]];
        [_lblTimeLong setTextAlignment:NSTextAlignmentLeft];
        [_lblTimeLong setTextColor:[UIColor colorWithRed:(163/255.0) green:(163/255.0) blue:(163/255.0) alpha:1]];
        [self addSubview:_lblTimeLong];
        
        if([@"ACAccountRechargeCell1" isEqualToString:reuseIdentifier]) {
            _lblTime=[[UILabel alloc]initWithFrame:CGRectMake(170, 8, 60, 22)];
            [_lblTime setFont:[UIFont systemFontOfSize:15]];
            [_lblTime setTextAlignment:NSTextAlignmentRight];
            [_lblTime setTextColor:[UIColor colorWithRed:(43/255.0) green:(144/255.0) blue:(209/255.0) alpha:1]];
            //            [_lblTime setText:@"209分钟"];
            [self addSubview:_lblTime];
            
            _lblStorage=[[UILabel alloc]initWithFrame:CGRectMake(170, 30, 60, 22)];
            [_lblStorage setFont:[UIFont systemFontOfSize:15]];
            [_lblStorage setTextAlignment:NSTextAlignmentRight];
            [_lblStorage setTextColor:[UIColor colorWithRed:(43/255.0) green:(144/255.0) blue:(209/255.0) alpha:1]];
            //            [_lblStorage setText:@"309MB"];
            [self addSubview:_lblStorage];
        } else {
            _lblTimeAndStorage=[[UILabel alloc]initWithFrame:CGRectMake(170, 15, 60, 30)];
            [_lblTimeAndStorage setFont:[UIFont systemFontOfSize:15]];
            [_lblTimeAndStorage setTextAlignment:NSTextAlignmentRight];
            [_lblTimeAndStorage setTextColor:[UIColor colorWithRed:(43/255.0) green:(144/255.0) blue:(209/255.0) alpha:1]];
            //            [_lblStorage setText:@"309MB"];
            [self addSubview:_lblTimeAndStorage];
        }
        
        _btnGoPay=[UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoPay setFrame:CGRectMake(250, 10, 60, 40)];
        [_btnGoPay setTitle:@"购买" forState:UIControlStateNormal];
        _btnGoPay.layer.cornerRadius=5;
        _btnGoPay.layer.masksToBounds=YES;
        [_btnGoPay setBackgroundColor:[UIColor colorWithRed:(140/255.0) green:(191/255.0) blue:(247/255.0) alpha:1]];
        [_btnGoPay addTarget:self action:@selector(goPay:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_btnGoPay];
        
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)goPay:(id)sender {
    ACPaymentViewController *paymentViewController=[[ACPaymentViewController alloc]initWithData:_data];
    [_controler.navigationController pushViewController:paymentViewController animated:YES];
}

@end
