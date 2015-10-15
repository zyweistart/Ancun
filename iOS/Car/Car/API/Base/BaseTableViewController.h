#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) NSMutableArray *dataItemArray;
@property (strong,nonatomic) UITableView *tableView;

- (UITableView *)buildTableViewWithView:(UIView*)view;
- (UITableView *)buildTableViewWithView:(UIView*)view style:(UITableViewStyle)style;

@end