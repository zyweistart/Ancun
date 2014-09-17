#import "ResultDelegate.h"

@interface Config : NSObject

//是否已登陆
@property Boolean isLogin;
//是否刷新用户信息
@property Boolean isRefreshUserInfo;
//是否需要刷新使用记录页面
@property Boolean isRefreshUseRecordList;
//是否刷新账户套餐列表页面
@property Boolean isRefreshAccountPayList;
//是否刷新账户套餐列表页面
@property Boolean isRefreshAccountUseRecordList;
//是否需要刷新录音详细页面
@property Boolean isRefreshRecordingList;
//是否需要计算缓存空间大小
@property Boolean isCalculateTotal;
//
@property Boolean lock;

//唯一缓存键名称
@property (strong,nonatomic) NSString *cacheKey;
//用户信息
@property (strong,nonatomic) NSMutableDictionary *userInfo;
//登陆代理
@property (strong,nonatomic) NSObject<ResultDelegate> *loginResultDelegate;
//联系人
@property (strong,nonatomic) NSMutableDictionary *contact;
//不能通过软件拔打的号码
@property (strong,nonatomic) NSMutableArray *noDialPhoneNumber;
//当前用户的套餐列表
@property (strong,nonatomic) NSMutableArray *currentPackagesList;

@property (strong,nonatomic) NSString *USERNAME;
@property (strong,nonatomic) NSString *PASSWORD;

@property (strong,nonatomic) UIAlertView *alertView;
@property (strong,nonatomic) UIActionSheet *actionSheet;

+ (Config *)Instance;

+ (void)resetConfig;

@end