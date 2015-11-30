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
@property (copy,nonatomic) NSString *uid;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *phone;
@property (copy,nonatomic) NSString *headPic;
@property (copy,nonatomic) NSString *identityNum;
@property (copy,nonatomic) NSString *driverLicense;


@property (assign,nonatomic) BOOL configMessageNotice;
@property (assign,nonatomic) BOOL configMessageDynamic;
@property (assign,nonatomic) BOOL configUploadFile2G3GAuto;
@property (assign,nonatomic) BOOL configUploadFileWiFiAuto;

+ (User *)getInstance;

+ (void)resetConfig;

- (BOOL)isLogin;

- (BOOL)isAuthentication;

@end