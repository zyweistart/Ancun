#import <UIKit/UIKit.h>
#import "BaseRefreshTableViewController.h"

@interface ACOldAccountDayViewController :BaseRefreshTableViewController<UIScrollViewDelegate,UIActionSheetDelegate>{
    
    HttpRequest *_loadHttp;
    
    int _year;
    NSString *_month;
    
}

- (id)initWithDate:(NSString *)date;

@end

