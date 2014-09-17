#import "HttpRequest.h"
#import "ATMHud.h"
#import "MBProgressHUD.h"

@implementation HttpRequest {
    
    ATMHud *_atmHud;
    MBProgressHUD *_mbpHud;
    
    NSString* _action;
    NSMutableDictionary* _head;
    NSMutableDictionary* _request;
    
    NSMutableData *_data;
    long long downloadFileSize;
    
}

+ (NetworkStatus)getNetworkStatus {
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    return [reach currentReachabilityStatus];
}

//是否已连接网络
+ (BOOL)isNetworkConnection {
    NetworkStatus netStatus = [HttpRequest getNetworkStatus];
    if(netStatus==ReachableViaWWAN||netStatus==ReachableViaWiFi) {
        return YES;
    } else {
        return NO;
    }
}

- (id)init
{
    self=[super init];
    if(self){
        _isVerify=YES;
        _isShowMessage=YES;
        _isFileDownload=NO;
    }
    return self;
}

- (void)handle:(NSString*)action headParams:(NSMutableDictionary*)head requestParams:(NSMutableDictionary*)request {
    if ([HttpRequest isNetworkConnection]) {
        _action=action;
        _head=head;
        _request=request;
        if(_isFileDownload) {
            //如果为下载是否使用的是3G移动网络
            if([HttpRequest getNetworkStatus]==ReachableViaWWAN) {
                [Common actionSheet:self message:@"即将通过移动网络下载数据，为了节约流量，推荐您使用WIFI无线网络!" tag:1];
            } else {
                [self handle];
            }
        } else {
            [self handle];
        }
    } else {
        if(self.controller) {
            [Common alert:@"网络连接出错，请检测网络设置"];
        }
    }
}

- (void)handle {
    //组装请求的URL地址
    NSMutableString *URL=[[NSMutableString alloc]initWithString:ANCUN_HTTP_URL];
    for(NSString *key in _request){
        [URL appendFormat:@"%@=%@&",key,[[_request objectForKey:key] URLEncodedString]];
    }
    [URL appendString:@"a=a"];
    // 初始化一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    // 设置请求方法
    request.HTTPMethod = @"POST";
    // 60秒请求超时
    request.timeoutInterval = 10;
    //设置请求头参数
    for(NSString *key in _head) {
        //URL编码
        [request addValue:[[_head objectForKey:key] URLEncodedString] forHTTPHeaderField:key];
    }
    // 初始化一个连接
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:self];
    // 开始一个异步请求
    [conn start];
    
    if(_isFileDownload){
        _atmHud=[[ATMHud alloc]init];
        [self.controller.view addSubview:_atmHud.view];
        [_atmHud setCaption:@"下载中..."];
        [_atmHud setProgress:0.01];
        [_atmHud show];
        [[Config Instance]setIsCalculateTotal:YES];
    } else {
        if(self.controller&&(self.message!=nil||self.isShowMessage)) {
            _mbpHud = [[MBProgressHUD alloc] initWithView:self.controller.view];
            [self.controller.view addSubview:_mbpHud];
            if(self.message) {
                _mbpHud.labelText = self.message;
            }
            _mbpHud.dimBackground = NO;
            _mbpHud.square = YES;
            [_mbpHud show:YES];
        }
    }
}

#pragma mark 该方法在响应connection时调用
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
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
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
    if(self.isFileDownload) {
        //显示下载进度条
        if(_atmHud) {
            float size=[_data length]/(float)downloadFileSize;
            if(size>0) {
                [_atmHud setProgress:size];
            }
        }
    }
}

#pragma mark 服务器的数据已经接收完毕时调用
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if( [_delegate respondsToSelector: @selector(connectionDidFinishLoading:)]) {
        [_delegate connectionDidFinishLoading:connection];
    } else if( [_delegate respondsToSelector: @selector(requestFinishedByResponse:requestCode:)]) {
        Response *response=[[Response alloc]init];
        [response setData:_data];
        [response setPropertys:_propertys];
        [response setSuccessFlag:YES];
        if(!_isFileDownload) {
            //转换成JSON格式
            [response setResultJSON:[NSJSONSerialization JSONObjectWithData:[response data] options:NSJSONReadingMutableLeaves error:nil]];
            [response setResponseString:[[NSString alloc] initWithData:[response data] encoding:NSUTF8StringEncoding]];
            NSString *result=[[response resultJSON] objectForKey:@"result"];
            if([@"success" isEqualToString:result]){
                [response setSuccessFlag:YES];
            }else if([@"failed" isEqualToString:result]){
                [response setSuccessFlag:NO];
                if(_isVerify) {
                    [Common alert:[[response resultJSON] objectForKey:@"reason"]];
                }
            }else{
                [response setSuccessFlag:NO];
                [Common alert:@"未知异常"];
            }
        }
        [_delegate requestFinishedByResponse:response requestCode:self.requestCode];
    }
    //隐藏下载进度条
    if(_atmHud) {
        [_atmHud hide];
    }
    //隐藏等待条
    if (_mbpHud) {
        [_mbpHud hide:YES];
    }
}

#pragma mark 网络连接出错时调用
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"网络连接出错%@",[error localizedDescription]);
    if( [_delegate respondsToSelector: @selector(connection:didFailWithError:)]) {
        [_delegate connection:connection didFailWithError:error];
    } else if( [_delegate respondsToSelector: @selector(requestFailed:)]) {
        [_delegate requestFailed:self.requestCode];
    } else {
        [Common alert:@"请求异常，请重试！"];
    }
    //隐藏下载进度条
    if(_atmHud) {
        [_atmHud hide];
    }
    //隐藏等待条
    if (_mbpHud) {
        [_mbpHud hide:YES];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(actionSheet.tag==1) {
        //移动流量下载行为
        if(buttonIndex==0) {
            [self handle];
        }
    }
}

@end