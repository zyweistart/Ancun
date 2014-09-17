//
//  ACPaymentViewController.m
//  Ancun
//
//  Created by Start on 4/4/14.
//
//

#import "ACPaymentViewController.h"
#import "ACRechargeNav.h"
#import "MBProgressHUD.h"
#import <QuartzCore/QuartzCore.h>
#ifdef JAILBREAK
#import "AlixPay.h"
#else
#import "IAPHelper.h"
#endif

#define ALERTVIEWALIPAYTAG 123
#define ALIPAYREQUESTCODE 10000000
#define LBLTEXTCOLOR [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]
#define LBLVALUETEXTCOLOR [UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]

@interface ACPaymentViewController ()

@end

@implementation ACPaymentViewController{
    
    ACRechargeNav *_rechargeNav;
    UIView *paymentMainView;
    UIView *paymentSuccessView;
    
    NSDictionary *_data;
    
#ifndef JAILBREAK
    NSString *_orderRecordno;
    MBProgressHUD *_hud;
#endif
    
}

- (id)initWithData:(NSDictionary *)data;
{
    _data=data;
    self = [super init];
    if (self) {
        
        self.title=@"支付";
        
        [self.view setBackgroundColor:[UIColor colorWithRed:(207/255.0) green:(212/255.0) blue:(221/255.0) alpha:1]];
        
#ifndef JAILBREAK
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:kProductPurchasedNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(productPurchaseFailed:) name:kProductPurchaseFailedNotification object: nil];
#endif
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *container=nil;
    if(IOS7){
        container=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-STATUSHEIGHT-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
    }else{
        container=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
    }
    [self.view addSubview:container];
    
    _rechargeNav=[[ACRechargeNav alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    [container addSubview:_rechargeNav];
    
    paymentMainView=[[UIView alloc]initWithFrame:CGRectMake(10, 60, 300, 285)];
    paymentMainView.layer.cornerRadius=10;
    paymentMainView.layer.masksToBounds=YES;
    [paymentMainView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 40, 70, 30)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [lbl setTextColor:LBLTEXTCOLOR];
    [lbl setText:@"套餐名称:"];
    [paymentMainView addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(115, 40, 150, 30)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextColor:LBLVALUETEXTCOLOR];
    [lbl setText:[_data objectForKey:@"name"]];
    [paymentMainView addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 70, 70, 30)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [lbl setTextColor:LBLTEXTCOLOR];
    [lbl setText:@"支付金额:"];
    [paymentMainView addSubview:lbl];
    //支付金额
    UILabel *lblMoney=[[UILabel alloc]initWithFrame:CGRectMake(115, 70, 70, 30)];
    [lblMoney setFont:[UIFont fontWithName:@"Helvetica-Bold" size:15]];
    [lblMoney setTextColor:LBLVALUETEXTCOLOR];
    [lblMoney setText:[NSString stringWithFormat:@"%@元",[_data objectForKey:@"newprice"]]];
    [paymentMainView addSubview:lblMoney];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 100, 70, 30)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [lbl setTextColor:LBLTEXTCOLOR];
    [lbl setText:@"生效日期:"];
    [paymentMainView addSubview:lbl];
    
    UILabel *lblStartDay=[[UILabel alloc]initWithFrame:CGRectMake(115, 100, 150, 30)];
    [lblStartDay setFont:[UIFont systemFontOfSize:15]];
    [lblStartDay setTextColor:LBLVALUETEXTCOLOR];
    [paymentMainView addSubview:lblStartDay];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 130, 70, 30)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [lbl setTextColor:LBLTEXTCOLOR];
    [lbl setText:@"到期日期:"];
    [paymentMainView addSubview:lbl];
    
    UILabel *lblEndDay=[[UILabel alloc]initWithFrame:CGRectMake(115, 130, 150, 30)];
    [lblEndDay setFont:[UIFont systemFontOfSize:15]];
    [lblEndDay setTextColor:LBLVALUETEXTCOLOR];
    [paymentMainView addSubview:lblEndDay];
    
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeInterval secondsPerDay=24*60*60*[[_data objectForKey:@"valid"]intValue];
    
    NSDate *date=[[NSDate alloc]init];
    NSDate *tomorrow=[NSDate dateWithTimeIntervalSinceNow:secondsPerDay];
    [lblStartDay setText:[formatter stringFromDate:date]];
    [lblEndDay setText:[formatter stringFromDate:tomorrow]];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 160, 70, 30)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextAlignment:NSTextAlignmentRight];
    [lbl setTextColor:LBLTEXTCOLOR];
    [lbl setText:@"充值账户:"];
    [paymentMainView addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(115, 160, 150, 30)];
    [lbl setFont:[UIFont systemFontOfSize:15]];
    [lbl setTextColor:LBLVALUETEXTCOLOR];
    [lbl setText:[[[Config Instance]userInfo]objectForKey:@"phone"]];
    [paymentMainView addSubview:lbl];
    
    UIButton *btnConfirm=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnConfirm setFrame:CGRectMake(25, 210, 250, 35)];
    [btnConfirm setTitle:@"确认充值" forState:UIControlStateNormal];
    btnConfirm.layer.cornerRadius=5;
    btnConfirm.layer.masksToBounds=YES;
    [btnConfirm setBackgroundColor:[UIColor colorWithRed:(131/255.0) green:(186/255.0) blue:(248/255.0) alpha:1]];
    [btnConfirm addTarget:self action:@selector(confirmPayment:) forControlEvents:UIControlEventTouchDown];
    [paymentMainView addSubview:btnConfirm];
    [container addSubview:paymentMainView];
    
    paymentSuccessView=[[UIView alloc]initWithFrame:CGRectMake(10, 50, 300, 195)];
    paymentSuccessView.layer.cornerRadius=10;
    paymentSuccessView.layer.masksToBounds=YES;
    [paymentSuccessView setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reg_for_done"]];
    [image setFrame:CGRectMake(30, 30, 30, 30)];
    [paymentSuccessView addSubview:image];
    
    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(65, 35, 80, 20)];
    [lbl1 setFont:[UIFont systemFontOfSize:18]];
    [lbl1 setTextAlignment:NSTextAlignmentLeft];
    [lbl1 setText:@"充值成功"];
    [paymentSuccessView addSubview:lbl1];
    
    lbl1=[[UILabel alloc]initWithFrame:CGRectMake(30, 70, 240, 40)];
    [lbl1 setFont:[UIFont systemFontOfSize:16]];
    [lbl1 setTextAlignment:NSTextAlignmentLeft];
    [lbl1 setLineBreakMode:NSLineBreakByCharWrapping];
    [lbl1 setNumberOfLines:0];
    [lbl1 setText:[NSString stringWithFormat:@"您已经为账户(%@)\n购买：%@",[[[Config Instance]userInfo]objectForKey:@"phone"],[_data objectForKey:@"name"]]];
    [paymentSuccessView addSubview:lbl1];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(25, 130, 250, 35)];
    [btn setTitle:@"返回我的账户" forState:UIControlStateNormal];
    btn.layer.cornerRadius=5;
    btn.layer.masksToBounds=YES;
    [btn setBackgroundColor:[UIColor colorWithRed:(131/255.0) green:(186/255.0) blue:(248/255.0) alpha:1]];
    [btn addTarget:self action:@selector(backMyAccount:) forControlEvents:UIControlEventTouchDown];
    [paymentSuccessView addSubview:btn];
    
    [container addSubview:paymentSuccessView];
    
    [self paynmentedStep];
    
}

- (void)paynmentedStep
{
    [_rechargeNav secondStep];
    [paymentMainView setHidden:NO];
    [paymentSuccessView setHidden:YES];
}

- (void)paynmentingStep
{
    [_rechargeNav secondStep];
    [paymentMainView setHidden:NO];
    [paymentSuccessView setHidden:YES];
}

- (void)successStep
{
    [[Config Instance]setIsRefreshUserInfo:YES];
    [[Config Instance]setIsRefreshAccountPayList:YES];
    [_rechargeNav fourthStep];
    [paymentMainView setHidden:YES];
    [paymentSuccessView setHidden:NO];
}

//确认支付
- (void)confirmPayment:(id)sender
{
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setObject:@"4" forKey:@"payuse"];
    [requestParams setObject:[_data objectForKey:@"recordno"] forKey:@"recprod"];
    [requestParams setObject:@"1" forKey:@"actflag"];
    [requestParams setObject:@"1" forKey:@"quantity"];
#ifdef JAILBREAK
    //支付宝支付
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest setRequestCode:ALIPAYREQUESTCODE];
    [self.hRequest loginhandle:@"v4alipayReq" requestParams:requestParams];
#else
    //苹果官方支付
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest setRequestCode:REQUESTCODE_BUY_BUILD];
    [self.hRequest loginhandle:@"v4phoneapppayReq" requestParams:requestParams];
#endif
    [self paynmentingStep];
}

//返回我的账户
- (void)backMyAccount:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode {
#ifdef JAILBREAK
    //支付宝
    if(reqCode==ALIPAYREQUESTCODE) {
        if([response successFlag]) {
            [[Config Instance]setCurrentViewController:self];
            
            NSString *orderString=[[[response mainData] objectForKey:@"alipayinfo"] objectForKey:@"reqcontent"];
            
            orderString=[orderString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            
            AlixPay * alixpay = [AlixPay shared];
            int ret = [alixpay pay:orderString applicationScheme:@"ANCUNYULU"];
            
            if (ret == kSPErrorAlipayClientNotInstalled) {
                [Common actionSheet:self message:@"您还没有安装支付宝快捷支付，请先安装。" tag:ALERTVIEWALIPAYTAG];
            }
        }
    }
#else
    //苹果官方支付
    if(reqCode==REQUESTCODE_BUY_BUILD) {
        if([response successFlag]) {
            _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//            [self performSelector:@selector(timeout:) withObject:nil afterDelay:120.0];
            
            _orderRecordno=[[[response mainData] objectForKey:@"payinfo"] objectForKey:@"recordno"];
            SKProduct *product = [[IAPHelper sharedHelper]product:[_data objectForKey:@"appstorerecordno"]];
            [[IAPHelper sharedHelper] buyProductIdentifier:product];
        }else{
            [self paynmentedStep];
        }
    } else if(reqCode==REQUESTCODE_BUY_VERIFYING) {
        if([response successFlag]) {
            //充值成功
            [self successStep];
        } else {
            [self paynmentedStep];
        }
    }
#endif
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
#ifdef JAILBREAK
    //安装支付宝快捷支付插件
    if (actionSheet.tag == ALERTVIEWALIPAYTAG) {
        if(buttonIndex==0) {
            //跳转到App Store下载支付宝插件
            NSString * URLString = @"http://itunes.apple.com/cn/app/id535715926?mt=8";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
        } else if(buttonIndex==1) {
            [self paynmentedStep];
        }
    }
#endif
}

#ifndef JAILBREAK
//购买产品
- (void)productPurchased:(NSNotification *)notification {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    SKPaymentTransaction * transaction = (SKPaymentTransaction *) notification.object;
    
    [self dismissHUD:nil];
    
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setObject:ACCESSID forKey:@"accessid"];
    [requestParams setObject:_orderRecordno forKey:@"recordno"];
//    [requestParams setObject:[Crypto base64Encode:transaction.transactionReceipt] forKey:@"receiptdata"];
    [requestParams setObject:[[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding] forKey:@"receiptdata"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest setRequestCode:REQUESTCODE_BUY_VERIFYING];
    [self.hRequest handle:@"v4ephoneapppayCon" signKey:ACCESSKEY headParams:nil requestParams:requestParams];
}

//购买失败
- (void)productPurchaseFailed:(NSNotification *)notification {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self paynmentedStep];
    SKPaymentTransaction * transaction = (SKPaymentTransaction *)notification.object;
    if (transaction.error.code != SKErrorPaymentCancelled) {
        [Common alert:transaction.error.localizedDescription];
    }
    [self dismissHUD:nil];
}

//超时提示
- (void)timeout:(id)arg {
    if(_hud!=nil) {
        _hud.labelText = @"请求超时，请稍候在试.";
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
        _hud.mode = MBProgressHUDModeCustomView;
        [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    }
}

- (void)dismissHUD:(id)arg{
    if(_hud!=nil) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        _hud = nil;
    }
}

#endif

@end
