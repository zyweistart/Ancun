//
//  XLImageView.m
//  Car
//
//  Created by Start on 11/27/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "XLImageView.h"
#import "SJAvatarBrowser.h"

@implementation XLImageView

- (id)initWithFrame:(CGRect)rect
{
    self=[super initWithFrame:rect];
    if(self){
        [self setBackgroundColor:[UIColor redColor]];
        [self setUserInteractionEnabled:YES];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goOpen)]];
    }
    return self;
}

- (void)loadImageNetUrl:(NSString*)url
{
    if([url isEmpty]){
        return;
    }
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        //创建文件管理器
        NSFileManager* fileManager = [NSFileManager defaultManager];
        //获取Documents主目录
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //得到相应的Documents的路径
        NSString* docDir = [paths objectAtIndex:0];
        //更改到待操作的目录下
        [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
        //生成唯一文件夹名
        NSString *fName=[NSString stringWithFormat:@"%@",[url md5]];
        NSString *path = [docDir stringByAppendingPathComponent:fName];
        if(![fileManager fileExistsAtPath:path]) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if (data) {
                //获取临时目录
                NSString *tmpDir=NSTemporaryDirectory();
                //更改到待操作的临时目录
                [fileManager changeCurrentDirectoryPath:[tmpDir stringByExpandingTildeInPath]];
                NSString *tmpPath = [tmpDir stringByAppendingPathComponent:fName];
                //创建数据缓冲区
                NSMutableData* writer = [[NSMutableData alloc] init];
                //将字符串添加到缓冲中
                [writer appendData: data];
                //将其他数据添加到缓冲中
                //将缓冲的数据写入到临时文件中
                [writer writeToFile:tmpPath atomically:YES];
                //把临时下载好的文件移动到主文档目录下
                [fileManager moveItemAtPath:tmpPath toPath:path error:nil];
                [self buildThumbnail:path FileManager:fileManager];
            }
            if(![path isEmpty]){
                path=[NSString stringWithFormat:@"%@thum",path];
                UIImage *image=[UIImage imageWithContentsOfFile:path];
                if(image){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self setImage:image];
                    });
                }
            }
        } else {
            [self buildThumbnail:path FileManager:fileManager];
            if(![path isEmpty]){
                path=[NSString stringWithFormat:@"%@thum",path];
                UIImage *image=[UIImage imageWithContentsOfFile:path];
                if(image){
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [self setImage:image];
                    });
                }
            }
        }
    });
}

- (UIImage*)buildThumbnail:(NSString*)path FileManager:(NSFileManager* )fileManager
{
    NSString *thumPath=[NSString stringWithFormat:@"%@thum",path];
    if(![fileManager fileExistsAtPath:thumPath]) {
        NSData *imageData = [NSData dataWithContentsOfFile: path];
        //下载图片生成缩略图
        UIImage *image=[UIImage imageWithData:imageData];
        if(image){
            image=[image cutCenterImageSize:CGSizeMake1(300, 120)];
            [self saveWithPath:thumPath Data:UIImagePNGRepresentation(image)];
            return image;
        }
    }
    return nil;
}

- (void)saveWithPath:(NSString*)path Data:(NSData*)data
{
    //创建数据缓冲区
    NSMutableData* writer = [[NSMutableData alloc] init];
    //将字符串添加到缓冲中
    [writer appendData: data];
    //将其他数据添加到缓冲中
    //将缓冲的数据写入到临时文件中
    [writer writeToFile:path atomically:YES];
}

- (void)loadSuccess:(NSString*)path
{
    if(![path isEmpty]){
        path=[NSString stringWithFormat:@"%@thum",path];
        UIImage *image=[UIImage imageWithContentsOfFile:path];
        if(image){
            [self setImage:image];
        }
    }
}

- (void)goOpen
{
    [SJAvatarBrowser showImage:self];
}

@end