//
//  UploadCrypt.m
//  Ume
//
//  Created by Start on 5/27/15.
//  Copyright (c) 2015 Ancun. All rights reserved.
//

#import "UploadCrypt.h"
#import "NSString+Utils.h"
//#import "AESCrypt.h"

@implementation UploadCrypt

+ (NSData*)getSceneAESByte:(NSData*)buffer Duration:(long)duration
{
    int aeslen=80;
    Byte aes[aeslen];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    NSInteger second = [dateComponent second];
    NSLog(@"%ld-%ld-%ld %ld:%ld:%ld", year,month,day,hour,minute,second);
    aes[0]=(Byte)(year&0xFF);
    aes[1]=(Byte)((year>>8)&0xFF);
    aes[2]=[UploadCrypt getValue:month];
    aes[3]=[UploadCrypt getValue:day];
    aes[4]=[UploadCrypt getValue:hour];
    aes[5]=[UploadCrypt getValue:minute];
    aes[6]=[UploadCrypt getValue:second];
    aes[7]=[UploadCrypt getValue:0];
    //from
    for(int i=8;i<28;i++){
        aes[i]=[UploadCrypt getValue:0];
    }
    //to
    for(int i=28;i<48;i++){
        aes[i]=[UploadCrypt getValue:0];
    }
    //数据流长度
    long length=[buffer length];
    aes[48]=(Byte)(length&0xFF);
    aes[49]=(Byte)((length>>8)&0xFF);
    aes[50]=(Byte)((length>>16)&0xFF);
    aes[51]=(Byte)((length>>24)&0xFF);
    //数据流MD5
    NSString *aString =[[NSString alloc]initWithData:buffer encoding:NSUTF8StringEncoding];
    //计算MD5
    NSString *md5Str=[aString md5];
    //获取指针的个数
    for (int i=0;i!=[md5Str length]/2;i++) {
        NSString *str=[md5Str substringWithRange:NSMakeRange(i*2,2)];
        //十六进度字符串转为整型
        long v=strtoul([str UTF8String],0,16);
        aes[52+i]=[UploadCrypt getValue:v];
    }
    //录音时长2位存放
    aes[68]=(Byte)(duration&0xFF);
    aes[69]=(Byte)((duration>>8)&0xFF);
    for(int i=70;i<80;i++){
        aes[i]=[UploadCrypt getValue:0];
    }
    
//    NSString *key=[AESCrypt decrypt:[[User Instance]enKey] password:[[User Instance]getPassword]];
//    NSData *aesData = [[NSData alloc] initWithBytes:aes length:aeslen];
//    NSString *aesString = [[NSString alloc]initWithData:aesData encoding:NSUTF8StringEncoding];
//    NSString *encrypt=[AESCrypt encrypt:aesString password:key];
//    return [encrypt dataUsingEncoding:NSUTF8StringEncoding]; ;
    return nil;
}

+ (NSData*)getTotalEnByte:(NSData*)aes
{
    int len = 92;
    Byte total[len];
    NSString *tag=@"FLYSOFTSI";
    NSData *tagData = [tag dataUsingEncoding: NSUTF8StringEncoding];
    Byte *tagByte = (Byte*)[tagData bytes];
    for(int i=0;i<[tagData length];i++){
        total[i]=tagByte[i];
    }
    //填充1
    total[9]=[UploadCrypt getValue:1];
    //存放长度
    total[10]=(Byte)(len&0xFF);
    total[11]=(Byte)((len>>8)&0xFF);
    Byte *aesByte = (Byte*)[aes bytes];
    for(int i=0;i<[aes length];i++){
        total[12+i]=aesByte[i];
    }
    return [[NSData alloc] initWithBytes:total length:len];
}


+ (Byte)getValue:(NSInteger)v
{
    return (Byte)(v&0xFF);
}

@end
