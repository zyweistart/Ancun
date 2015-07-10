//
//  ContactViewController.h
//  Ume
//
//  Created by Start on 15/7/9.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "BaseViewController.h"

@protocol ContactDelegate

@optional
- (void)atContactFinisih:(NSArray*)friendsArray;

@end

@interface ContactViewController : BaseViewController

@property (strong,nonatomic) NSArray *selectedUser;
@property (strong,nonatomic) NSObject<ContactDelegate> *delegate;

@end
