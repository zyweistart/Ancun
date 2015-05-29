//
//  AES.m
//  Ume
//
//  Created by Start on 5/28/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "AES.h"
#import "NSData+AES256.h"

@implementation AES

+ (NSString *)decrypt:(NSString *)src password:(NSString *)key
{
//    NSData *data = [src dataUsingEncoding:NSUTF8StringEncoding];
//    return [data AES256DecryptWithCiphertext:key];
    return [NSData AES256DecryptWithCiphertext:key];
//    return [[NSString alloc] initWithData:[data AES256EncryptWithKey:key] encoding:NSUTF8StringEncoding];
}

+ (NSString *)encrypt:(NSString *)src password:(NSString *)key
{
    return nil;
}

@end
