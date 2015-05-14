//
//  TabBarView.h
//  Ume
//
//  Created by Start on 5/14/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabBarFrameViewController.h"

@interface TabBarView : UIView

@property(nonatomic,strong) UIImageView *tabbarView;
@property(nonatomic,strong) UIImageView *tabbarViewCenter;

@property(nonatomic,strong) UIButton *button_1;
@property(nonatomic,strong) UIButton *button_2;
@property(nonatomic,strong) UIButton *button_center;
@property(nonatomic,strong) UIButton *button_3;
@property(nonatomic,strong) UIButton *button_4;

@property(nonatomic,weak) id<TabBarDelegate> delegate;

@end
