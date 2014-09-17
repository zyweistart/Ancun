#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "NSString+Utils.h"
#import "Response.h"
#import "Config.h"
#import "Common.h"

@protocol HttpViewDelegate <NSURLConnectionDataDelegate>

@optional
- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode;
- (void)requestFailed:(int)reqCode;

@end

@interface HttpRequest : NSObject<NSURLConnectionDataDelegate,UIActionSheetDelegate>
//请求码
@property int requestCode;
//是否验证
@property BOOL isVerify;
//是否为文件下载
@property BOOL isFileDownload;
//是否显示提示信息
@property BOOL isShowMessage;
//请求时的提示信息
@property (strong,nonatomic) NSString *message;
//属性
@property (strong,nonatomic) NSMutableDictionary *propertys;
//当前请求的控制器
@property (strong,nonatomic) UIViewController *controller;
//代理对象
@property (strong,nonatomic) NSObject<HttpViewDelegate> *delegate;

+ (NetworkStatus)getNetworkStatus;
+ (BOOL)isNetworkConnection;
- (void)handle:(NSString*)url headParams:(NSMutableDictionary*)head requestParams:(NSMutableDictionary*)request;

@end