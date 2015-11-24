#import "HttpDownload.h"
#import "MBProgressHUD.h"
#import "NSString+Utils.h"

@implementation HttpDownload{
    NSString* docDir;
    NSFileManager* fileManager;
    NSMutableDictionary *cacheData;
    NSOperationQueue *queue;
    MBProgressHUD *mBMPHud;
}

- (id)initWithDelegate:(NSObject<HttpDownloadDelegate>*)delegate
{
    self=[super init];
    if(self){
        //创建文件管理器
        fileManager = [NSFileManager defaultManager];
        //获取Documents主目录
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        //得到相应的Documents的路径
        docDir = [paths objectAtIndex:0];
        //更改到待操作的目录下
        [fileManager changeCurrentDirectoryPath:[docDir stringByExpandingTildeInPath]];
        [self setDelegate:delegate];
        cacheData=[[NSMutableDictionary alloc]initWithCapacity:10];
        
        self.isShowProgressHUD=NO;
        
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 8;
    }
    return self;
}

- (void)AsynchronousDownloadWithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender
{
    return [self AsynchronousDownloadWithUrl:url RequestCode:reqCode Object:sender DownloadType:1];
//    if([url isEmpty]){
//        return;
//    }
//    //生成唯一文件夹名
//    NSString *fName=[NSString stringWithFormat:@"%@",[url md5]];
//    NSString *path = [docDir stringByAppendingPathComponent:fName];
//    if(![fileManager fileExistsAtPath:path]) {
//        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
//            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//            if (data) {
//                //获取临时目录
//                NSString *tmpDir=NSTemporaryDirectory();
//                //更改到待操作的临时目录
//                [fileManager changeCurrentDirectoryPath:[tmpDir stringByExpandingTildeInPath]];
//                NSString *tmpPath = [tmpDir stringByAppendingPathComponent:fName];
//                //创建数据缓冲区
//                NSMutableData* writer = [[NSMutableData alloc] init];
//                //将字符串添加到缓冲中
//                [writer appendData: data];
//                //将其他数据添加到缓冲中
//                //将缓冲的数据写入到临时文件中
//                [writer writeToFile:tmpPath atomically:YES];
//                //把临时下载好的文件移动到主文档目录下
//                [fileManager moveItemAtPath:tmpPath toPath:path error:nil];
//            }
//            if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
//                [self.delegate requestFinishedByRequestCode:reqCode Path:path Object:sender];
//            }
//        }];
//        [queue addOperation:operation];
//    } else {
//        if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
//            [self.delegate requestFinishedByRequestCode:reqCode Path:path Object:sender];
//        }
//    }
}


- (void)AsynchronousDownloadWithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender DownloadType:(NSInteger)downloadType
{
    if([url isEmpty]){
        return;
    }
    //生成唯一文件夹名
    NSString *fName=[NSString stringWithFormat:@"%@",[url md5]];
    NSString *path = [docDir stringByAppendingPathComponent:fName];
    if(![fileManager fileExistsAtPath:path]) {
        if(self.isShowProgressHUD){
            mBMPHud = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:mBMPHud];
            mBMPHud.dimBackground = NO;
            mBMPHud.square = YES;
            [mBMPHud show:YES];
        }
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            if (data) {
                //获取临时目录
                NSString *tmpDir=NSTemporaryDirectory();
                //更改到待操作的临时目录
                [fileManager changeCurrentDirectoryPath:[tmpDir stringByExpandingTildeInPath]];
                NSString *tmpPath = [tmpDir stringByAppendingPathComponent:fName];
                [self saveWithPath:tmpPath Data:data];
                //把临时下载好的文件移动到主文档目录下
                [fileManager moveItemAtPath:tmpPath toPath:path error:nil];
                if(downloadType==1){
                    //生成缩略图
                    NSString *thumPath=[NSString stringWithFormat:@"%@thum",path];
                    if(![fileManager fileExistsAtPath:thumPath]) {
                        NSData *imageData = [NSData dataWithContentsOfFile: path];
                        UIImage *image=[UIImage imageWithData:imageData];
                        if(image){
                            image=[image cutCenterImageSize:CGSizeMake1(300, 120)];
                            [self saveWithPath:thumPath Data:UIImagePNGRepresentation(image)];
                        }
                    }
                }
            }
            if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
                [self.delegate requestFinishedByRequestCode:reqCode Path:path Object:sender];
            }
            if(self.isShowProgressHUD){
                if (mBMPHud) {
                    [mBMPHud hide:YES];
                    [mBMPHud removeFromSuperview];
                    mBMPHud=nil;
                }
            }
        }];
        [queue addOperation:operation];
    } else {
        if(downloadType==1){
            NSString *thumPath=[NSString stringWithFormat:@"%@thum",path];
            if(![fileManager fileExistsAtPath:thumPath]) {
                NSData *imageData = [NSData dataWithContentsOfFile: path];
                //下载图片生成缩略图
                UIImage *image=[UIImage imageWithData:imageData];
                if(image){
                    image=[image cutCenterImageSize:CGSizeMake1(300, 120)];
                    [self saveWithPath:thumPath Data:UIImagePNGRepresentation(image)];
                }
            }
        }
        if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
            [self.delegate requestFinishedByRequestCode:reqCode Path:path Object:sender];
        }
    }
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



//dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
//dispatch_async(queue, ^{
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        if (data) {
//            //获取临时目录
//            NSString *tmpDir=NSTemporaryDirectory();
//            //更改到待操作的临时目录
//            [fileManager changeCurrentDirectoryPath:[tmpDir stringByExpandingTildeInPath]];
//            NSString *tmpPath = [tmpDir stringByAppendingPathComponent:fName];
//            //创建数据缓冲区
//            NSMutableData* writer = [[NSMutableData alloc] init];
//            //将字符串添加到缓冲中
//            [writer appendData: data];
//            //将其他数据添加到缓冲中
//            //将缓冲的数据写入到临时文件中
//            [writer writeToFile:tmpPath atomically:YES];
//            //把临时下载好的文件移动到主文档目录下
//            [fileManager moveItemAtPath:tmpPath toPath:path error:nil];
//        }
//        if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
//            [self.delegate requestFinishedByRequestCode:reqCode Path:path Object:sender];
//        }
//    });
//});


@end