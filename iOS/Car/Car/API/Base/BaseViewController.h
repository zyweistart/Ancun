#import <UIKit/UIKit.h>
#import "HttpRequest.h"
#import "ResultDelegate.h"
#import "HttpDownload.h"

//所有UI控制器的父对象
@interface BaseViewController : UIViewController<ResultDelegate,HttpViewDelegate,HttpDownloadDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;
@property (strong,nonatomic) HttpDownload *hDownload;
@property (assign,nonatomic) NSObject<ResultDelegate> *rDelegate;

@end