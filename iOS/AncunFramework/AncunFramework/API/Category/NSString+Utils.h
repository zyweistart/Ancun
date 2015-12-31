#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *)md5;

- (NSData *)base64Decode;
- (NSString *)base64Encode:(NSData*)data;

-(NSString *)aes256_encrypt:(NSString *)key;
-(NSString *)aes256_decrypt:(NSString *)key;

- (BOOL)isEmpty;

- (NSString *)URLEncodedString;

@end
