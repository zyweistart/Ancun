//
//  AppDelegate.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Utils.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self p_adaptorForScreen];
    
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance]setBarTintColor:BGCOLOR];
    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackTranslucent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UINavigationController *mMainViewController=[[UINavigationController alloc]initWithRootViewController:[[MainViewController alloc]init]];
    self.window.rootViewController=mMainViewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end