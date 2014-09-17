#import "ACRechargeViewController.h"
#import "ACRechargeNav.h"
#import "ACAccountRechargeCell.h"
#import "DataSingleton.h"
#import "NSString+Date.h"

#ifdef  TEST
    #define PRODUCTRECORDNO_STRING @"8f13597db224df927b4a02658326ca39"
#else
    #define PRODUCTRECORDNO_STRING @"ac9d9d16706af24455b5834eec56d2d5"
#endif

#define CACHE_ACCOUNT_PAY1 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY1")
#define CACHE_ACCOUNT_PAY2 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY2")
#define CACHE_ACCOUNT_PAY3 CACHE_CONSTANT(@"CACHE_ACCOUNT_PAY3")

@interface ACRechargeViewController ()

//界面按钮事件
- (void)leftTopButtonAction;
- (void)centerTopButtonAction;
- (void)rightTopButtonAction;

@end

@implementation ACRechargeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self) {
        
        self.navigationItem.title=@"账户充值";
        
        _rechargeNav=[[ACRechargeNav alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [_rechargeNav firstStep];
        [self.view addSubview:_rechargeNav];
        
        _leftTopTab=[[UIButton alloc]initWithFrame:CGRectMake(0, 40, 106, 40)];
        [_leftTopTab.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_leftTopTab setTitle:@"基础服务套餐" forState:UIControlStateNormal];
        [_leftTopTab setBackgroundColor:[UIColor colorWithRed:(44/255.0) green:(140/255.0) blue:(207/255.0) alpha:1]];
        [self.view addSubview:_leftTopTab];
        
        _centerTopTab=[[UIButton alloc]initWithFrame:CGRectMake(107, 40, 106, 40)];
        [_centerTopTab.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_centerTopTab setTitle:@"增值时长套餐" forState:UIControlStateNormal];
        [_centerTopTab setBackgroundColor:[UIColor colorWithRed:(44/255.0) green:(140/255.0) blue:(207/255.0) alpha:1]];
        [self.view addSubview:_centerTopTab];
        
        _rightTopTab=[[UIButton alloc]initWithFrame:CGRectMake(214, 40, 106, 40)];
        [_rightTopTab.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_rightTopTab setTitle:@"增值存储套餐" forState:UIControlStateNormal];
        [_rightTopTab setBackgroundColor:[UIColor colorWithRed:(44/255.0) green:(140/255.0) blue:(207/255.0) alpha:1]];
        [self.view addSubview:_rightTopTab];
        
        _lblSlid=[[UILabel alloc]initWithFrame:CGRectMake(0, 76, 106, 4)];
        [_lblSlid setBackgroundColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [self.view addSubview:_lblSlid];
        
        _leftTopTab.showsTouchWhenHighlighted = YES;//指定按钮被按下时发光
        [_leftTopTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
        [_leftTopTab addTarget:self action:@selector(leftTopButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        _centerTopTab.showsTouchWhenHighlighted = YES;//指定按钮被按下时发光
        [_centerTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
        [_centerTopTab addTarget:self action:@selector(centerTopButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        _rightTopTab.showsTouchWhenHighlighted = YES;//指定按钮被按下时发光
        [_rightTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
        [_rightTopTab addTarget:self action:@selector(rightTopButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        self.tableView=[[UITableView alloc]initWithFrame:
                        CGRectMake(0, 80,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height-80)];
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
    
    //初始化数据
    currentTab=1;
    //左
    _leftCurrentPage=_currentPage;
    _leftReloading=_reloading;
    _leftLoadOver=_loadOver;
    //中
    _centerCurrentPage=_currentPage;
    _centerReloading=_reloading;
    _centerLoadOver=_loadOver;
    //右
    _rightCurrentPage=_currentPage;
    _rightReloading=_reloading;
    _rightLoadOver=_loadOver;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //读取使用记录缓存信息
    NSMutableDictionary *dictioanry=[Common getCache:[Config Instance].cacheKey];
    if(dictioanry){
        id content=[dictioanry objectForKey:CACHE_ACCOUNT_PAY1];
        if(content){
            _leftDataItemArray=[[XML analysis:content] dataItemArray];
            if([_leftDataItemArray count]>0){
                self.dataItemArray=_leftDataItemArray;
                [self.tableView reloadData];
            }
        }
        content=[dictioanry objectForKey:CACHE_ACCOUNT_PAY2];
        if(content){
            _centerDataItemArray=[[XML analysis:content] dataItemArray];
        }
        content=[dictioanry objectForKey:CACHE_ACCOUNT_PAY3];
        if(content){
            _rightDataItemArray=[[XML analysis:content] dataItemArray];
        }
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //如果为nil则自动加载
    if(_leftDataItemArray==nil) {
        [self autoRefresh];
    }
}

#pragma mark-
#pragma mark 界面按钮事件

- (void)leftTopButtonAction {
    currentTab=1;
    
    _currentPage=_leftCurrentPage;
    _reloading=_leftReloading;
    _loadOver=_leftLoadOver;
    self.dataItemArray=_leftDataItemArray;
    if([_leftDataItemArray count]>0) {
        [self.tableView reloadData];
    } else {
        [self autoRefresh];
    }
    
    [_leftTopTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [_centerTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    [_rightTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    _lblSlid.frame = CGRectMake(0, 76, 106, 4);
    
    [UIView commitAnimations];
}

- (void)centerTopButtonAction {
    currentTab=2;
    
    _currentPage=_centerCurrentPage;
    _reloading=_centerReloading;
    _loadOver=_centerLoadOver;
    self.dataItemArray=_centerDataItemArray;
    if([_centerDataItemArray count]>0){
        [self.tableView reloadData];
    }else{
        [self autoRefresh];
    }
    
    [_centerTopTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [_leftTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    [_rightTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    _lblSlid.frame = CGRectMake(107, 76, 106, 4);
    
    [UIView commitAnimations];
}

- (void)rightTopButtonAction {
    currentTab=3;
    
    _currentPage=_rightCurrentPage;
    _reloading=_rightReloading;
    _loadOver=_rightLoadOver;
    self.dataItemArray=_rightDataItemArray;
    if([_rightDataItemArray count]>0){
        [self.tableView reloadData];
    }else{
        [self autoRefresh];
    }
    
    [_rightTopTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//此时选中
    [_leftTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    [_centerTopTab setTitleColor:[UIColor colorWithRed:(220/255.0) green:(220/255.0) blue:(220/255.0) alpha:1] forState:UIControlStateNormal];//此时未被选中
    
    [UIView beginAnimations:nil context:nil];//动画开始
    [UIView setAnimationDuration:0.3];
    
    _lblSlid.frame = CGRectMake(214, 76, 106, 4);
    
    [UIView commitAnimations];
}

#pragma mark -
#pragma mark Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_1 requestCode:0 data:nil];
    }
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    [super requestFinishedByResponse:response requestCode:reqCode];
    if([[response code]isEqualToString:@"140021"]||_currentPage==1) {
        NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithDictionary:[Common getCache:[Config Instance].cacheKey]];
        if(currentTab == 1) {
            [dictionary setObject:[response responseString] forKey:CACHE_ACCOUNT_PAY1];
        } else if(currentTab == 2) {
            [dictionary setObject:[response responseString] forKey:CACHE_ACCOUNT_PAY2];
        } else if(currentTab == 3) {
            [dictionary setObject:[response responseString] forKey:CACHE_ACCOUNT_PAY3];
        }
        //缓存数据
        [Common setCache:[Config Instance].cacheKey data:dictionary];
        if([[response code]isEqualToString:@"140021"]) {
            self.dataItemArray=nil;
            [self.tableView reloadData];
        }
    }
    if(currentTab == 1) {
        _leftCurrentPage=_currentPage;
        _leftReloading=_reloading;
        _leftLoadOver=_loadOver;
        _leftDataItemArray=self.dataItemArray;
    } else if(currentTab == 2) {
        _centerCurrentPage=_currentPage;
        _centerReloading=_reloading;
        _centerLoadOver=_loadOver;
        _centerDataItemArray=self.dataItemArray;
    } else if(currentTab == 3) {
        _rightCurrentPage=_currentPage;
        _rightReloading=_reloading;
        _rightLoadOver=_loadOver;
        _rightDataItemArray=self.dataItemArray;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([self.dataItemArray count]>0){
        if(_pageSize>[self.dataItemArray count]){
            return [self.dataItemArray count];
        }else{
            return [self.dataItemArray count]+1;
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
    static NSString *accountPayCell2=@"ACAccountRechargeCell2";
    //获取当前的行
    NSInteger row=[indexPath row];
    if([self.dataItemArray count]>row) {
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        ACAccountRechargeCell *cell;
        if(currentTab==1) {
            cell = [self.tableView dequeueReusableCellWithIdentifier:accountPayCell1];
            if(!cell) {
                cell = [[ACAccountRechargeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountPayCell1];
            }
            [cell.lblTimeLong setText:[NSString stringWithFormat:@"有效期%@天",[dictionary objectForKey:@"valid"]]];
            [cell.lblTime setText:[NSString stringWithFormat:@"%@分钟",[dictionary objectForKey:@"duration"]]];
            [cell.lblStorage setText:[NSString stringWithFormat:@"%@MB",[dictionary objectForKey:@"storage"]]];
        } else {
            cell = [self.tableView dequeueReusableCellWithIdentifier:accountPayCell2];
            if(!cell) {
                cell = [[ACAccountRechargeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountPayCell2];
            }
            if(currentTab ==2 ) {
                [cell.lblTimeLong setText:@"无时间限制"];
                [cell.lblTimeAndStorage setText:[NSString stringWithFormat:@"%@分钟",[dictionary objectForKey:@"duration"]]];
            } else if(currentTab==3) {
                [cell.lblTimeLong setText:[NSString stringWithFormat:@"有效期%@天",[dictionary objectForKey:@"valid"]]];
                [cell.lblTimeAndStorage setText:[NSString stringWithFormat:@"%@MB",[dictionary objectForKey:@"storage"]]];
            }
        }
        [cell.lblName setText:[dictionary objectForKey:@"name"]];
        [cell setCurrentType:currentTab];
        [cell setData:dictionary];
        [cell setControler:self];
        return cell;
    } else {
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:_loadOver andIsLoading:_reloading
                                             currentPage:_currentPage];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.dataItemArray count]>[indexPath indexAtPosition:1]) {
        //不处理单击事件
    } else {
        //加载更多
        _currentPage++;
        [self reloadTableViewDataSource];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)reloadTableViewDataSource {
	if([[Config Instance]isLogin]) {
        _reloading = YES;
        [self.tableView reloadData];
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        if(currentTab == 1) {
            [requestParams setObject:@"3"  forKey:@"type"];
        } else if (currentTab == 2){
            [requestParams setObject:@"2"  forKey:@"type"];
        } else if (currentTab == 3){
            [requestParams setObject:@"1"  forKey:@"type"];
        }
        [requestParams setObject:PRODUCTRECORDNO_STRING  forKey:@"productrecordno"];
        [requestParams setObject:@"1"  forKey:@"status"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_pageSize]  forKey:@"pagesize"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"currentpage"];
        _loadHttp=[[HttpRequest alloc]init];
        [_loadHttp setDelegate:self];
        [_loadHttp setController:self];
        [_loadHttp loginhandle:@"v4QrycomboList" requestParams:requestParams];
    }else{
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

@end