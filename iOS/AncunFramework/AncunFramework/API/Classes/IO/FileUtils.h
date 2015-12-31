//
//  FileUtils.h
//  Car
//
//  Created by Start on 10/28/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject

+ (BOOL)saveImage:(UIImage *)ci withName:(NSString *)imageName;
+ (NSString*)saveFile:(NSURL*)url withName:(NSString *)name;
+ (long long)fileSizeAtPath:(NSString*)filePath;
+ (NSString*)getFileSize:(long long)fileSizeKB;

@end
