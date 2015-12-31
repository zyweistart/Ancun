#import "DES.h"
#import <CommonCrypto/CommonCryptor.h>

static Byte iv[] = {'3','B','1','3','0','8','B','5'};//only Used for Cipher Block Chaining (CBC) mode,This is ignored if ECB mode is used
@implementation DES

/*DES encrypt*/
+(Byte *) encryptDES:(Byte *)srcBytes key:(NSString *)key useEBCmode:(BOOL)useEBCmode
{
    NSUInteger dataLength = strlen((const char*)srcBytes);
    Byte *encryptBytes = malloc(1024);
    memset(encryptBytes, 0, 1024);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          useEBCmode ? (kCCOptionPKCS7Padding | kCCOptionECBMode):kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          srcBytes	, dataLength,
                                          encryptBytes, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        return encryptBytes;
    }
    else
    {
        return nil;
    }
}

/*DES decrypt*/
+(Byte *) decryptDES:(Byte *)srcBytes key:(NSString *)key useEBCmode:(BOOL)useEBCmode
{
    NSUInteger dataLength = strlen((const char*)srcBytes);
    Byte *decryptBytes = malloc(1024);
    memset(decryptBytes, 0, 1024);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmDES,
                                          useEBCmode ? (kCCOptionPKCS7Padding | kCCOptionECBMode):kCCOptionPKCS7Padding,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          srcBytes	, dataLength,
                                          decryptBytes, 1024,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess)
    {
        return decryptBytes;
    }
    else
    {
        return nil;
    }
}




- (void)testMethod
{
    //This is a demo edited by www.tekuba.net
    //DES CBC mode test
    NSLog(@"DES CBC mode test");
    NSString *keyString = @"tekubanet";//8 bytes are valid
    Byte srcBytes[1024] = {'1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F'};
    Byte *encryptBytes = [DES encryptDES:srcBytes key:keyString useEBCmode:NO];
    
    NSLog(@"encryptBytes = ");
    for(int i = 0 ;i < strlen((const char *)encryptBytes);i++)
    {
        NSLog(@"%c",encryptBytes[i]);
    }
    
    Byte *decryptBytes = [DES decryptDES:encryptBytes key:keyString useEBCmode:NO];
    NSLog(@"decryptBytes = %@",[NSString stringWithUTF8String:(const char*)decryptBytes]);
    free(encryptBytes);
    free(decryptBytes);
    
    //DES EBC mode test
    //    NSLog(@"DES EBC mode test");
    //    NSString *keyString = @"tekubanet";//8 bytes are valid
    //    Byte srcBytes[1024] = {'1','2','3','4','5','6','7','8','9','0','A','B','C','D','E','F'};
    //    Byte *encryptBytes = [DES encryptDES:srcBytes key:keyString useEBCmode:YES];
    //
    //    NSLog(@"encryptBytes = ");
    //    for(int i = 0 ;i < strlen((const char *)encryptBytes);i++)
    //    {
    //        NSLog(@"%c",encryptBytes[i]);
    //    }
    //
    //    Byte *decryptBytes = [DES decryptDES:encryptBytes key:keyString useEBCmode:YES];
    //    NSLog(@"decryptBytes = %@",[NSString stringWithUTF8String:(const char*)decryptBytes]);
    //    free(encryptBytes);
    //    free(decryptBytes);
}


@end
