#ifdef  TEST
#define PRODUCTRECORDNO_STRING @"d7025d331c315d856dfdee440f3f9c34"
#else
#define PRODUCTRECORDNO_STRING @"ac9d9d16706af24455b5834eec56d2d5"
#endif

#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"

@interface ACRechargeByAlipayViewController :BaseRefreshTableViewController<HttpViewDelegate,UIActionSheetDelegate>


@property (strong,nonatomic)HttpRequest *hRequest;

@end
