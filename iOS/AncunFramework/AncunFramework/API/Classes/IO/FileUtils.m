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
+ (BOOL)saveImage:(UIImage *)ci withName:(NSString *)imageName
{
    NSData *imageData = UIImagePNGRepresentation(ci);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    return [imageData writeToFile:fullPath atomically:NO];
}

//保存文件
+ (NSString*)saveFile:(NSURL*)url withName:(NSString *)name
{
    //获取Documents主目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //得到相应的Documents的路径
    NSString *docDir = [paths objectAtIndex:0];
    //完整路径
    NSString *fullPath = [docDir stringByAppendingPathComponent:name];
    NSError *error;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager moveItemAtPath:[url path] toPath:fullPath error:&error]){
        return fullPath;
    }else{
        return nil;
    }
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