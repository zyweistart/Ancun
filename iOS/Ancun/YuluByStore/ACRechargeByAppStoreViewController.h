#ifdef  TEST
#define PRODUCTRECORDNO_STRING @"1dc3838c3c2c9ce5a1fe54f9b6cf5bb9"
#else
#define PRODUCTRECORDNO_STRING @"d74c6d7791f331a3bf8f9fc16ae16656"
#endif

#define CACHE_ACCOUNT_PAY1 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY1")
#define CACHE_ACCOUNT_PAY2 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY2")
#define CACHE_ACCOUNT_PAY3 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY3")

#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"
#import "StoreKit/StoreKit.h"

@interface ACRechargeByAppStoreViewController :BaseRefreshTableViewController<HttpViewDelegate,SKProductsRequestDelegate,UIActionSheetDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;

@end

