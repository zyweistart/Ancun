//
//  AppDelegate.m
//  Ume
//
//  Created by Start on 5/13/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarFrameViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //计算各屏幕XY大小
    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(ScreenHeight > 480){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    //状态栏
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
//    [application setStatusBarStyle:UIStatusBarStyleLightContent];
//    [application setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//    [[UINavigationBar appearance] setBarTintColor:NAVBG];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackTranslucent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    UINavigationController *tabBarFrameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:[[TabBarFrameViewController alloc]init]];
//    [[tabBarFrameViewControllerNav navigationBar]setBarTintColor:NAVBG];
//    [[tabBarFrameViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
//    [tabBarFrameViewControllerNav setDelegate:self];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.window.rootViewController=[[TabBarFrameViewController alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end