#import "HttpRequest.h"
#import "NSString+Utils.h"
#import "Reachability.h"
#import "ATMHud.h"
#import "MBProgressHUD.h"

@implementation HttpRequest
{
    NSMutableData *_data;
    long long downloadFileSize;
    ATMHud *mAtmHud;
    MBProgressHUD *mBMPHud;
}

- (id)initWithRequestCode:(int)requestCode
{
    self=[super init];
    if(self){
        self.reqCode=requestCode;
        self.isFileDownload=NO;
        self.isShowFailedMessage=NO;
    }
    return self;
}

//是否已连接网络
+ (BOOL)isNetworkConnection
{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    if(netStatus==ReachableViaWWAN||netStatus==ReachableViaWiFi) {
        return YES;
    } else {
        return NO;
    }
}

- (void)handleWithParams:(NSMutableDictionary*)params
{
    [self handleWithParams:params WithURL:ANCUN_HTTP_URL];
}

- (void)handleWithParams:(NSMutableDictionary*)params WithURL:(NSString*)url
{
    if ([HttpRequest isNetworkConnection]) {
        NSMutableString *URL=[[NSMutableString alloc]initWithString:url];
        if([params count]>0){
            long d=(long)[[NSDate date] timeIntervalSince1970];
            [params setObject:[NSString stringWithFormat:@"%ld",d] forKey:@"httpTime"];
            NSMutableArray *strs=[[NSMutableArray alloc]init];
            for(NSString *key in params){
                [URL appendFormat:@"%@=%@&",key,[params objectForKey:key]];
                [strs addObject:key];
            }
            NSMutableString *sign=[[NSMutableString alloc]init];
            for(NSString *key in [strs sortedArrayUsingSelector:@selector(compare:)]){
                [sign appendFormat:@"%@=%@|",key,[params objectForKey:key]];
            }
            NSRange deleteRange1 = {[sign length]-1,1};
            [sign deleteCharactersInRange:deleteRange1];
            [URL appendFormat:@"sign=%@",[sign md5]];
        }
        NSString *urlString=[[NSString alloc]initWithString:URL];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        // 初始化一个请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        // 设置请求方法
        request.HTTPMethod = @"POST";
        // 60秒请求超时
        request.timeoutInterval = 60;
        
        if(self.postParams){
            NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSString *boundary=@"AaB03x";
            // post body
            NSMutableData *body = [NSMutableData data];
            
            // add params (all params are strings)
            for (NSString *p in self.postParams) {
                id value=[self.postParams objectForKey:p];
                if(![value isKindOfClass:[NSData class]]){
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", [p stringByAddingPercentEscapesUsingEncoding:gbkEncoding]] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:gbkEncoding]];
                }
            }
            // add image data
            for (NSString *p in self.postParams) {
                id value=[self.postParams objectForKey:p];
                if([value isKindOfClass:[NSData class]]){
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.png\"\r\n",p,p] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:gbkEncoding]];
                    [body appendData:value];
                    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:gbkEncoding]];
                }
            }
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:gbkEncoding]];
            //打印请求数据
//            NSString *pos=[[NSString alloc] initWithData:body encoding:gbkEncoding];
//            NSLog(@"%@",pos);
            
            [request setValue:[NSString stringWithFormat:@"multipart/form-data, boundary=%@",boundary] forHTTPHeaderField: @"Content-Type"];
            // set the content-length
            [request setValue:[NSString stringWithFormat:@"%ld",[body length]] forHTTPHeaderField:@"Content-Length"];
            [request setHTTPBody:body];
        }else if(self.jsonParams){
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.jsonParams options:NSJSONWritingPrettyPrinted error:&error];
            if (jsonData) {
                [request setHTTPBody:jsonData];
            }
        }
        //初始化一个连接
        NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
        //开始一个异步请求
        [conn start];
        if(self.view){
            if(self.isFileDownload){
                mAtmHud=[[ATMHud alloc]init];
                [self.view addSubview:mAtmHud.view];
                [mAtmHud setCaption:@"下载中..."];
                [mAtmHud setProgress:0.01];
                [mAtmHud show];
            }else{
                mBMPHud = [[MBProgressHUD alloc]initWithView:self.view];
                [self.view addSubview:mBMPHud];
                mBMPHud.dimBackground = NO;
                mBMPHud.square = YES;
                [mBMPHud show:YES];
            }
        }
    } else {
        if( [_delegate respondsToSelector: @selector(requestFailed:)]) {
            [_delegate requestFailed:self.reqCode];
        }
    }
}

#pragma mark 该方法在响应connection时调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    if(_data==nil) {
        _data=[[NSMutableData alloc]init];
    }
    if(self.isFileDownload) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse && [httpResponse respondsToSelector:@selector(allHeaderFields)]){
            NSDictionary *httpResponseHeaderFields = [httpResponse allHeaderFields];
            //获取文件文件的大小
            downloadFileSize = [[httpResponseHeaderFields objectForKey:@"Content-Length"] longLongValue];
        }
    }
}

#pragma mark 接收到服务器返回的数据
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_data appendData:data];
    if(self.isFileDownload) {
        //显示下载进度条
        if(mAtmHud){
            float size=[_data length]/(float)downloadFileSize;
            if(size>0) {
                [mAtmHud setProgress:size];
            }
        }
    }
}

#pragma mark 服务器的数据已经接收完毕时调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if( [_delegate respondsToSelector: @selector(connectionDidFinishLoading:)]) {
        [_delegate connectionDidFinishLoading:connection];
    } else if( [_delegate respondsToSelector: @selector(requestFinishedByResponse:requestCode:)]) {
        NSString *responseString =[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
        Response *response=[Response toData:responseString];
        //成功标记
        [response setSuccessFlag:[@"success" isEqualToString:[response code]]];
        if(self.isShowFailedMessage){
            if(![response successFlag]){
                if([response msg]&&![[response msg]isEmpty]){
                    [Common alert:[response msg]];
                }
            }
        }
        [_delegate requestFinishedByResponse:response requestCode:self.reqCode];
    }
    //隐藏等待条
    if (mBMPHud) {
        [mBMPHud hide:YES];
        [mBMPHud removeFromSuperview];
        mBMPHud=nil;
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
    if( [_delegate respondsToSelector: @selector(connection:didFailWithError:)]) {
        [_delegate connection:connection didFailWithError:error];
    } else if( [_delegate respondsToSelector: @selector(requestFailed:)]) {
        [_delegate requestFailed:self.reqCode];
    }
    //隐藏等待条
    if (mBMPHud) {
        [mBMPHud hide:YES];
        [mBMPHud removeFromSuperview];
        mBMPHud=nil;
    }
    //隐藏下载进度条
    if(mAtmHud) {
        [mAtmHud hide];
        [mAtmHud.view removeFromSuperview];
        mAtmHud=nil;
    }
}

@end