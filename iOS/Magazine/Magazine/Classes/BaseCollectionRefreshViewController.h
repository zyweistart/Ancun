#import <UIKit/UIKit.h>
#import "BaseCollectionViewController.h"
#import "EGORefreshTableHeaderView.h"


@interface BaseCollectionRefreshViewController : BaseCollectionViewController
{
    BOOL _loading;
}

//总页面数
@property (assign, nonatomic) int currentPage;
//是否正在加载中
@property (nonatomic, assign) BOOL loading;
//是否已经加载完毕
@property (nonatomic, assign) BOOL endReached;

- (void)loadDataWithPage:(int)page;

@end