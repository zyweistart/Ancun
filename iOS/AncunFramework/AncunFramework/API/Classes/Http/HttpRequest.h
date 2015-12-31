//
//  HttpConnection.h
//  Ancun
//
//  Created by Start on 13-9-12.
//
//

#import "Response.h"
typedef void(^SuccessBlock)(Response *response,BOOL isHope);
typedef void(^FailureBlock)(NSError *error);

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
//成功调用，使用了代理就不能使用
@property (nonatomic, copy) SuccessBlock success;
//失败掉用
@property (nonatomic, copy) FailureBlock failure;

@property (strong,nonatomic) UIView *view;
@property (strong,nonatomic) NSObject<HttpViewDelegate> *delegate;
@property (strong,nonatomic) NSArray *filterCode;

- (id)initWithRequestCode:(int)requestCode;
+ (BOOL)isNetworkConnection;
- (void)handleWithParams:(NSMutableDictionary*)params;
- (void)handleWithParams:(NSMutableDictionary*)params WithURL:(NSString*)url;

+ (instancetype)postWithParams:(NSMutableDictionary *)params
                          view:(UIView *)displayView
                       showMsg:(BOOL)isShow
                       success:(SuccessBlock)success
                       failure:(FailureBlock)failure;
@end