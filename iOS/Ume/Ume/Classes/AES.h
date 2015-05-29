//
//  AES.h
//  Ume
//
//  Created by Start on 5/28/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES : NSObject
+ (NSString *)decrypt:(NSString *)src password:(NSString *)key;

+ (NSString *)encrypt:(NSString *)src password:(NSString *)key;
@end
