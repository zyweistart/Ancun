//
//  Data+Utils.h
//  Witness
//
//  Created by Start on 12/2/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Utils)

//计算NSData 的MD5值
- (NSString*)md5;
//aes
- (NSData*)aes256_encrypt:(NSString*)key;
- (NSData*)aes256_decrypt:(NSString*)key;

@end