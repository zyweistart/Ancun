//
//  BaseTableViewRefresh.m
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BaseTableViewRefresh.h"
#import "BaseTableViewCell.h"
#import "BaseEntity.h"

@implementation BaseTableViewRefresh

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self=[super initWithFrame:frame style:style];
    if(self){
        self.isRefreshData=YES;
        [self setMj_header:[self getRefreshHeader]];
        [self setMj_footer:[self getRefreshFooter]];
    }
    return self;
}

- (MJRefreshNormalHeader*)getRefreshHeader
{
    if(self.refreshHeader==nil){
        self.refreshHeader=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshHeader)];
        [self.refreshHeader.arrowView setImage:[UIImage imageNamed:@"arrow_White"]];
        [self.refreshHeader.stateLabel setHidden:YES];
        [self.refreshHeader.lastUpdatedTimeLabel setHidden:YES];
        [self.refreshHeader setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [self.refreshHeader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [self.refreshHeader setTitle:@"释放刷新" forState:MJRefreshStatePulling];
        [self.refreshHeader setTitle:@"加载中 ..." forState:MJRefreshStateRefreshing];
        self.refreshHeader.stateLabel.font = [UIFont systemFontOfSize:15];
        self.refreshHeader.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
        self.refreshHeader.stateLabel.textColor = [UIColor whiteColor];
        self.refreshHeader.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    }
    return self.refreshHeader;
}

- (MJRefreshAutoNormalFooter*)getRefreshFooter
{
    if(self.refreshFooter==nil){
        self.refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadRefreshMore)];
        [self.refreshFooter setAutomaticallyHidden:NO];
        [self.refreshFooter setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
        [self.refreshFooter setTitle:@"加载更多" forState:MJRefreshStateIdle];
        [self.refreshFooter setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        [self.refreshFooter setTitle:@"没有数据了" forState:MJRefreshStateNoMoreData];
        self.refreshFooter.stateLabel.font = [UIFont systemFontOfSize:15];
        self.refreshFooter.stateLabel.textColor = [UIColor whiteColor];
    }
    return self.refreshFooter;
}

- (void)startBeginRefresh
{
    if(![self.mj_header isRefreshing]){
        [self.mj_header beginRefreshing];
    }
}

- (void)loadHttp
{
    NSLog(@"子类必须重写该方法调用网络接口");
    [self performSelector:@selector(loadDone) withObject:nil afterDelay:3.0];
}

- (void)loadRefreshHeader
{
    self.currentPage=0;
    [self loadHttp];
}

- (void)loadRefreshMore
{
    self.currentPage++;
    [self loadHttp];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if(self.cellDataArray==nil){
        self.cellDataArray=[[NSMutableArray alloc]init];
    }
    if([@"-100002" isEqualToString:[response code]]){
        //没有任何数据
        [self.cellDataArray removeAllObjects];
        [self.mj_footer endRefreshingWithNoMoreData];
    }else  if([@"-100003" isEqualToString:[response code]]){
        //当前页没有数据
        [self.mj_footer setHidden:YES];
    }else{
        if([response successFlag]){
            NSDictionary *arrayData=[[response resultJSON] objectForKey:@"content"];
            if(arrayData){
                NSMutableArray *nsArr=[[NSMutableArray alloc]init];
                for(id data in arrayData){
                    [nsArr addObject:[BaseEntity buildInstanceClass:self.classes WithData:data]];
                }
                if(30>[nsArr count]){
                    [self.mj_footer setHidden:YES];
                }else{
                    [self.mj_footer setHidden:NO];
                }
                if([nsArr count]>0){
                    if([self currentPage]==0){
                        [[self cellDataArray] removeAllObjects];
                    }
                    [[self cellDataArray] addObjectsFromArray:nsArr];
                }
            }
        }
    }
    [self loadDone];
}

- (void)requestFailed:(int)reqCode
{
    [self loadDone];
}

- (void)loadDone
{
    self.isRefreshData=NO;
    [self reloadData];
    if([self.mj_header isRefreshing]){
        [self.mj_header endRefreshing];
    }
    if([self.mj_footer isRefreshing]){
        [self.mj_footer endRefreshing];
    }
}

@end
