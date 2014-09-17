#import "Common.h"

@implementation Common

+ (id)getCache:(NSString *)key{
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    return [settings objectForKey:key];
}
+ (void)setCache:(NSString *)key data:(id)data{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    [setting setObject:data forKey:key];
    [setting synchronize];
}
+ (BOOL)getCacheByBool:(NSString *)key{
    NSUserDefaults * settings = [NSUserDefaults standardUserDefaults];
    return [settings boolForKey:key];
}
+ (void)setCacheByBool:(NSString *)key data:(BOOL)data{
    NSUserDefaults *setting=[NSUserDefaults standardUserDefaults];
    [setting setBool:data forKey:key];
    [setting synchronize];
}

+ (void)alert:(NSString *)message cancel:(NSString *)cancelName ok:(NSString *)okName delegate:(id<UIAlertViewDelegate>)delegate{
    [Common alert:message cancel:cancelName ok:okName delegate:delegate tag:0];
}

+ (void)alert:(NSString *)message cancel:(NSString *)cancelName ok:(NSString *)okName delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"信息"
                          message:message
                          delegate:delegate
                          cancelButtonTitle:cancelName
                          otherButtonTitles:okName, nil];
    alert.tag=tag;
    [alert show];
}

+ (void)alert:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"信息"
                          message:message
                          delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil, nil];
    [alert show];
}

+ (void)actionSheet:(id<UIActionSheetDelegate>)delegate message:(NSString *)message ok:(NSString *) okName tag:(NSInteger)tag{
    UIActionSheet *sheet = [[UIActionSheet alloc]
                            initWithTitle:message
                            delegate:delegate
                            cancelButtonTitle:@"取消"
                            destructiveButtonTitle:okName
                            otherButtonTitles:nil,nil];
    sheet.tag=tag;
    //UIActionSheet与UITabBarController结合使用不能使用[sheet showInView:self.view];
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
}

+ (void)actionSheet:(id<UIActionSheetDelegate>)delegate message:(NSString *)message tag:(NSInteger)tag{
    [Common actionSheet:delegate message:message ok:@"确定" tag:tag];
}

//返回调用
+ (void)resultNavigationViewController:(UIViewController *)view resultDelegate:(NSObject<ResultDelegate> *)resultDelegate resultCode:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableDictionary *)result{
    if(resultDelegate){
        if([resultDelegate respondsToSelector:@selector(onControllerResult:requestCode:data:)]){
            [resultDelegate onControllerResult:resultCode requestCode:requestCode data:result];
        }
    }
    [view.navigationController popViewControllerAnimated:YES];
}

+ (void)setCacheXmlByList:(NSString *)xml tag:(NSString *)tag {
    NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithDictionary:[Common getCache:[Config Instance].cacheKey]];
    [dictionary setObject:xml forKey:tag];
    [Common setCache:[Config Instance].cacheKey data:dictionary];
}

+ (NSMutableArray *)getCacheXmlByList:(NSString *)tag {
    NSMutableDictionary *dictioanry=[Common getCache:[Config Instance].cacheKey];
    if(dictioanry){
        NSString *content=[dictioanry objectForKey:tag];
        if(![@"" isEqualToString:content]) {
            if(content){
//                NSMutableArray *dataItemArray=[[Common toResponseData:content] dataItemArray];
//                if([dataItemArray count]>0){
//                    return dataItemArray;
//                }
            }
        }
    }
    return nil;
}

+ (NSData *)toJSONData:(id)theData{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}

+ (void)loadHtmlWithWebView:(UIWebView*)webView url:(NSString *)url fileName:(NSString*)fileName
{
    //创建文件管理器
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //获取Documents主目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //得到相应的Documents的路径
    NSString* docDir = [paths objectAtIndex:0];
    NSString *documentPath=[docDir stringByAppendingPathComponent:@"documents"];
    //文件夹不存在则创建目录
    if(![fileManager fileExistsAtPath:documentPath]){
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentPath stringByExpandingTildeInPath]];
    NSString *path = [documentPath stringByAppendingPathComponent:fileName];
    if([fileManager fileExistsAtPath:path]){
        if(webView){
            //缓存文件存在则直接显示
            [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
        }
    }else{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            //异步加载网络文件
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (data) {
                    //加载成功后把文件缓存至本地
                    //创建数据缓冲区
                    NSMutableData* writer = [[NSMutableData alloc] init];
                    //将字符串添加到缓冲中
                    [writer appendData: data];
                    //将其他数据添加到缓冲中
                    //将缓冲的数据写入到临时文件中
                    [writer writeToFile:path atomically:YES];
                    if(webView){
                        //把文件进行展示
                        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
                    }
                }
            });
        });
    }
}

+ (void)loadImageWithImageView:(UIImageView*)image url:(NSString *)url fileName:(NSString*)fileName
{
    //创建文件管理器
    NSFileManager* fileManager = [NSFileManager defaultManager];
    //获取Documents主目录
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //得到相应的Documents的路径
    NSString* docDir = [paths objectAtIndex:0];
    NSString *documentPath=[docDir stringByAppendingPathComponent:@"images"];
    //文件夹不存在则创建目录
    if(![fileManager fileExistsAtPath:documentPath]){
        [fileManager createDirectoryAtPath:documentPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //更改到待操作的目录下
    [fileManager changeCurrentDirectoryPath:[documentPath stringByExpandingTildeInPath]];
    NSString *path = [documentPath stringByAppendingPathComponent:fileName];
    if([fileManager fileExistsAtPath:path]){
        //缓存图片存在则直接显示
        [image setImage:[UIImage imageWithContentsOfFile:path]];
    }else{
        //首先设置为默认图片
        [image setImage:[UIImage imageNamed:@"default_book"]];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            //异步加载网络图片
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (imageData) {
                    //加载成功后把图片缓存至本地
                    //创建数据缓冲区
                    NSMutableData* writer = [[NSMutableData alloc] init];
                    //将字符串添加到缓冲中
                    [writer appendData: imageData];
                    //将其他数据添加到缓冲中
                    //将缓冲的数据写入到临时文件中
                    [writer writeToFile:path atomically:YES];
                    //把图片进行展示
                    [image setImage:[UIImage imageWithContentsOfFile:path]];
                }
            });
        });
    }
}

@end
