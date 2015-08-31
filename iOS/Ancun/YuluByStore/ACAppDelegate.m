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
#import "ACGesturePasswordViewController.h"
#import "NSString+Utils.h"
#import "UIWindow+PazLabs.h"

#import "UUString.h"

#ifndef TEST
#import "BaiduMobStat.h"
#import "MobClick.h"
#endif
#ifdef JAILBREAK
    #import <AlipaySDK/AlipaySDK.h>
    #import "ACPaymentViewController.h"
#else
    #import "IAPHelper.h"
#endif

@implementation ACAppDelegate

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    ACAppDelegate *myDelegate = (ACAppDelegate*)[[UIApplication sharedApplication] delegate];
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    //显示系统托盘
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
#ifndef TEST
    
    NSBundle *bundle=[NSBundle mainBundle];
    
    NSString *channel=[bundle objectForInfoDictionaryKey:@"ChannelId"];
    
    NSString *umengAppKey=@"559b412c67e58e03380074d2";
    //有盟
    [MobClick startWithAppkey:umengAppKey reportPolicy:BATCH channelId:channel];
    NSString * deviceName = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString * mac = [UUString macString];
    NSString * idfa = [UUString idfaString];
    NSString * idfv = [UUString idfvString];
    NSString * urlString = [NSString stringWithFormat:@"http://log.umtrack.com/ping/%@/?devicename=%@&mac=%@&idfa=%@&idfv=%@", umengAppKey, deviceName, mac, idfa, idfv];
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:urlString]] delegate:nil];
    
    
    //测试环境下不进行百度统计
    BaiduMobStat* statTracker = [BaiduMobStat defaultStat];
    statTracker.enableExceptionLog = NO; // 是否允许截获并发送崩溃信息，请设置YES或者NO
    
//    设置您的app的发布渠道 [pp25,91,360,baidu,官网]
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
    statTracker.shortAppVersion  = [[bundle infoDictionary] objectForKey:@"CFBundleVersion"];
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
    //获取当前使用的版本号
    NSString *currentVersionNo=[infoDict objectForKey:@"CFBundleVersion"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if([currentVersionNo floatValue]>lastVersionNo){
        //新安装或升级则使用引导页
        self.window.rootViewController=[[ACGuideViewController alloc]init];
    }else{
        NSString *GESTUREPWD=[Common getCache:DEFAULTDATA_GESTUREPWD];
        NSString *PHONE=[Common getCache:DEFAULTDATA_PHONE];
        NSString *PASSWORD=[Common getCache:DEFAULTDATA_PASSWORD];
        BOOL AUTOLOGIN=[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN];
        if([GESTUREPWD isNotEmpty]&&[PHONE isNotEmpty]&&[PASSWORD isNotEmpty]&&AUTOLOGIN){
            self.window.rootViewController=[[ACGesturePasswordViewController alloc]initWithFlag:NO];
        }else{
            self.window.rootViewController=[[ACLoginViewController alloc]init];
        }
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
//    if(!application.enabledRemoteNotificationTypes){
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
//    }
    
    //应用关闭的情况下接收到消息推送
//    NSDictionary *aps = [[launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"] objectForKey:@"aps"];
//    [self notication:aps];
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if([[Config Instance]isLogin]) {
#ifdef JAILBREAK
        //重新返回到应用的时候刷新用户信息
        [[Config Instance] setIsRefreshUserInfo:YES];
#endif
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    if([[Config Instance]isLogin]) {
        NSString *GESTUREPWD=[Common getCache:DEFAULTDATA_GESTUREPWD];
        NSString *PHONE=[Common getCache:DEFAULTDATA_PHONE];
        NSString *PASSWORD=[Common getCache:DEFAULTDATA_PASSWORD];
        BOOL AUTOLOGIN=[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN];
        if([GESTUREPWD isNotEmpty]&&[PHONE isNotEmpty]&&[PASSWORD isNotEmpty]&&AUTOLOGIN){
            UIViewController *currentViewController=[self.window visibleViewController];
            if(currentViewController!=nil&&![[Config Instance] lock]){
                if([[Config Instance] alertView]!=nil){
                    [[[Config Instance] alertView] dismissWithClickedButtonIndex:0 animated:YES];
                }
                if([[Config Instance] actionSheet]!=nil){
                    [[[Config Instance] actionSheet] dismissWithClickedButtonIndex:1 animated:YES];
                }
                [currentViewController presentViewController:[[ACGesturePasswordViewController alloc]initWithFlag:YES] animated:YES completion:nil];
            }
        }
    }
}
#ifdef JAILBREAK
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        NSString *resultStatus=[resultDic objectForKey:@"resultStatus"];
        if([@"9000" isEqualToString:resultStatus]){
            UIViewController *controller=[[Config Instance]mPaymentViewController];
            if(controller) {
                if([controller isKindOfClass:[ACPaymentViewController class]]) {
                    ACPaymentViewController *viewController=(ACPaymentViewController *)controller;
                    [viewController successStep];
                }
            }
        }else{
            NSString *memo=[resultDic objectForKey:@"memo"];
            [Common alert:[NSString stringWithFormat:@"错误编号:%@ %@",resultStatus,memo]];
        }
    }];
    return YES;
}
#endif

@end