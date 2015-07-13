//
//  CLabelClose.h
//  Ume
//
//  Created by Start on 15/7/13.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "CLabel.h"

@interface CLabelClose : CLabel

- (id)initWithFrame:(CGRect)rect Text:(NSString*)text;

@property (strong,nonatomic)CLabel *lblText;
@property (strong,nonatomic)UIButton *bClose;

@end
