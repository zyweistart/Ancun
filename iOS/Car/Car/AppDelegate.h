//
//  AppDelegate.h
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
//引入base相关所有的头文件
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) BMKMapManager *mapManager;
@property (strong, nonatomic) UIWindow *window;

@property (assign,nonatomic) CGFloat autoSizeScaleX;
@property (assign,nonatomic) CGFloat autoSizeScaleY;

- (void)windowRootViewController;

@end