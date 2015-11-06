//
//  User.h
//  Car
//
//  Created by Start on 11/4/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

//是否已登陆
@property Boolean isLogin;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *cardId;
@property (copy,nonatomic) NSString *phone;

+ (User *)getInstance;

+ (void)resetConfig;

@end