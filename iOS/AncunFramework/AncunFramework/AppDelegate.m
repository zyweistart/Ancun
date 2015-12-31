//
//  AppDelegate.m
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Utils.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self p_adaptorForScreen];
    return YES;
}

@end