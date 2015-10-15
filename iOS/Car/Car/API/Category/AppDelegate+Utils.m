//
//  AppDelegate+Utils.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "AppDelegate+Utils.h"

@implementation AppDelegate(Utils)

//计算自动约束比例
- (void)p_adaptorForScreen
{
//    AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if(inch35){
        self.autoSizeScaleX = 1.0;
        self.autoSizeScaleY = 1.0;
    }else{
        self.autoSizeScaleX = ScreenWidth/320;
        self.autoSizeScaleY = ScreenHeight/568;
    }
}

@end
