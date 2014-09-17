#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface ACMoreViewController : BaseTableViewController<UIActionSheetDelegate>{
    NSMutableDictionary *_moreInSection;
    long long cachesize;
}

@end
