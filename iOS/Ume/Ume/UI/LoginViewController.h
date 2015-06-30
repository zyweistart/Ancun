//
//  LoginViewController.h
//  Ume
//
//  Created by Start on 5/13/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "BaseViewController.h"
@protocol LoginDelegate <NSURLConnectionDataDelegate>

@optional
- (void)handleLogin:(NSDictionary*)data;

@end

@interface LoginViewController : BaseViewController<UITextFieldDelegate>

@property (strong,nonatomic) NSObject<LoginDelegate> *delegate;

@end
