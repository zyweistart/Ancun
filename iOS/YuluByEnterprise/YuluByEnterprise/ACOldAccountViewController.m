#import "ACOldAccountViewController.h"
#import "ACOldAccountMonthCell.h"
#import "ACOldAccountDayViewController.h"
#ifdef JAILBREAK
#import "ACRechargeViewController.h"
#else
#import "ACRechargeByAppStoreViewController.h"
#endif
#import "DataSingleton.h"
#import "NSString+Date.h"
#import "ACAccountViewController.h"

#define CACHE_OLDACCOUNT_MONTH CACHE_CONSTANT(@"CACHE_OLDACCOUNT_MONTH")

#define REFRESHUSERINFOREQUESTCODE 10000001

@interface ACOldAccountViewController ()

@end

@implementation ACOldAccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    if (self) {
        
        self.navigationItem.title=@"我的账户";
        self.tabBarItem.title = @"我的账户";
        self.tabBarItem.image = [UIImage imageNamed:@"nav_icon_account"];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 70)];
        [view setBackgroundColor:[UIColor colorWithRed:(231/255.0) green:(231/255.0) blue:(231/255.0) alpha:1]];
        
        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(8, 10, 120, 30)];
        [lbl1 setFont:[UIFont systemFontOfSize:17]];
        [lbl1 setBackgroundColor:[UIColor colorWithRed:(231/255.0) green:(231/255.0) blue:(231/255.0) alpha:1]];
        [lbl1 setTextColor:[UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(102/255.0) alpha:1]];
        [lbl1 setText:@"可用录音时长:"];
        [view addSubview:lbl1];
        
        _lblTimeLong=[[UILabel alloc]initWithFrame:CGRectMake(130, 10, 150, 30)];
        [_lblTimeLong setFont:[UIFont systemFontOfSize:17]];
        [_lblTimeLong setBackgroundColor:[UIColor colorWithRed:(231/255.0) green:(231/255.0) blue:(231/255.0) alpha:1]];
        [_lblTimeLong setTextColor:[UIColor colorWithRed:(239/255.0) green:(126/255.0) blue:(7/255.0) alpha:1]];
        [_lblTimeLong setText:[NSString stringWithFormat:@"%d分钟",[[[[Config Instance]userInfo]objectForKey:@"rectime"]intValue]/60]];
        [view addSubview:_lblTimeLong];
        #ifdef JAILBREAK
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"充值" style:UIBarButtonItemStyleDone target:self action:@selector(onPay:)];
        #endif
        
        [self.view addSubview:view];
        
        self.tableView=[[UITableView alloc]initWithFrame:
                        CGRectMake(0, 50,
                                   self.view.frame.size.width,
                                   self.view.frame.size.height-50)];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [[Config Instance] setIsRefreshOldAccountMonthList:YES];
    //读取使用记录缓存信息
    NSMutableDictionary *dictioanry=[Common getCache:[Config Instance].cacheKey];
    if(dictioanry){
        id content=[dictioanry objectForKey:CACHE_OLDACCOUNT_MONTH];
        if(content){
            self.dataItemArray=[[XML analysis:content] dataItemArray];
            if([self.dataItemArray count]>0){
                [self.tableView reloadData];
                [[Config Instance] setIsRefreshOldAccountMonthList:NO];
            }
        }
    }
    
}

- (void)onPay:(id)sender {
#ifdef JAILBREAK
    ACRechargeViewController *rechargeViewController=[[ACRechargeViewController alloc] init];
    rechargeViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rechargeViewController animated:YES];
#else
    ACRechargeByAppStoreViewController *rechargeByAppStoreViewController=[[ACRechargeByAppStoreViewController alloc] init];
    rechargeByAppStoreViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rechargeByAppStoreViewController animated:YES];
#endif
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([[Config Instance]isOldUser]) {
        if([[Config Instance]isRefreshUserInfo]) {
            //更新账户信息
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:@"1" forKey:@"raflag"];
            _loadHttp=[[HttpRequest alloc]init];
            [_loadHttp setDelegate:self];
            [_loadHttp setController:self];
            [_loadHttp setIsShowMessage:YES];
            [_loadHttp setRequestCode:REFRESHUSERINFOREQUESTCODE];
            [_loadHttp loginhandle:@"v4infoGet" requestParams:requestParams];
        }
        if([[Config Instance] isRefreshOldAccountMonthList]){
            [self autoRefresh];
        }
    } else {
        //如果为新用户则直接进行跳转
        [self.navigationController pushViewController:[[ACAccountViewController alloc]init] animated:NO];
    }
}

#pragma mark -
#pragma mark Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_1 requestCode:0 data:nil];
    }
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        if (reqCode==REFRESHUSERINFOREQUESTCODE) {
            if([response successFlag]) {
                //更新用户信息
                NSMutableDictionary *dics=[[response mainData] objectForKey:@"v4info"];
                for(NSString *key in dics){
                    [[[Config Instance] userInfo]setValue:[dics objectForKey:key] forKey:key];
                }
                //刷新所用时长
                [_lblTimeLong setText:[NSString stringWithFormat:@"%d分钟",[[[[Config Instance]userInfo]objectForKey:@"rectime"]intValue]/60]];
                [[Config Instance]setIsRefreshUserInfo:NO];
                if(![[Config Instance]isOldUser]) {
                    //如果为新用户则直接进行跳转
                    [self.navigationController pushViewController:[[ACAccountViewController alloc]init] animated:NO];
                }
            }
        } else {
            [super requestFinishedByResponse:response requestCode:reqCode];
            [[Config Instance]setIsRefreshOldAccountMonthList:NO];
            if([[response code]isEqualToString:@"110042"]||_currentPage==1){
                NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithDictionary:[Common getCache:[Config Instance].cacheKey]];
                [dictionary setObject:[response responseString] forKey:CACHE_OLDACCOUNT_MONTH];
                //缓存数据
                [Common setCache:[Config Instance].cacheKey data:dictionary];
            }
        }
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
        return 65;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *oldAccountCell=@"oldAccountCell";
    //获取当前的行
    NSInteger row=[indexPath row];
    if([self.dataItemArray count]>row){
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        ACOldAccountMonthCell *cell = [self.tableView dequeueReusableCellWithIdentifier:oldAccountCell];
        if(!cell) {
            cell = [[ACOldAccountMonthCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oldAccountCell];
        }
        
        [cell.lblMonth setText:[NSString stringWithFormat:@"%@月",[[dictionary objectForKey:@"tmonth"] substringWithRange:NSMakeRange(5,2)]]];
        
        int inamount=[[dictionary objectForKey:@"inamount"]intValue];
        [cell.lblPayTime setText:[NSString stringWithFormat:@"%d分钟",inamount/60]];
        
        int onamount=[[dictionary objectForKey:@"onamount"]intValue];
        [cell.lblUseTime setText:[NSString stringWithFormat:@"%d分钟",onamount/60]];
        
        return cell;
    }else{
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:_loadOver andIsLoading:_reloading
                                             currentPage:_currentPage];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row=[indexPath row];
    if([self.dataItemArray count]>row){
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        [self.navigationController pushViewController:[[ACOldAccountDayViewController alloc] initWithDate:[dictionary objectForKey:@"tmonth"]] animated:YES];
    }else{
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
        [requestParams setObject:@"" forKey:@"changetimeb"];
        [requestParams setObject:@"" forKey:@"changetimee"];
        [requestParams setObject:@"" forKey:@"ordersort"];
        _loadHttp=[[HttpRequest alloc]init];
        [_loadHttp setDelegate:self];
        [_loadHttp setController:self];
        [_loadHttp loginhandle:@"v4accStat" requestParams:requestParams];
    }else{
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

@end