//
//  ACRechargeByAlipayViewController.m
//  Ancun
//
//  Created by Start on 4/4/14.
//
//

#import "ACRechargeByAlipayViewController.h"
#import "ACRechargeNav.h"
#import "ACAccountPay1Cell.h"
#import "DataSingleton.h"
#import "NSString+Utils.h"
#import "IAPHelper.h"

#ifdef  TEST
#define PRODUCTRECORDNO_STRING @"8f13597db224df927b4a02658326ca39"
#else
#define PRODUCTRECORDNO_STRING @"ac9d9d16706af24455b5834eec56d2d5"
#endif

@interface ACRechargeByAlipayViewController ()

@end

@implementation ACRechargeByAlipayViewController {
    
    BOOL isTimeout;
    ACRechargeNav *_rechargeNav;
    SKProductsRequest *_productsRequest;
    
}

- (id)init {
    
    if (self) {
        
        self.navigationItem.title=@"账户充值";
        
        UIView *container=nil;
        if(IOS7){
            container=[[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
        }else{
            container=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
        }
        [self.view addSubview:container];
        
        _rechargeNav=[[ACRechargeNav alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [_rechargeNav firstStep];
        [container addSubview:_rechargeNav];
        
        self.tableView=[[UITableView alloc]initWithFrame:
                        CGRectMake(0, 40,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height-40)];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [container addSubview:self.tableView];
        if(_refreshHeaderView==nil){
            EGORefreshTableHeaderView *view=[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.tableView.frame.size.width, self.tableView.bounds.size.height)];
            view.delegate = self;
            [self.tableView addSubview:view];
            _refreshHeaderView = view;
        }
        [_refreshHeaderView refreshLastUpdatedDate];
    }
    self = [super init];
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self autoRefresh];;
}

#pragma mark -
#pragma mark Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count=[[[IAPHelper sharedHelper]products]count];
    if(count>0){
        if(PAGESIZE>count){
            return count;
        }else{
            return count+1;
        }
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataItemArray count]>[indexPath row]){
        return 60;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *accountPayCell1=@"ACAccountRechargeCell1";
    //获取当前的行
    NSInteger row=[indexPath row];
    if([self.dataItemArray count]>row) {
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        ACAccountPay1Cell *cell = [self.tableView dequeueReusableCellWithIdentifier:accountPayCell1];
        if(!cell) {
            cell = [[ACAccountPay1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountPayCell1];
        }
        [cell.lblTimeLong setText:[NSString stringWithFormat:@"有效期%@天",[dictionary objectForKey:@"valid"]]];
        [cell.lblTime setText:[NSString stringWithFormat:@"%@分钟",[dictionary objectForKey:@"duration"]]];
        [cell.lblStorage setText:[NSString stringWithFormat:@"%@MB",[dictionary objectForKey:@"storage"]]];
        [cell.lblName setText:[dictionary objectForKey:@"name"]];
        [cell setData:dictionary];
        [cell setControler:self];
        return cell;
    } else {
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:_loadOver andIsLoading:_reloading
                                             currentPage:_currentPage];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([[[IAPHelper sharedHelper]products]count]>[indexPath row]) {
        //不处理单击事件
    } else {
        //加载更多
        _currentPage++;
        [self reloadTableViewDataSource];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_1 requestCode:0 data:nil];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)reloadTableViewDataSource {
	if([[Config Instance]isLogin]) {
        _reloading = YES;
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:@"3"  forKey:@"type"];
        [requestParams setObject:PRODUCTRECORDNO_STRING  forKey:@"productrecordno"];
        [requestParams setObject:@"1"  forKey:@"status"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",PAGESIZE]  forKey:@"pagesize"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"currentpage"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest loginhandle:@"v4QrycomboList" requestParams:requestParams];
    }else{
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}
@end
