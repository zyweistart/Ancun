//
//  ACAppDelegate.h
//  ACyulu
//
//  Created by Start on 12-12-5.
//  Copyright (c) 2012年 ancun. All rights reserved.
//


#import "GeTuiSdk.h"

@interface ACAppDelegate : UIResponder <UIApplicationDelegate,GeTuiSdkDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (assign,nonatomic)float autoSizeScaleX;
@property (assign,nonatomic)float autoSizeScaleY;
@property (strong,nonatomic)NSString *deviceToken;

@end
