//
//  TabBarFrameViewController.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : 0)
#define addHeight 88

@protocol TabBarDelegate <NSObject>

- (void)touchBtnAtIndex:(NSInteger)index;

@end

@class TabBarView;
@interface TabBarFrameViewController : UIViewController<TabBarDelegate>

@property(nonatomic,strong) TabBarView *tabbar;
@property(nonatomic,strong) NSArray *arrayViewcontrollers;

@end

