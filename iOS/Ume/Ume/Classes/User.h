//
//  User.h
//  DLS
//
//  Created by Start on 3/13/15.
//  Copyright (c) 2015 Start. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ACCOUNTUSERNAME @"ACCOUNTUSERNAME"
#define ACCOUNTPASSWORD @"ACCOUNTPASSWORD"
#define ISACCOUNTAUTOLOGIN @"ISACCOUNTLOGIN"

@interface User : NSObject

+ (User *) Instance;

- (void)LoginSuccessWithUserName:(NSString*)u Password:(NSString*)p Data:(NSDictionary*) d;

@property (strong,nonatomic) NSString *uid;
@property (strong,nonatomic) NSString *enKey;
@property (strong,nonatomic) NSString *sessionid;
@property (strong,nonatomic) NSDictionary *resultData;

- (NSString*)getUserName;
- (NSString*)getPassword;
- (BOOL)isAutoLogin;

- (BOOL)isLogin;
- (void)clear;

@end
