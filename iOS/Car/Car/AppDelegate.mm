//
//  AppDelegate.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Utils.h"
//引入地图功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "MainViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //百度地图启动
    self.mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [self.mapManager start:@"GurxAzSaX1zrj8gVKo2jq6V5"  generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    [self p_adaptorForScreen];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:BGCOLOR];
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackTranslucent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self windowRootViewController];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [BMKMapView willBackGround];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [BMKMapView didForeGround];
}

- (void)windowRootViewController
{
    if([[User getInstance]isLogin]){
        UINavigationController *mMainViewController=[[UINavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]];
        self.window.rootViewController=mMainViewController;
    }else{
        UINavigationController *mLoginViewController=[[UINavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
        self.window.rootViewController=mLoginViewController;
    }
    [self.window makeKeyAndVisible];
}

- (void)onGetNetworkState:(int)iError
{
    if (0 != iError) {
        NSLog(@"onGetNetworkState %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError
{
    if (0 != iError) {
        NSLog(@"onGetPermissionState %d",iError);
    }
}

@end