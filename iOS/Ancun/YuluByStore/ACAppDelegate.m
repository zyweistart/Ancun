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

//for mac
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

//for idfa
#import <AdSupport/AdSupport.h>

#ifndef TEST
#import "BaiduMobStat.h"
#import "MobClick.h"
#endif
#ifdef JAILBREAK
    #import "AlixPay.h"
    #import "AlixPayResult.h"
    #import "ACPaymentViewController.h"
#else
    #import "IAPHelper.h"
#endif
#import "UUString.h"

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
    NSString * mac = [self macString];
    NSString * idfa = [self idfaString];
    NSString * idfv = [self idfvString];
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
    
    NSLog(@"%@",[UUString getIDFA]);
    NSLog(@"%@",[UUString macaddressOfJOJOWang]);
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
#ifdef JAILBREAK
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
                if([controller isKindOfClass:[ACPaymentViewController class]]) {
                    ACPaymentViewController *viewController=(ACPaymentViewController *)controller;
                    [viewController successStep];
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
                if([controller isKindOfClass:[ACPaymentViewController class]]) {
                    ACPaymentViewController *viewController=(ACPaymentViewController *)controller;
                    [viewController paynmentedStep];
                }
            }
            [Common alert:result.statusMessage];
		}
	}
#endif
    return YES;
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    //应用在后台或前台开启的状态下接收到消息推送
//    [self notication:[userInfo objectForKey:@"aps"]];
//}
//
//- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    //如果注册的时候失败，ios会调用这个方法
//    NSLog(@"Error:%@", error);
//}
//
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//    //获取deviceToken需上传至服务端
//    NSString *dt=[[deviceToken description] stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if([dt length]>2){
//        NSString *token=[dt substringWithRange:NSMakeRange(1,[dt length]-2)];
//        [Common setCache:DEFAULTDATA_DEVICETOKEN data:token];
//    }
//}
//
//- (void)notication:(NSDictionary*)aps
//{
//    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//    if(aps!=nil){
////        NSString *type=[aps objectForKey:@"type"];
//        UIAlertView *alert = [[UIAlertView alloc]
//                              initWithTitle:@"消息"
//                              message:[aps objectForKey:@"alert"]
//                              delegate:nil
//                              cancelButtonTitle:@"确定"
//                              otherButtonTitles:nil, nil];
//        [alert show];
//    }
//}




- (NSString * )macString{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *macString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return macString;
}

- (NSString *)idfaString {
    
    NSBundle *adSupportBundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/AdSupport.framework"];
    [adSupportBundle load];
    
    if (adSupportBundle == nil) {
        return @"";
    }
    else{
        
        Class asIdentifierMClass = NSClassFromString(@"ASIdentifierManager");
        
        if(asIdentifierMClass == nil){
            return @"";
        }
        else{
            
            //for no arc
            //ASIdentifierManager *asIM = [[[asIdentifierMClass alloc] init] autorelease];
            //for arc
            ASIdentifierManager *asIM = [[asIdentifierMClass alloc] init];
            
            if (asIM == nil) {
                return @"";
            }
            else{
                
                if(asIM.advertisingTrackingEnabled){
                    return [asIM.advertisingIdentifier UUIDString];
                }
                else{
                    return [asIM.advertisingIdentifier UUIDString];
                }
            }
        }
    }
}

- (NSString *)idfvString
{
    if([[UIDevice currentDevice] respondsToSelector:@selector( identifierForVendor)]) {
        return [[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    
    return @"";
}

@end
