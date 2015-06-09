//
//  UYourDetailViewController.h
//  Ume
//
//  Created by Start on 15/6/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@interface UYourDetailViewController : BaseViewController

@property (strong,nonatomic)NSDictionary *data;

- (id)initWithData:(NSDictionary*)data;

@end
