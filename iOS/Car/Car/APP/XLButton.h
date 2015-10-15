//
//  XLButton.h
//  XinHu
//
//  Created by Start on 15/8/11.
//  Copyright (c) 2015年 AnCun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTON1NORMALCOLOR DEFAULTITLECOLORRGB(242, 125, 0)
#define BUTTON1PRESENDCOLOR DEFAULTITLECOLORRGB(238, 166, 89)

@interface XLButton : UIButton

- (id)initWithFrame:(CGRect)rect Name:(NSString*)name;
- (id)initWithFrame:(CGRect)rect Name:(NSString*)name Type:(NSInteger)type;

- (void)setType:(NSInteger)type;

@property (nonatomic) NSInteger tag2;

@end
