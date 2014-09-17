#import "BaseViewController.h"
#import "Book.h"

@interface ACPeriodicalRootContentViewController : BaseViewController<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

- (id)initWithData:(NSArray *)data Index:(NSInteger)index book:(Book *)book;

@end