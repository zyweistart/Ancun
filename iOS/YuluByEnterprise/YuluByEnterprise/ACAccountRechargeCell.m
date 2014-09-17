#import "ACAccountRechargeCell.h"
#import "ACRechargeConfirmViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ACAccountRechargeCell

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
