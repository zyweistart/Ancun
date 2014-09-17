
@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (retain,nonatomic) UITableView *tableView;
@property (retain,nonatomic) NSMutableArray *dataItemArray;

- (UITableView *)buildTableView;

@end
