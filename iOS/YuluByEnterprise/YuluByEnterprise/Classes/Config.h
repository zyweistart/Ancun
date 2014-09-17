#import "ResultDelegate.h"

@interface Config : NSObject

//是否已登陆
@property Boolean isLogin;
//是否需要计算缓存空间大小
@property Boolean isCalculateTotal;
//是否需要刷新录音详细页面
@property Boolean isRefreshRecordingList;
//是否需要刷新使用记录页面
@property Boolean isRefreshUseRecordList;
//是否刷新账户套餐列表页面
@property Boolean isRefreshAccountPayList;
//是否刷新账户套餐列表页面
@property Boolean isRefreshAccountUseRecordList;
//是否刷新时长版用户月份统计信息
@property Boolean isRefreshOldAccountMonthList;
//是否刷新用户信息
@property Boolean isRefreshUserInfo;

@property (strong,nonatomic) UIViewController *currentViewController;
//唯一缓存键名称
@property (strong,nonatomic) NSString *cacheKey;
//用户信息
@property (strong,nonatomic) NSMutableDictionary *userInfo;
//用户授权列表
@property (strong,nonatomic) NSMutableArray *userAuthList;
//登陆代理
@property (strong,nonatomic) NSObject<ResultDelegate> *loginResultDelegate;
//联系人
@property (strong,nonatomic) NSMutableDictionary *contact;
//不能通过软件拔打的号码
@property (strong,nonatomic) NSMutableArray *noDialPhoneNumber;
//是否已经套餐过基础套餐
@property (assign,nonatomic) BOOL isPayBase;
//当前用户的套餐列表
@property (strong,nonatomic) NSMutableArray *currentPackagesList;

+ (Config *)Instance;

+ (void)resetConfig;

- (BOOL)isOldUser;

- (BOOL)isMaster;

- (BOOL)isAuth:(NSString*)authName;

@end