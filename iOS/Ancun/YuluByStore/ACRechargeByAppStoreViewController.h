#ifdef  TEST
#define PRODUCTRECORDNO_STRING_APPSTORE @"d74c6d7791f331a3bf8f9fc16ae16656"
#else
#define PRODUCTRECORDNO_STRING_APPSTORE @"d74c6d7791f331a3bf8f9fc16ae16656"
#endif

#define CACHE_ACCOUNT_PAY1_APPSTORE CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY1")
#define CACHE_ACCOUNT_PAY2_APPSTORE CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY2")
#define CACHE_ACCOUNT_PAY3_APPSTORE CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY3")

#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"
#import "StoreKit/StoreKit.h"

@interface ACRechargeByAppStoreViewController :BaseRefreshTableViewController<HttpViewDelegate,SKProductsRequestDelegate,UIActionSheetDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;

@end

