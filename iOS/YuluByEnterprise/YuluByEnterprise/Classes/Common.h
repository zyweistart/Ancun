#import "ResultDelegate.h"
#import <AddressBookUI/AddressBookUI.h>

@interface Common : NSObject
//缓存存取
+ (id)getCache:(NSString *)key;
+ (void)setCache:(NSString *)key data:(id)data;
+ (BOOL)getCacheByBool:(NSString *)key;
+ (void)setCacheByBool:(NSString *)key data:(BOOL)data;
//提示选择
+ (void)alert:(NSString *)message;
+ (void)notificationMessage:(NSString *)message inView:(UIView *)aView;
+ (void)actionSheet:(id<UIActionSheetDelegate>)delegate message:(NSString *)message tag:(NSInteger)tag;
+ (void)noLoginAlert:(id<UIActionSheetDelegate>)delegate;
//字符格式处理
+ (NSString*)formatPhone:(NSString *)phone;
+ (NSString*)secondConvertFormatTimerByCn:(NSString *)second;
+ (NSString*)secondConvertFormatTimerByEn:(NSString *)second;
//返回代理
+ (void)resultLoginViewController:(UIViewController *)view resultCode:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableDictionary *)result;
+ (void)resultNavigationViewController:(UIViewController *)view resultDelegate:(NSObject<ResultDelegate> *)resultDelegate resultCode:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableDictionary *)result;
//公共类获取
+ (ABAddressBookRef)getAbAddressBook;

+ (void)setCacheXmlByList:(NSString *)xml tag:(NSString *)tag;
+ (NSMutableArray *)getCacheXmlByList:(NSString *)tag;

@end
