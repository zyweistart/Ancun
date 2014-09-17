#import "LoadingCell.h"

@interface DataSingleton:NSObject

+ (DataSingleton *) Instance;

+ (id)allocWithZone:(NSZone *)zone;

//返回标示正在加载的选项
- (UITableViewCell *)getLoadMoreCell:(UITableView *)tableView 
                       andIsLoadOver:(BOOL)isLoadOver 
                       andLoadOverString:(NSString *)loadOverString 
                       andLoadingString:(NSString *)loadingString 
                       andIsLoading:(BOOL)isLoading;

- (UITableViewCell*)getLoadMoreCell:(UITableView *)tableView
                      andIsLoadOver:(BOOL)isLoadOver
                       andIsLoading:(BOOL)isLoading currentPage:(NSUInteger)currentPage;

@end
