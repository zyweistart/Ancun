#import <Foundation/Foundation.h>

@interface NSString (Utils)

- (NSString *)md5;

- (NSData *)base64Decode;
- (NSString *)base64Encode:(NSData*)data;

- (BOOL)isEmpty;

@end
