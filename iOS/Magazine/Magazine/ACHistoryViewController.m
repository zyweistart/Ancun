#import "ACHistoryViewController.h"

@interface ACHistoryViewController ()
@end

@implementation ACHistoryViewController

- (id)init
{
    self=[super init];
    if(self){
        self.pageCount=1;
        //验证数据是否已经加载完毕
        self.endReached = NO;
        [self.dataItemArray removeAllObjects];
        for(int i=1;i<=PAGESIZE;i++){
            [self.dataItemArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return self;
}

- (void)doRefresh
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self.dataItemArray removeAllObjects];
        for(int i=1;i<=PAGESIZE;i++){
            [self.dataItemArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        self.pageCount=1;
        NSLog(@"下拉刷新了,第%d页",self.pageCount);
        //验证数据是否已经加载完毕
        self.endReached = NO;
        [self setLoading:NO];
    });
}

- (void)loadMore
{
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.pageCount++;
        NSLog(@"加载更多了,第%d页",self.pageCount);
        for(int i=1;i<=PAGESIZE;i++){
            [self.dataItemArray addObject:[NSString stringWithFormat:@"%d",i*self.pageCount]];
        }
        //验证数据是否已经加载完毕
        if(self.pageCount == 4){
            self.endReached = YES;
        }else{
            self.endReached = NO;
        }
        [self.tableView reloadData];
    });
}

#pragma mark - Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[super tableView:tableView cellForRowAtIndexPath:indexPath];
    if(cell!=nil){
        return cell;
    }
    cell= [[UITableViewCell alloc]init];
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld", indexPath.row+1];
    cell.imageView.image = [UIImage imageNamed:@"iOS6"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end