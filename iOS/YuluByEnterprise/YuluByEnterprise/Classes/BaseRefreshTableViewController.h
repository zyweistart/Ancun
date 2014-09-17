#import "BaseTableViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface BaseRefreshTableViewController:BaseTableViewController<EGORefreshTableHeaderDelegate,ResultDelegate,HttpViewDelegate>{
    //页大小
    NSInteger _pageSize;
    //当前页数
    NSInteger _currentPage;
    //是否处于加载中
	BOOL _reloading;
    //是否加载完毕
    BOOL _loadOver;
    EGORefreshTableHeaderView *_refreshHeaderView;
}

- (void)autoRefresh;
- (void)doneManualRefresh;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end