#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"

@interface ACOldAccountViewController :BaseRefreshTableViewController<UIScrollViewDelegate,UIActionSheetDelegate>{
    
    HttpRequest *_loadHttp;
    UILabel *_lblTimeLong;
    
}

@end

