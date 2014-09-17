//
//  ACAccountPay2Cell.m
//  Ancun
//
//  Created by Start on 4/4/14.
//
//

#import "ACAccountPay2Cell.h"
#import "StoreKit/StoreKit.h"
#import <QuartzCore/QuartzCore.h>
#import "ACPaymentViewController.h"

@implementation ACAccountPay2Cell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setBackgroundColor:[UIColor colorWithRed:147 green:222 blue:250 alpha:1]];
        
        _lblName=[[UILabel alloc]initWithFrame:CGRectMake(8, 5, 200, 25)];
        [_lblName setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
        [_lblName setTextAlignment:NSTextAlignmentLeft];
        [_lblName setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [_lblName setText:@"基础套餐"];
        [self addSubview:_lblName];
        
        _lblDescription=[[UILabel alloc]initWithFrame:CGRectMake(8, 30, 220, 60)];
        [_lblDescription setFont:[UIFont systemFontOfSize:12]];
        [_lblDescription setTextAlignment:NSTextAlignmentLeft];
        [_lblDescription setNumberOfLines:0];
        [_lblDescription setLineBreakMode:NSLineBreakByCharWrapping];
        [_lblDescription setTextColor:[UIColor colorWithRed:(163/255.0) green:(163/255.0) blue:(163/255.0) alpha:1]];
        [_lblDescription setText:@"有效期31天209分钟 309MB"];
        [self addSubview:_lblDescription];
        
        UIButton *_btnGoPay=[UIButton buttonWithType:UIButtonTypeCustom];
        [_btnGoPay setFrame:CGRectMake(250, 25, 60, 40)];
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
    if([SKPaymentQueue canMakePayments]) {
        ACPaymentViewController *paymentViewController=[[ACPaymentViewController alloc]initWithData:_data];
        [_controler.navigationController pushViewController:paymentViewController animated:YES];
    } else {
        [Common alert:@"支付功能被关闭无法使用"];
    }
}

@end

