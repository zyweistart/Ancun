#import "DataSingleton.h"

@implementation DataSingleton

static DataSingleton *instance = nil;

+ (DataSingleton *)Instance{
    @synchronized(self){
        if(nil == instance){
            [self new];
        }
    }
    return instance;
}

+ (id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if(instance == nil){
            instance = [super allocWithZone:zone];
            return instance;
        }
    }
    return nil;
}

static NSString *loadingCellIdentifier=@"loadingCell";

- (UITableViewCell*)getLoadMoreCell:(UITableView *)tableView
                      andIsLoadOver:(BOOL)isLoadOver
                  andLoadOverString:(NSString *)loadOverString
                   andLoadingString:(NSString *)loadingString
                       andIsLoading:(BOOL)isLoading{
    LoadingCell* cell = [tableView dequeueReusableCellWithIdentifier:loadingCellIdentifier];
    if (!cell) {
//        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LoadingCell" owner:self options:nil];
//        for (NSObject *o in objects) {
//            if ([o isKindOfClass:[LoadingCell class]]) {
//                cell = (LoadingCell *)o;
//                break;
//            }
//        }
        cell = [[LoadingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadingCellIdentifier];
    }
    cell.lbl.font = [UIFont boldSystemFontOfSize:21.0];
    cell.lbl.text = isLoadOver ? loadOverString : loadingString;
    if (isLoading){
        cell.loading.hidden = NO;
        [cell.loading startAnimating];
    }else{
        cell.loading.hidden = YES;
        [cell.loading stopAnimating];
    }
    return cell;
}


- (UITableViewCell*)getLoadMoreCell:(UITableView *)tableView
                      andIsLoadOver:(BOOL)isLoadOver
                       andIsLoading:(BOOL)isLoading currentPage:(NSUInteger)currentPage{
    LoadingCell* cell = [tableView dequeueReusableCellWithIdentifier:@"loadingCell"];
    if (!cell) {
//        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:@"LoadingCell" owner:self options:nil];
//        for (NSObject *o in objects) {
//            if ([o isKindOfClass:[LoadingCell class]]) {
//                cell = (LoadingCell *)o;
//                break;
//            }
//        }
        cell = [[LoadingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loadingCellIdentifier];
    }
    cell.lbl.font = [UIFont boldSystemFontOfSize:21.0];
    cell.lbl.text = isLoadOver ? @"数据加载完毕" : (isLoading ? @"正在加载 . . ." : @"更多 . . .");
    if(currentPage==0){
        if(isLoadOver){
            cell.lbl.text=@"暂无记录";
        }
    }
    if (isLoading){
        cell.loading.hidden = NO;
        [cell.loading startAnimating];
    }else{
        cell.loading.hidden = YES;
        [cell.loading stopAnimating];
    }
    return cell;
}

@end
