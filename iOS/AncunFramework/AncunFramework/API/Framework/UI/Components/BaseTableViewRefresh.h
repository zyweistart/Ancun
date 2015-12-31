//
//  BaseTableViewRefresh.h
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseTableView.h"
#import "BaseTableViewCell.h"
#import "MJRefresh.h"

@interface BaseTableViewRefresh : BaseTableView

@property (assign,nonatomic) BOOL isRefreshData;
@property (assign,nonatomic) NSInteger currentPage;
@property (strong,nonatomic) MJRefreshNormalHeader *refreshHeader;
@property (strong,nonatomic) MJRefreshAutoNormalFooter *refreshFooter;

- (void)loadHttp;
- (void)loadDone;
- (void)loadRefreshHeader;
- (void)loadRefreshMore;
- (void)startBeginRefresh;
- (MJRefreshNormalHeader*)getRefreshHeader;
- (MJRefreshAutoNormalFooter*)getRefreshFooter;

@end
