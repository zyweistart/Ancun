#import "BaseEGOTableViewPullRefreshViewController.h"

@implementation BaseEGOTableViewPullRefreshViewController

- (id)init{
    self=[super init];
    if(self){
        self.currentPage=0;
        self.dataItemArray=[[NSMutableArray alloc]init];
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self buildTableViewWithView:self.view];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(!self.tableView.pullTableIsRefreshing) {
        self.tableView.pullTableIsRefreshing = YES;
        [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

#pragma mark - PullTableViewDelegate

- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3.0f];
    [self refreshTable];
}

- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
//    [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:3.0f];
    [self loadMoreDataToTable];
}

#pragma mark - Refresh and load more methods

- (void)refreshTable
{
    /*
     *子类重写该方法完成下拉刷新的功能
     */
    self.currentPage=1;
    [self loadHttp];
}

- (void)loadMoreDataToTable
{
    /*
     *子类重写该方法完成更多刷新的功能
     */
    self.currentPage++;
    [self loadHttp];
}

- (void)loadHttp
{
    NSLog(@"子类必须重写该方法调用网络接口");
    [self performSelector:@selector(loadDone) withObject:nil afterDelay:3.0];
}

//调用该方法完成刷新状态
- (void)loadDone
{
    [self.tableView reloadData];
    if(self.tableView.pullTableIsRefreshing){
        self.tableView.pullLastRefreshDate = [NSDate date];
        self.tableView.pullTableIsRefreshing = NO;
    }else if(self.tableView.pullTableIsLoadingMore){
        self.tableView.pullTableIsLoadingMore = NO;
    }
}

//创建PullTableView
- (PullTableView *)buildTableViewWithView:(UIView*)view;
{
    if(self.tableView==nil){
        self.tableView=[[PullTableView alloc]initWithFrame:view.bounds];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.tableView setPullDelegate:self];
        [view addSubview:self.tableView];
    }
    return self.tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[self dataItemArray] count]>0){
        return [[self dataItemArray] count];
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        return CGHeight(45);
    }else{
        return self.tableView.bounds.size.height;
    }
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", indexPath.row];
        return cell;
    }else{
        static NSString *CNOCell = @"NOCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CNOCell];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CNOCell];
        }
        UIButton *noData=[[UIButton alloc]initWithFrame:CGRectMake1(110, self.tableView.bounds.size.height/2-40, 100, 80)];
        [noData.titleLabel setFont:GLOBAL_FONTSIZE(14)];
        [noData setTitle:@"暂无数据" forState:UIControlStateNormal];
        [noData setTitleColor:BCOLOR(140) forState:UIControlStateNormal];
        [cell addSubview:noData];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  @"删除";
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return  UITableViewCellEditingStyleDelete;
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSDictionary *rData=[[response resultJSON] objectForKey:@"data"];
        if(rData){
            //当前页
//            self.currentPage=[[NSString stringWithFormat:@"%@",[rData objectForKey:@"PageIndex"]] intValue];
            //获取数据列表
            NSDictionary *tabData=rData;
            if(tabData){
                NSMutableArray *nsArr=[[NSMutableArray alloc]init];
                for(id data in tabData){
                    [nsArr addObject:data];
                }
//                if([self currentPage]==1){
                    [[self dataItemArray] removeAllObjects];
//                }
                [[self dataItemArray] addObjectsFromArray:nsArr];
            }
        }
    }
    [self loadDone];
}

- (void)requestFailed:(int)reqCode
{
    [self loadDone];
}

@end