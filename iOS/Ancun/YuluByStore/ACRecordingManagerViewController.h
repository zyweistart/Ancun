#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"

#define Notification_TabClick_ACRecordingManagerViewController @"Notification_TabClick_ACRecordingManagerViewController"

@interface ACRecordingManagerViewController : BaseRefreshTableViewController<UIActionSheetDelegate>

@property (strong,nonatomic)HttpRequest *hRequest;

@end
