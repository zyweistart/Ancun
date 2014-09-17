#import "ResultDelegate.h"
#import "Response.h"
#import "Config.h"

@interface Common : NSObject
//缓存存取
+ (id)getCache:(NSString *)key;
+ (void)setCache:(NSString *)key data:(id)data;
+ (BOOL)getCacheByBool:(NSString *)key;
+ (void)setCacheByBool:(NSString *)key data:(BOOL)data;
//提示选择
+ (void)alert:(NSString *)message cancel:(NSString *)cancelName ok:(NSString *)okName delegate:(id<UIAlertViewDelegate>)delegate tag:(NSInteger)tag;
+ (void)alert:(NSString *)message cancel:(NSString *)cancelName ok:(NSString *)okName delegate:(id<UIAlertViewDelegate>)delegate;
+ (void)alert:(NSString *)message;
+ (void)actionSheet:(id<UIActionSheetDelegate>)delegate message:(NSString *)message ok:(NSString *) okName tag:(NSInteger)tag;
+ (void)actionSheet:(id<UIActionSheetDelegate>)delegate message:(NSString *)message tag:(NSInteger)tag;

+ (void)setCacheXmlByList:(NSString *)xml tag:(NSString *)tag;

+ (NSMutableArray *)getCacheXmlByList:(NSString *)tag;

+ (NSData *)toJSONData:(id)theData;
+ (void)loadHtmlWithWebView:(UIWebView*)webView url:(NSString *)url fileName:(NSString*)fileName;
+ (void)loadImageWithImageView:(UIImageView*)image url:(NSString *)url fileName:(NSString*)fileName;

@end