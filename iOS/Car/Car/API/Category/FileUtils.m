//
//  FileUtils.m
//  Car
//
//  Created by Start on 10/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "FileUtils.h"

@implementation FileUtils

//保存图片
+ (void)saveImage:(UIImage *)ci withName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(ci);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

//保存文件
+ (NSString*)saveFile:(NSURL*)url withName:(NSString *)name
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    //获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:name];
    //写入文件
    if([data writeToFile:fullPath atomically:NO]){
        NSLog(@"写入成功");
    }else{
        NSLog(@"写入失败");
    }
    return fullPath;
}

+ (long long)fileSizeAtPath:(NSString*)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//最小单位
+ (NSString*)getFileSize:(long long)fileSize
{
    long long fileSizeKB=0,fileSizeMB=0,fileSizeGB=0;
    if(fileSize>=1024){
        fileSizeKB=fileSize/1024;
        if(fileSizeKB>=1024){
            fileSizeMB=fileSizeKB/1024;
            if(fileSizeMB>=1024){
                fileSizeGB=fileSizeMB/1024;
            }
        }
    }
    if(fileSizeGB>0){
        return [NSString stringWithFormat:@"%lldGB",fileSizeGB];
    }else if(fileSizeMB>0){
        return [NSString stringWithFormat:@"%lldMB",fileSizeMB];
    }else if(fileSizeKB>0){
        return [NSString stringWithFormat:@"%lldKB",fileSizeKB];
    }else{
        return [NSString stringWithFormat:@"%lld字节",fileSize];
    }
}

@end