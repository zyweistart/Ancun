#import "HttpDownload.h"
#import "ATMHud.h"

@implementation HttpDownload{
    NSString* docDir;
    NSFileManager* fileManager;
    NSMutableData *receiveData;
    long long downloadFileSize;
    ATMHud *mAtmHud;
    
    NSInteger requestCode;
    NSObject *objSender;
    NSString *fileName;
    NSString *filePath;
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
    }
    return self;
}

- (void)AsynchronousDownloadWithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender
{
    if([Common isNull:url]){
        return;
    }
    if([url isEmpty]){
        return;
    }
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(queue, ^{
        //生成唯一文件夹名
        NSString *fName=[Common buildFileNameWithUrl:url];
        NSString *path = [docDir stringByAppendingPathComponent:fName];
        if([fileManager fileExistsAtPath:path]) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
                    [self.delegate requestFinishedByRequestCode:reqCode Path:path Object:sender];
                }
            });
        } else {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
//            NSString *urlString=[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//            NSURL *url=[NSURL URLWithString:urlString];
//            NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:url] returningResponse:NULL error:NULL];
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
            }
            dispatch_sync(dispatch_get_main_queue(), ^{
                if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
                    [self.delegate requestFinishedByRequestCode:reqCode Path:path Object:sender];
                }
            });
        }
    });
}

- (void)AsynchronousDownloadWithView:(UIView*)view WithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender
{
    if([Common isNull:url]){
        return;
    }
    if([url isEmpty]){
        return;
    }
    requestCode=reqCode;
    objSender=sender;
    //生成唯一文件夹名
    fileName=[Common buildFileNameWithUrl:url];
    filePath = [docDir stringByAppendingPathComponent:fileName];
    if([fileManager fileExistsAtPath:filePath]) {
        if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
            [self.delegate requestFinishedByRequestCode:requestCode Path:filePath Object:objSender];
        }
    }else{
        if ([HttpRequest isNetworkConnection]) {
            NSString *urlString = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            // 初始化一个请求
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            // 设置请求方法
            request.HTTPMethod = @"GET";
            // 60秒请求超时
            request.timeoutInterval = 60;
            //初始化一个连接
            NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
            //开始一个异步请求
            [conn start];
            if(view){
                mAtmHud=[[ATMHud alloc]init];
                [view addSubview:mAtmHud.view];
                [mAtmHud setCaption:@"下载中..."];
                [mAtmHud setProgress:0.01];
                [mAtmHud show];
            }
        }
    }
}

#pragma mark 该方法在响应connection时调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(receiveData==nil) {
        receiveData=[[NSMutableData alloc]init];
    }
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if(httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]){
        NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
        //获取文件文件的大小
        downloadFileSize = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
    }
}

#pragma mark 接收到服务器返回的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
    //显示下载进度条
    if(mAtmHud){
        float size=[receiveData length]/(float)downloadFileSize;
        if(size>0) {
            [mAtmHud setProgress:size];
        }
    }
}

#pragma mark 服务器的数据已经接收完毕时调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( [self.delegate respondsToSelector: @selector(connectionDidFinishLoading:)]) {
        [self.delegate connectionDidFinishLoading:connection];
    } else {
        if (receiveData) {
            //获取临时目录
            NSString *tmpDir=NSTemporaryDirectory();
            //更改到待操作的临时目录
            [fileManager changeCurrentDirectoryPath:[tmpDir stringByExpandingTildeInPath]];
            NSString *tmpPath = [tmpDir stringByAppendingPathComponent:fileName];
            //创建数据缓冲区
            NSMutableData* writer = [[NSMutableData alloc] init];
            //将字符串添加到缓冲中
            [writer appendData: receiveData];
            //将其他数据添加到缓冲中
            //将缓冲的数据写入到临时文件中
            [writer writeToFile:tmpPath atomically:YES];
            //把临时下载好的文件移动到主文档目录下
            [fileManager moveItemAtPath:tmpPath toPath:filePath error:nil];
        }
        if([self.delegate respondsToSelector:@selector(requestFinishedByRequestCode:Path:Object:)]){
            [self.delegate requestFinishedByRequestCode:requestCode Path:filePath Object:objSender];
        }
    }
    //隐藏下载进度条
    if(mAtmHud) {
        [mAtmHud hide];
        [mAtmHud.view removeFromSuperview];
        mAtmHud=nil;
    }
}

#pragma mark 网络连接出错时调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if( [self.delegate respondsToSelector: @selector(connection:didFailWithError:)]) {
        [self.delegate connection:connection didFailWithError:error];
    }
    //隐藏下载进度条
    if(mAtmHud) {
        [mAtmHud hide];
        [mAtmHud.view removeFromSuperview];
        mAtmHud=nil;
    }
}

@end