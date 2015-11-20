//
//  HttpConnection.h
//  Ancun
//
//  Created by Start on 13-9-12.
//
//

#import "Response.h"

@protocol HttpViewDelegate <NSURLConnectionDataDelegate>

@optional
- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode;
- (void)requestFailed:(int)reqCode;

@end

@interface HttpRequest : NSObject<NSURLConnectionDataDelegate,UIActionSheetDelegate>

@property int reqCode;
//显示返回的错误信息
@property BOOL isShowFailedMessage;
//是否为文件下载
@property BOOL isFileDownload;
//Post表单数据提交
@property (strong,nonatomic) NSDictionary *postParams;
@property (strong,nonatomic) NSDictionary *jsonParams;

@property (strong,nonatomic) UIView *view;
@property (strong,nonatomic) NSObject<HttpViewDelegate> *delegate;

- (id)initWithRequestCode:(int)requestCode;
+ (BOOL)isNetworkConnection;
- (void)handleWithParams:(NSMutableDictionary*)params;
- (void)handleWithParams:(NSMutableDictionary*)params WithURL:(NSString*)url;

@end