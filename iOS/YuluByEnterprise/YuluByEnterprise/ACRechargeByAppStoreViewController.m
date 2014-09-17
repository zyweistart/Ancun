#import "ACRechargeByAppStoreViewController.h"
#import "MBProgressHUD.h"
#import "ACRechargeNav.h"
#import "ACAccountRechargeCell.h"
#import "DataSingleton.h"
#import "NSString+Date.h"
#import "IAPHelper.h"
#import "ACPaymentCell.h"

#ifdef  TEST
    #define PRODUCTRECORDNO_STRING @"1dc3838c3c2c9ce5a1fe54f9b6cf5bb9"
#else
    #define PRODUCTRECORDNO_STRING @"204ed4c44295be11e76887ea05a959ff"
#endif

#define CACHE_ACCOUNT_PAY1 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY1")
#define CACHE_ACCOUNT_PAY2 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY2")
#define CACHE_ACCOUNT_PAY3 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY3")

@interface ACRechargeByAppStoreViewController ()

@end

@implementation ACRechargeByAppStoreViewController {
    
    BOOL isTimeout;
    MBProgressHUD *_hud;
    ACRechargeNav *_rechargeNav;
    HttpRequest *_loadHttp;
    SKProductsRequest *_productsRequest;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self) {
        
        self.navigationItem.title=@"账户充值";
        
        _rechargeNav=[[ACRechargeNav alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [_rechargeNav firstStep];
        [self.view addSubview:_rechargeNav];
        
        self.tableView=[[UITableView alloc]initWithFrame:
                        CGRectMake(0, 40,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height-40)];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
        if(_refreshHeaderView==nil){
            EGORefreshTableHeaderView *view=[[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
            view.delegate = self;
            [self.tableView addSubview:view];
            _refreshHeaderView = view;
        }
        [_refreshHeaderView refreshLastUpdatedDate];
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([[IAPHelper sharedHelper].products count]>0) {
        [self.tableView reloadData];
    } else {
        [self autoRefresh];
    }
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]) {
        if(reqCode==REQUESTCODE_BUY_LOADPRODUCT) {
            //判断是否已经全部加载完毕
            if([response pageInfo]) {
                //列表查询没有使用分页
                NSInteger totalpage=[[[response pageInfo]objectForKey:@"totalpage"]intValue];
                if(totalpage>=_currentPage) {
                    if(totalpage==_currentPage) {
                        _loadOver=YES;
                    }else{
                        _loadOver=NO;
                    }
                    if(_currentPage==1) {
                        //如果当前为第一页则全部加入
                        if(self.dataItemArray) {
                            [self.dataItemArray removeAllObjects];
                            [self.dataItemArray addObjectsFromArray:[[NSMutableArray alloc]initWithArray:[response dataItemArray]]];
                            
                        } else {
                            self.dataItemArray=[[NSMutableArray alloc]initWithArray:[response dataItemArray]];
                        }
                    } else {
                        //追加到最后面
                        [self.dataItemArray addObjectsFromArray:[[NSMutableArray alloc]initWithArray:[response dataItemArray]]];
                    }
                } else {
                    _currentPage=totalpage;
                    _loadOver=YES;
                }
                if(!self.dataItemArray) {
                    self.dataItemArray=[[NSMutableArray alloc]init];
                }
            } else {
                self.dataItemArray=[[NSMutableArray alloc]initWithArray:[response dataItemArray]];
            }
            if([self.dataItemArray count]==0) {
                _currentPage=0;
                _loadOver=YES;
            }
            
            [[IAPHelper sharedHelper] setProductlist:self.dataItemArray];
            if(_productsRequest==nil) {
                NSMutableSet * products = [NSMutableSet set];
                for (NSMutableDictionary *product in self.dataItemArray) {
                    NSString *productId=[product objectForKey:@"appstorerecordno"];
                    if(![@"" isEqualToString:productId]) {
                        [products addObject:productId];
                    }
                }
                _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:products];
                _productsRequest.delegate = self;
                [_productsRequest start];
                //等待30s超时
                isTimeout=YES;
                [self performSelector:@selector(timeout:) withObject:nil afterDelay:30.0];
            } else {
                [self doneLoadingTableViewData];
                [self.tableView reloadData];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    int count=[[[IAPHelper sharedHelper]products]count];
    if(count>0){
        if(_pageSize>count){
            return count;
        }else{
            return count+1;
        }
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[[IAPHelper sharedHelper]products]count]>[indexPath row]){
        return 85;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=[indexPath row];
    int count=[[[IAPHelper sharedHelper]products]count];
    if(count>row) {
        static NSString *cellReuseIdentifier = @"ACPaymentCell";
        ACPaymentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if(cell==nil) {
            cell = [[ACPaymentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        SKProduct *product = [[IAPHelper sharedHelper].products objectAtIndex:row];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numberFormatter setLocale:product.priceLocale];
        NSString *formattedString = [numberFormatter stringFromNumber:product.price];
        cell.lblName.text=[NSString stringWithFormat:@"%@ %@",product.localizedTitle,formattedString];
        cell.lblDescription.text=product.localizedDescription;
        for (NSMutableDictionary * dictionary in [[IAPHelper sharedHelper]productlist]){
            if([product.productIdentifier isEqualToString:[dictionary objectForKey:@"appstorerecordno"]]){
                int type=[[dictionary objectForKey:@"type"] intValue];
                if(type==1) {
                    //存储
                    type=3;
                } else if(type==2) {
                    //时长
                    type=2;
                } else if(type==3) {
                    //基础
                    type=1;
                }
                [cell setCurrentType:type];
                [cell setData:dictionary];
                [cell setControler:self];
                return cell;
            }
        }
        return nil;
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
        [self.tableView reloadData];
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:PRODUCTRECORDNO_STRING  forKey:@"productrecordno"];
        //只支持基础服务套餐版
        [requestParams setObject:@"3"  forKey:@"type"];
        [requestParams setObject:@"1"  forKey:@"status"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_pageSize]  forKey:@"pagesize"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"currentpage"];
        _loadHttp=[[HttpRequest alloc]init];
        [_loadHttp setDelegate:self];
        [_loadHttp setController:self];
        [_loadHttp setRequestCode:REQUESTCODE_BUY_LOADPRODUCT];
        [_loadHttp loginhandle:@"v4QrycomboList" requestParams:requestParams];
    }else{
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    [[IAPHelper sharedHelper] setProducts:response.products];
    _productsRequest = nil;
    isTimeout=NO;
    [self dismissHUD:nil];
}

//超时提示
- (void)timeout:(id)arg {
    if(isTimeout) {
        [[IAPHelper sharedHelper] setProducts:nil];
        _productsRequest = nil;
        isTimeout=NO;
        _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        _hud.labelText = @"请求超时，请稍候在试.";
        _hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
        _hud.mode = MBProgressHUDModeCustomView;
        [self performSelector:@selector(dismissHUD:) withObject:nil afterDelay:3.0];
    }
}

- (void)dismissHUD:(id)arg{
    if(_hud!=nil) {
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        _hud = nil;
    }
    [self doneLoadingTableViewData];
    [self.tableView reloadData];
}

@end