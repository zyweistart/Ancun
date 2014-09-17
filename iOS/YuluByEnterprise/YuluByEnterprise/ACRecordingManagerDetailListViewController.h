#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"
#import "ACPlayerView.h"

@interface ACRecordingManagerDetailListViewController :BaseRefreshTableViewController<UIActionSheetDelegate,UIAlertViewDelegate>{
    NSString *_oppno;
    ACPlayerView *_playerView;
    NSMutableDictionary *_currentDictionary;
}

- (id)initWithOppno:(NSString*)_oppno;

@end
