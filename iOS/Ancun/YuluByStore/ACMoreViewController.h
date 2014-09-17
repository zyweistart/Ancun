#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface ACMoreViewController : BaseViewController<HttpViewDelegate,UIAlertViewDelegate>

@property (strong,nonatomic) HttpRequest *hRequest;

- (void)checkVersion:(BOOL)flag;

@end
