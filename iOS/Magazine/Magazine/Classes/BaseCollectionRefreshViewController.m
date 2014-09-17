#import "BaseCollectionRefreshViewController.h"
#import "CollectionViewLoadingCell.h"

@interface BaseCollectionRefreshViewController ()

@property (nonatomic, strong) EGORefreshTableHeaderView *refreshHeaderView;

@end

@implementation BaseCollectionRefreshViewController

- (id)init
{
    self=[super init];
    if(self){
        self.refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.collectionView.bounds.size.height, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height)];
        self.refreshHeaderView.keyNameForDataStore = [NSString stringWithFormat:@"%@_LastRefresh", [self class]];
        [self.collectionView addSubview:self.refreshHeaderView];
        //注册加载更多数据CELL
        [self.collectionView registerClass:[CollectionViewLoadingCell class] forCellWithReuseIdentifier:CELLIDENTIFIERLOADINGCELL];
        //加载缓存数据
        NSString *responseString=[Common getCache:CACHE_DATA];
        if(responseString!=nil){
            NSDictionary *resultJSON=[NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
            [self pagingHandle:resultJSON];
        }
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.searchDisplayController.searchResultsTableView == scrollView){
        return;
    }
    if (self.refreshHeaderView.state == EGOOPullRefreshLoading) {
        CGFloat offset = MAX(scrollView.contentOffset.y * -1, 0);
        offset = MIN(offset, 60);
        scrollView.contentInset = UIEdgeInsetsMake(offset, 0.0f, 0.0f, 0.0f);
    } else if (scrollView.isDragging) {
        if (self.refreshHeaderView.state == EGOOPullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && !self.loading) {
            [self.refreshHeaderView setState:EGOOPullRefreshNormal];
        } else if (self.refreshHeaderView.state == EGOOPullRefreshNormal && scrollView.contentOffset.y < -65.0f && !self.loading) {
            [self.refreshHeaderView setState:EGOOPullRefreshPulling];
        }
        if (scrollView.contentInset.top != 0) {
            scrollView.contentInset = UIEdgeInsetsZero;
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.searchDisplayController.searchResultsTableView == scrollView){
        return;
    }
    if(!self.loading){
        if (scrollView.contentOffset.y <= - 65.0f) {
            [self setLoading:YES];
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(self.endReached){
        return [self.dataItemArray count];
    }else{
        return [self.dataItemArray count]+1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(!self.endReached){
        if(indexPath.row == [self.dataItemArray count])  {
            return CGSizeMake(320, 40);
        }
    }
    return CGSizeMake(100, 100);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == [self.dataItemArray count])  {
		CollectionViewLoadingCell *cell = (CollectionViewLoadingCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELLIDENTIFIERLOADINGCELL forIndexPath:indexPath];
        //开始执行加载更多方法
        [self performSelector:@selector(loadMore) withObject:nil afterDelay:0.5];
		return cell;
    }
    return nil;
}

- (BOOL)loading
{
    return _loading;
}

- (void)setLoading:(BOOL)loading
{
    _loading = loading;
    [UIView beginAnimations:nil context:nil];
    if(loading) {
        [self.refreshHeaderView setState:EGOOPullRefreshLoading];
        [UIView setAnimationDuration:0.2];
		self.collectionView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        //开始执行下拉刷新
        [self doRefresh];
    } else {
        [self.refreshHeaderView setState:EGOOPullRefreshNormal];
        [self.refreshHeaderView setCurrentDate];
        [UIView setAnimationDuration:.3];
        [self.collectionView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    }
    [UIView commitAnimations];
}

- (void)doRefresh
{
    [self loadDataWithPage:1];
}

- (void)loadMore
{
    [self loadDataWithPage:self.currentPage+1];
}

- (void)loadDataWithPage:(int)page
{
   NSAssert(NO,@"子类必须覆盖该方法，该语句不得出现在控制台上"); 
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        //分页处理
        [self pagingHandle:[response resultJSON]];
        if(_loading){
            //还原下拉刷新状态
            [self setLoading:NO];
        }
    }else{
        if(self.currentPage==1){
            [self.dataItemArray removeAllObjects];
        }
        self.endReached = YES;
        //还原下拉刷新状态
        if(_loading){
            [self setLoading:NO];
        }
    }
    //存入缓存
    if(self.currentPage==1){
        [Common setCache:CACHE_DATA data:[response responseString]];
    }
    //刷新数据表
    [self.collectionView reloadData];
}

- (void)requestFailed:(int)reqCode
{
    [Common alert:@"网络异常，请重试"];
    self.endReached = YES;
    //还原下拉刷新状态
    if(_loading){
        [self setLoading:NO];
    }
    //刷新数据表
    [self.collectionView reloadData];
}

//分页处理
- (void)pagingHandle:(NSDictionary*)resultJSON
{
    self.currentPage=[[resultJSON objectForKey:@"currentpage"] intValue];
    int totalpage=[[resultJSON objectForKey:@"totalpage"] intValue];
    
    NSArray *data=[resultJSON objectForKey:@"data"];
    if(self.currentPage==1){
        [self.dataItemArray removeAllObjects];
    }
    [self.dataItemArray addObjectsFromArray:data];
    
    //验证数据是否已经加载完毕
    if(self.currentPage == totalpage){
        self.endReached = YES;
    }else{
        self.endReached = NO;
    }
}

@end