#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"
#import "ACPlayerView.h"

@interface ACRecordingManagerDetailListOldViewController :BaseRefreshTableViewController<UIActionSheetDelegate,UIAlertViewDelegate>{
    ACPlayerView *_playerView;
    NSMutableDictionary *_currentDictionary;
}

@end
