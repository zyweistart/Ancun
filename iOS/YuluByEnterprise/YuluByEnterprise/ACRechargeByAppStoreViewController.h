#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"
#import "StoreKit/StoreKit.h"

@interface ACRechargeByAppStoreViewController :BaseRefreshTableViewController<HttpViewDelegate,SKProductsRequestDelegate,UIActionSheetDelegate>

@end

