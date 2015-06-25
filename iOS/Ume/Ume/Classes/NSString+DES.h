//
//  DESUtils.h
//  Ume
//
//  Created by Start on 15/6/25.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>
#define DESKEY @"cugo1126"

@interface NSString(Utils)

//加密
- (NSString *) encryptUseDES;
//解密
- (NSString *) decryptUseDES;

@end
