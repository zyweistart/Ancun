#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"

@interface ACRechargeByAlipayViewController :BaseRefreshTableViewController<HttpViewDelegate,UIActionSheetDelegate>


@property (strong,nonatomic)HttpRequest *hRequest;

@end
