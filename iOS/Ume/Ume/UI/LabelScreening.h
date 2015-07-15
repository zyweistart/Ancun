//
//  LabelScreening.h
//  Ume
//
//  Created by Start on 15/7/15.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelScreening : UIView

@property (strong,nonatomic)CLabel *lblTitle;
@property (strong,nonatomic)UIImageView *ivTag;

- (void)setSelected:(BOOL)selected;

@end
