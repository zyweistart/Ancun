#import "ACOldAccountDayViewController.h"
#import "ACOldAccountDayCell.h"
#import "DataSingleton.h"
#import "NSString+Date.h"

#define CACHE_OLDACCOUNT_DAY CACHE_CONSTANT(@"CACHE_OLDACCOUNT_DAY")

@interface ACOldAccountDayViewController ()

@end

@implementation ACOldAccountDayViewController

- (id)initWithDate:(NSString *)date{
    
    if (self) {

        _year=[[date substringWithRange:NSMakeRange(0,4)]intValue];
        _month=[date substringWithRange:NSMakeRange(5,2)];
        
        self.navigationItem.title=[NSString stringWithFormat:@"%d年%@月消费明细",_year,_month];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        [view setBackgroundColor:[UIColor colorWithRed:(202/255.0) green:(206/255.0) blue:(220/255.0) alpha:1]];
        
        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(50, 10, 35, 30)];
        [lbl1 setFont:[UIFont systemFontOfSize:17]];
        [lbl1 setBackgroundColor:[UIColor colorWithRed:(202/255.0) green:(206/255.0) blue:(220/255.0) alpha:1]];
        [lbl1 setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [lbl1 setText:@"时间"];
        [view addSubview:lbl1];
        
        lbl1=[[UILabel alloc]initWithFrame:CGRectMake(150, 10, 35, 30)];
        [lbl1 setFont:[UIFont systemFontOfSize:17]];
        [lbl1 setBackgroundColor:[UIColor colorWithRed:(202/255.0) green:(206/255.0) blue:(220/255.0) alpha:1]];
        [lbl1 setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [lbl1 setText:@"类别"];
        [view addSubview:lbl1];
        
        lbl1=[[UILabel alloc]initWithFrame:CGRectMake(235, 10, 35, 30)];
        [lbl1 setFont:[UIFont systemFontOfSize:17]];
        [lbl1 setBackgroundColor:[UIColor colorWithRed:(202/255.0) green:(206/255.0) blue:(220/255.0) alpha:1]];
        [lbl1 setTextColor:[UIColor colorWithRed:(76/255.0) green:(86/255.0) blue:(108/255.0) alpha:1]];
        [lbl1 setText:@"时长"];
        [view addSubview:lbl1];
        
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
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //读取使用记录缓存信息
    NSMutableDictionary *dictioanry=[Common getCache:[Config Instance].cacheKey];
    if(dictioanry){
        id content=[dictioanry objectForKey:[NSString stringWithFormat:@"%d%@-%@",_year,_month,CACHE_OLDACCOUNT_DAY]];
        if(content){
            self.dataItemArray=[[XML analysis:content] dataItemArray];
            if([self.dataItemArray count]>0) {
                [self.tableView reloadData];
            }
        }
    }
    
}

//表视图委托
#pragma mark -
#pragma mark table view data source methods

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!self.dataItemArray||[self.dataItemArray count]==0){
        [self autoRefresh];
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
    [super requestFinishedByResponse:response requestCode:reqCode];
    if([response successFlag]){
        if([[response code]isEqualToString:@"110042"]||_currentPage==1){
            NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithDictionary:[Common getCache:[Config Instance].cacheKey]];
            [dictionary setObject:[response responseString] forKey:[NSString stringWithFormat:@"%d%@-%@",_year,_month,CACHE_OLDACCOUNT_DAY]];
            //缓存数据
            [Common setCache:[Config Instance].cacheKey data:dictionary];
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
        return 60;
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
        ACOldAccountDayCell *cell = [self.tableView dequeueReusableCellWithIdentifier:oldAccountCell];
        if(!cell) {
            cell = [[ACOldAccountDayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:oldAccountCell];
        }
        NSString *changetime=[dictionary objectForKey:@"changetime"];
        [cell.lblMonth setText:[NSString stringWithFormat:@"%@号",[changetime substringWithRange:NSMakeRange(5, 2)]]];
        [cell.lblTime setText:[changetime substringWithRange:NSMakeRange(11, 5)]];
        int fundflow=[[dictionary objectForKey:@"fundflow"]intValue];
        int changeamount=[[dictionary objectForKey:@"changeamount"]intValue];
        if(fundflow==1) {
            [cell.lblRemark setText:@"充值"];
            [cell.lblValue setText:[NSString stringWithFormat:@"+%d分钟",changeamount/60]];
        } else {
            [cell.lblRemark setText:@"录音"];
            [cell.lblValue setText:[NSString stringWithFormat:@"-%d分钟",changeamount/60]];
        }
        return cell;
    }else{
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:_loadOver andIsLoading:_reloading
                                             currentPage:_currentPage];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataItemArray count]>[indexPath indexAtPosition:1]){
        //不处理单击事件
    }else{
        //加载更多
        _currentPage++;
        [self reloadTableViewDataSource];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)reloadTableViewDataSource{
	if([[Config Instance]isLogin]){
        _reloading = YES;
        [self.tableView reloadData];
        
        int day=31;
        switch ([_month intValue]) {
            case 4:
            case 6:
            case 9:
            case 11:
                day=30;
                break;
            case 2:
                if(_year%400==0||(_year/4==0&&_year%100!=0)){
                    day=29;
                } else {
                    day=28;
                }
                break;
        }
        NSString *startday=[NSString stringWithFormat:@"%d%@01000000",_year,_month];
        NSString *endday=[NSString stringWithFormat:@"%d%@%d235959",_year,_month,day];
        
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:startday forKey:@"changetimeb"];
        [requestParams setObject:endday forKey:@"changetimee"];
        _loadHttp=[[HttpRequest alloc]init];
        [_loadHttp setDelegate:self];
        [_loadHttp setController:self];
        [_loadHttp loginhandle:@"v4accDetail" requestParams:requestParams];
    }else{
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

@end