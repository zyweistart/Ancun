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


#define NotifyActionKey "NotifyAction"
NSString* const NotificationCategoryIdent  = @"ACTIONABLE";
NSString* const NotificationActionOneIdent = @"ACTION_ONE";
NSString* const NotificationActionTwoIdent = @"ACTION_TWO";

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
    // 是否允许截获并发送崩溃信息，请设置YES或者NO
    statTracker.enableExceptionLog = NO;
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
    
    // [1]:使用APPID/APPKEY/APPSECRENT创建个推实例
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
    // [2]:注册APNS
    [self registerRemoteNotification];
    // [2-EXT]: 获取启动时收到的APN数据
    NSDictionary*message=[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
//        NSString*payloadMsg = [message objectForKey:@"payload"];
//        NSString*record = [NSString stringWithFormat:@"[APN]%@,%@",[NSDate date],payloadMsg];
//        NSLog(@"================%@",message);
//        [Common alert:@"打开消息了"];
    }
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // [EXT] 重新上线
    [self startSdkWith:kAppId appKey:kAppKey appSecret:kAppSecret];
    if([[Config Instance]isLogin]) {
#ifdef JAILBREAK
        //重新返回到应用的时候刷新用户信息
        [[Config Instance] setIsRefreshUserInfo:YES];
#endif
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // [EXT] APP进入后台时，通知个推SDK进入后台
    [GeTuiSdk enterBackground];
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

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
    NSString *token = [[deviceToken description]
                       stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    self.deviceToken = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
//    [3]:向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:self.deviceToken];
}

-(void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
//    [3-EXT]:如果APNS注册失败，通知个推服务器
    [GeTuiSdk registerDeviceToken:@""];
}

-(void)GeTuiSdkDidReceivePayload:(NSString*)payloadId andTaskId:(NSString*)taskId andMessageId:(NSString *)aMsgId fromApplication:(NSString *)appId
{
//    [4]: 收到个推消息
    NSData *payload = [GeTuiSdk retrivePayloadById:payloadId]; //根据payloadId取回Payload
    NSString *payloadMsg = nil;
    if (payload) {
        payloadMsg = [[NSString alloc] initWithBytes:payload.bytes
                                              length:payload.length
                                            encoding:NSUTF8StringEncoding];
        [self insertMessage:payloadMsg];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userinfo {
//    [4-EXT]:处理APN
    NSString *payloadMsg = [userinfo objectForKey:@"payload"];
    if (payloadMsg) {
//        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
    }
    NSLog(@"===========%@",userinfo);
}

- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId  // SDK 返回clientid
{
//    [4-EXT-1]: 个推SDK已注册，返回clientId
    if (self.deviceToken) {
        [GeTuiSdk registerDeviceToken:self.deviceToken];
    }
}

- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result
{
//    [4-EXT]:发送上行消息结果反馈
    NSString *record = [NSString stringWithFormat:@"Received sendmessage:%@ result:%d", messageId, result];
    NSLog(@"%@",record);
}

- (void)GeTuiSdkDidOccurError:(NSError *)error
{
//    [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    NSLog(@">>>[GexinSdk error]:%@",[error localizedDescription]);
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
//    恢复个推SDK运行
    [GeTuiSdk resume];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)startSdkWith:(NSString *)appID appKey:(NSString*)appKey appSecret:(NSString *)appSecret
{
    NSError *err =nil;
    //[1-1]:通过 AppId、appKey 、appSecret 启动SDK
    [GeTuiSdk startSdkWithAppId:appID appKey:appKey appSecret:appSecret delegate:self error:&err];
    //[1-2]:设置是否后台运行开关
    [GeTuiSdk runBackgroundEnable:YES];
    //[1-3]:设置地理围栏功能，开启LBS定位服务和是否允许SDK 弹出用户定位请求，请求NSLocationAlwaysUsageDescription权限,如果UserVerify设置为NO，需第三方负责提示用户定位授权。
    [GeTuiSdk lbsLocationEnable:YES andUserVerify:YES];
    if (err) {
        NSLog(@"%@",[err localizedDescription]);
    }
}

- (void)registerRemoteNotification
{
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        //IOS8 新的通知机制category注册
        UIMutableUserNotificationAction *action1;
        action1 = [[UIMutableUserNotificationAction alloc] init];
        [action1 setActivationMode:UIUserNotificationActivationModeBackground];
        [action1 setTitle:@"取消"];
        [action1 setIdentifier:NotificationActionOneIdent];
        [action1 setDestructive:NO];
        [action1 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationAction *action2;
        action2 = [[UIMutableUserNotificationAction alloc] init];
        [action2 setActivationMode:UIUserNotificationActivationModeBackground];
        [action2 setTitle:@"回复"];
        [action2 setIdentifier:NotificationActionTwoIdent];
        [action2 setDestructive:NO];
        [action2 setAuthenticationRequired:NO];
        
        UIMutableUserNotificationCategory *actionCategory;
        actionCategory = [[UIMutableUserNotificationCategory alloc] init];
        [actionCategory setIdentifier:NotificationCategoryIdent];
        [actionCategory setActions:@[action1, action2]
                        forContext:UIUserNotificationActionContextDefault];
        
        NSSet *categories = [NSSet setWithObject:actionCategory];
        UIUserNotificationType types = (UIUserNotificationTypeAlert|
                                        UIUserNotificationTypeSound|
                                        UIUserNotificationTypeBadge);
        
        UIUserNotificationSettings *settings;
        settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                       UIRemoteNotificationTypeSound|
                                                                       UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|
                                                                   UIRemoteNotificationTypeSound|
                                                                   UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
#endif
}

static void uncaughtExceptionHandler(NSException *exception) {
    NSLog(@"CRASH: %@", exception);
    NSLog(@"Stack Trace: %@", [exception callStackSymbols]);
}

- (void)insertMessage:(NSString*)message
{
    if(message==nil||[@"" isEqualToString:message]){
        return;
    }
    NSArray *list=[message componentsSeparatedByString:@"|"];
    if([list count]!=6){
        return;
    }
    SQLiteOperate *so=[[SQLiteOperate alloc]init];
    if([so openDB]){
        if([so createTableMessageNotification]){
            Message *message=[[Message alloc]init];
            [message setTitle:[NSString stringWithFormat:@"%@",[list objectAtIndex:0]]];
            [message setContent:[NSString stringWithFormat:@"%@",[list objectAtIndex:1]]];
            [message setOper:[NSString stringWithFormat:@"%@",[list objectAtIndex:2]]];
            [message setUrl:[NSString stringWithFormat:@"%@",[list objectAtIndex:3]]];
            [message setType:[NSString stringWithFormat:@"%@",[list objectAtIndex:4]]];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
            [message setDate:currentDateStr];
            [message setRead:@"0"];
            [so insertMessageNotification:message];
            NSInteger count=[so getNoReadMessageNotificationCount];
            //未读消息提示数
            if(count>0){
                [[self.mTabBarController.tabBar.items objectAtIndex:4] setBadgeValue:[NSString stringWithFormat:@"%ld",count]];
            }else{
                [[self.mTabBarController.tabBar.items objectAtIndex:4] setBadgeValue:nil];
            }
        }
    }
}

@end