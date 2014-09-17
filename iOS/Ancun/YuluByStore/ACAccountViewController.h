#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"

@interface ACAccountViewController :BaseRefreshTableViewController<UIScrollViewDelegate,UIActionSheetDelegate>


@property (strong,nonatomic)HttpRequest *hRequest;

@end

