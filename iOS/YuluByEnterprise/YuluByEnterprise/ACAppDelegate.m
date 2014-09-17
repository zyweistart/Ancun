//
//  ACAppDelegate.m
//  ACyulu
//
//  Created by Start on 12-12-5.
//  Copyright (c) 2012年 ancun. All rights reserved.
//

#import "ACAppDelegate.h"
#import "ACGuideViewController.h"
#import "ACLoginViewController.h"
#import "ACRechargeConfirmViewController.h"
#import "ACRechargeNav.h"
#ifndef TEST
#import "BaiduMobStat.h"
#endif
#ifdef JAILBREAK
    #import "AlixPay.h"
    #import "AlixPayResult.h"
#else
    #import "IAPHelper.h"
#endif

@implementation ACAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //显示系统托盘
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
#ifndef TEST
    NSBundle *bundle=[NSBundle mainBundle];
    //测试环境下不进行百度统计
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = NO; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    
    //设置您的app的发布渠道 [pp25,91,360,baidu,官网]
//    statTracker.channelId = @"pp25";
//    statTracker.channelId = @"91";
//    statTracker.channelId = @"360";
//    statTracker.channelId = @"baidu";
//    statTracker.channelId = @"ancun";
    statTracker.channelId = [bundle objectForInfoDictionaryKey:@"ChannelId"];

    //根据开发者设定的时间间隔接口发送 也可以使用启动时发送策略
    statTracker.logStrategy = BaiduMobStatLogStrategyCustom;
    //为1时表示发送日志的时间间隔为1小时
    statTracker.logSendInterval = 1;
    //是否仅在WIfi情况下发送日志数据
    statTracker.logSendWifiOnly = YES; 
    //设置应用进入后台再回到前台为同一次session的间隔时间[0~600s],超过600s则设为600s，默认为30s
    statTracker.sessionResumeInterval = 60;
    //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    statTracker.shortAppVersion  = [[bundle infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    //设置您在mtj网站上添加的app的appkey
    [statTracker startWithAppId:[bundle objectForInfoDictionaryKey:@"BaiduWithAppId"]];
#endif
    
#ifndef JAILBREAK
    if([SKPaymentQueue canMakePayments]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:[IAPHelper sharedHelper]];
    }
#endif
    
    //获取最后保存的版本号不存在则为0
    float lastVersionNo=[[Common getCache:DEFAULTDATA_LASTVERSIONNO] floatValue];
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    //获取当前使用的版本号Version
    NSString *currentVersionNo=[infoDict objectForKey:@"CFBundleShortVersionString"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if([currentVersionNo floatValue]>lastVersionNo){
        //新安装或升级则使用引导页
        self.window.rootViewController=[[ACGuideViewController alloc]init];
    }else{
        //直接进入登录页
        self.window.rootViewController=[[ACLoginViewController alloc]init];
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if([[Config Instance]isLogin]) {
        //重新返回到应用的时候刷新用户信息
        [[Config Instance] setIsRefreshUserInfo:YES];
    }
}

#ifdef JAILBREAK
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    AlixPay *alixpay = [AlixPay shared];
	AlixPayResult *result = [alixpay handleOpenURL:url];
	if (result) {
		//9000表示已经支付成功
		if (9000 == result.statusCode) {
            //服务端签名验证可开启以下代码
//            NSMutableString *verifyString=[[NSMutableString alloc]init];
//            [verifyString appendFormat:@"resultStatus={%d};",result.statusCode];
//            [verifyString appendFormat:@"memo={%@};",result.statusMessage];
//            [verifyString appendString:@"result={"];
//            [verifyString appendString:result.resultString];
//            [verifyString appendString:@"&"];
//            [verifyString appendFormat:@"sign_type=\"%@\"",result.signType];
//            [verifyString appendString:@"&"];
//            [verifyString appendFormat:@"sign=\"%@\"",result.signString];
//            [verifyString appendString:@"}"];
//            NSLog(@"%@",verifyString);
//            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
//            [requestParams setObject:ACCESSID forKey:@"accessid"];
//            [requestParams setObject:@"3"  forKey:@"payproduct"];
//            [requestParams setObject:verifyString  forKey:@"rescontent"];
//            _loadHttp=[[HttpRequest alloc]init];
//            [_loadHttp setDelegate:self];
//            [_loadHttp setController:[application.keyWindow rootViewController]];
//            [_loadHttp handle:@"v4ealipayRes" signKey:ACCESSKEY headParams:nil requestParams:requestParams];
            //显示成功页面
            UIViewController *controller=[[Config Instance]currentViewController];
            if(controller) {
                if([controller isKindOfClass:[ACRechargeConfirmViewController class]]) {
                    ACRechargeConfirmViewController *viewController=(ACRechargeConfirmViewController *)controller;
                    [viewController layoutSuccessPage];
                }
            }
		} else {
            //充值失败
            if(result.statusCode==6001) {
                //用户中途取消
            }
            //使引导箭头标为第二步
            UIViewController *controller=[[Config Instance]currentViewController];
            if(controller) {
                if([controller isKindOfClass:[ACRechargeConfirmViewController class]]) {
                    ACRechargeConfirmViewController *viewController=(ACRechargeConfirmViewController *)controller;
                    [viewController.rechargeNav secondStep];
                }
            }
            [Common alert:result.statusMessage];
		}
	}
    
	return YES;
}
#endif

@end
