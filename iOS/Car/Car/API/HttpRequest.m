#import "HttpRequest.h"
#import "Reachability.h"

@implementation HttpRequest
{
    NSMutableData *_data;
    long long downloadFileSize;
}

- (id)initWithRequestCode:(int)requestCode
{
    self=[super init];
    if(self){
        self.reqCode=requestCode;
        self.isFileDownload=NO;
        self.isMultipartFormDataSubmit=NO;
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

- (void)handle:(NSString*)action requestParams:(NSMutableDictionary*)params
{
    if ([HttpRequest isNetworkConnection]) {
        NSString *url=@"";
        if(self.isMultipartFormDataSubmit){
            NSString *access_token=[params objectForKey:@"access_token"];
            url=[NSString stringWithFormat:@"%@&access_token=%@&dir=image&Type=1",url,access_token];
        }
        // 初始化一个请求
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        // 设置请求方法
        request.HTTPMethod = @"POST";
        // 60秒请求超时
        request.timeoutInterval = 60;
        if(self.isMultipartFormDataSubmit){
            NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            
            NSString *boundary=@"AaB03x";
            
            // post body
            NSMutableData *body = [NSMutableData data];
            
            // add params (all params are strings)
            for (NSString *param in params) {
                id value=[params objectForKey:param];
                if(![value isKindOfClass:[NSData class]]){
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", [param stringByAddingPercentEscapesUsingEncoding:gbkEncoding]] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:gbkEncoding]];
                }
            }
            // add image data
            for (NSString *param in params) {
                id value=[params objectForKey:param];
                if([value isKindOfClass:[NSData class]]){
                    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@.png\"\r\n",param,param] dataUsingEncoding:gbkEncoding]];
                    [body appendData:[@"Content-Type: image/png\r\n\r\n" dataUsingEncoding:gbkEncoding]];
                    [body appendData:value];
                    [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:gbkEncoding]];
                }
            }
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:gbkEncoding]];
            
            //        NSLog(@"%@",[[NSString alloc] initWithData:body  encoding:gbkEncoding]);
            
            [request setValue:[NSString stringWithFormat:@"multipart/form-data, boundary=%@",boundary] forHTTPHeaderField: @"Content-Type"];
            
            // set the content-length
            [request setValue:[NSString stringWithFormat:@"%ld",[body length]] forHTTPHeaderField:@"Content-Length"];
            
            [request setHTTPBody:body];
            
        }else{
            NSString *bodyContent=@"";
            // 对字符串进行编码后转成NSData对象
            NSData *data = [bodyContent dataUsingEncoding:NSUTF8StringEncoding];
            // 设置请求主体
            request.HTTPBody = data;
        }
        // 初始化一个连接
        NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];

        // 开始一个异步请求
        [conn start];
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
        float size=[_data length]/(float)downloadFileSize;
        if(size>0) {
            NSLog(@"%lf",size);
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
        [response setSuccessFlag:[@"0" isEqualToString:[response code]]];
        if(![response successFlag]){
            NSLog(@"%@",[response msg]);
        }
        [_delegate requestFinishedByResponse:response requestCode:self.reqCode];
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
}

@end