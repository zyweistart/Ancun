#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "PullTableView.h"

#define PAGESIZE 8

@interface BaseEGOTableViewPullRefreshViewController : BaseViewController <UITableViewDataSource,UITableViewDelegate, PullTableViewDelegate>

@property NSInteger currentPage;
@property (strong,nonatomic) PullTableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataItemArray;

- (PullTableView *)buildTableViewWithView:(UIView*)view;

- (void)refreshTable;
- (void)loadMoreDataToTable;
- (void)loadDone;
- (void)loadHttp;

@end
