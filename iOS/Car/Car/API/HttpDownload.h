@protocol HttpDownloadDelegate

@optional

- (void)requestFinishedByRequestCode:(NSInteger)reqCode Path:(NSString*)path Object:(id)sender;

@end

@interface HttpDownload : NSObject

@property (strong,nonatomic) NSObject<HttpDownloadDelegate> *delegate;

@property (strong,nonatomic)UIView *view;
//是否显示下载等待框
@property (assign,nonatomic)BOOL isShowProgressHUD;

- (id)initWithDelegate:(NSObject<HttpDownloadDelegate>*)delegate;

- (void)AsynchronousDownloadWithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender;
- (void)AsynchronousDownloadWithUrl:(NSString *)url RequestCode:(NSInteger)reqCode Object:(id)sender DownloadType:(NSInteger)downloadType;

@end