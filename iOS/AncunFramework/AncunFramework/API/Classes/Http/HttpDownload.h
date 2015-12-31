
#import "HttpRequest.h"
//下载图片
#define HTTPDOWNLOADCODE_TYPE_IMAGE 500
//下载录音
#define HTTPDOWNLOADCODE_TYPE_RECORDED 5001
//下载录像
#define HTTPDOWNLOADCODE_TYPE_VIDEO 5002

@protocol HttpDownloadDelegate<NSURLConnectionDataDelegate>

@optional

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender;

@end

@interface HttpDownload : NSObject<NSURLConnectionDataDelegate>

- (id)initWithDelegate:(NSObject<HttpDownloadDelegate>*)delegate;

- (void)AsynchronousDownloadWithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender;

- (void)AsynchronousDownloadWithView:(UIView*)view WithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender;

@property (strong,nonatomic) NSObject<HttpDownloadDelegate> *delegate;

@end