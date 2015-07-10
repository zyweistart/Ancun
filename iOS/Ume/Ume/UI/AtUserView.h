//
//  AtUserView.h
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AtUserView : UIView

@property (strong,nonatomic) UIViewController *currentController;
@property (strong,nonatomic) UIButton *mAddatUser;


- (void)setAtUserLayout:(NSArray*)datas;

@end
