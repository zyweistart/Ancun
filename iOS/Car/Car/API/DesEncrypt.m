//
//  DesEncrypt.m
//  Car
//
//  Created by Start on 11/12/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#define DESKEY @"cugo1126"
#define DATALENGTH 1024

#import "DesEncrypt.h"
#import "DES.h"

@implementation DesEncrypt

+ (NSString*)encryptEBCWithText:(NSString*)data
{
    Byte srcBytes[DATALENGTH];
    for(int i=0;i<[data length];i++){
        Byte b=[data characterAtIndex:i];
        srcBytes[i]=b;
    }
    for(long i=[data length];i<=DATALENGTH-[data length];i++){
        srcBytes[i]=0;
    }
    Byte *encryptBytes = [DES encryptDES:srcBytes key:DESKEY useEBCmode:YES];
    NSMutableString *hexString=[[NSMutableString alloc]init];
    for(int i = 0 ;i < strlen((const char *)encryptBytes);i++) {
        NSString *hex = [NSString stringWithFormat:@"%@",[[NSString alloc] initWithFormat:@"%1x",encryptBytes[i]]];
        [hexString appendString:[hex uppercaseString]];
    }
    free(encryptBytes);
    return hexString;
}

+ (NSString*)decryptEBCWithText:(NSString*)data
{
//    Byte *decryptBytes = [DES decryptDES:encryptBytes key:DESKEY useEBCmode:YES];
//    NSLog(@"decryptBytes = %@",[NSString stringWithUTF8String:(const char*)decryptBytes]);
//    free(decryptBytes);
    return nil;
}

@end
