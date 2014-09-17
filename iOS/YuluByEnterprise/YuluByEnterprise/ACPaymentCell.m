#import "ACPaymentCell.h"
#import "StoreKit/StoreKit.h"
#import <QuartzCore/QuartzCore.h>
#import "ACRechargeConfirmViewController.h"

@implementation ACPaymentCell

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
        
        _lblDescription=[[UILabel alloc]initWithFrame:CGRectMake(8, 30, 220, 50)];
        [_lblDescription setFont:[UIFont systemFontOfSize:13]];
        [_lblDescription setTextAlignment:NSTextAlignmentLeft];
        [_lblDescription setNumberOfLines:0];
        [_lblDescription setLineBreakMode:UILineBreakModeCharacterWrap];
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
        ACRechargeConfirmViewController *rechargeConfirm=[[ACRechargeConfirmViewController alloc] init];
        [rechargeConfirm setCurrentType:_currentType];
        [rechargeConfirm setData:_data];
        if(_currentType ==1) {
            if([[Config Instance]isOldUser]&&[[[[Config Instance] userInfo]objectForKey:@"payuserflag"]intValue]==1){
                int rectime=[[[[Config Instance]userInfo]objectForKey:@"rectime"]intValue]/60;
                if(rectime>0) {
                    [Common actionSheet:self message:[NSString stringWithFormat:@"您原时长套餐还剩%d分钟，衷心建议您用完原套餐再充值，如果您坚持继续充值，原套餐中的可录音时长会被清零，多可惜啊",rectime] tag:1];
                } else {
                    //新用户充值
                    [_controler.navigationController pushViewController:rechargeConfirm animated:YES];
                }
            } else {
                //新用户充值
                [_controler.navigationController pushViewController:rechargeConfirm animated:YES];
            }
        } else if (_currentType==2) {
            
            if([[Config Instance]isOldUser]){
                [Common alert:@"要先购买基础服务套餐后才能购买增值时长套餐，打好基础很重要哦"];
            } else {
                if([[Config Instance]isPayBase]){
                    [_controler.navigationController pushViewController:rechargeConfirm animated:YES];
                } else {
                    [Common alert:@"请先购买基础套餐"];
                }
            }
        } else if (_currentType==3) {
            if([[Config Instance]isOldUser]){
                [Common alert:@"要先购买基础服务套餐后才能购买增值存储套餐，更多空间更多安心"];
            } else {
                if([[Config Instance]isPayBase]){
                    [_controler.navigationController pushViewController:rechargeConfirm animated:YES];
                } else {
                    [Common alert:@"请先购买基础套餐"];
                }
            }
        }
    } else {
        [Common alert:@"支付功能被关闭无法使用"];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag==1) {
        if(buttonIndex==0) {
            ACRechargeConfirmViewController *rechargeConfirm=[[ACRechargeConfirmViewController alloc] init];
            [rechargeConfirm setCurrentType:_currentType];
            [rechargeConfirm setData:_data];
            [_controler.navigationController pushViewController:rechargeConfirm animated:YES];
        }
    }
}

@end
