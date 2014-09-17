#import "ACUseRecordViewController.h"
#import "ACRecordingManagerDetailListViewController.h"
#import "ACRecordingManagerDetailListOldViewController.h"
#import "ACAccountUseRecordCell.h"
#import "DataSingleton.h"

@interface ACUseRecordViewController ()

@end

@implementation ACUseRecordViewController {
    HttpRequest *_loadDataHttp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationItem.title=@"使用记录";
        
        self.tabBarItem.title = @"使用记录";
        self.tabBarItem.image = [UIImage imageNamed:@"nav_icon_recording"];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataItemArray=[Common getCacheXmlByList:CACHE_DATA];
    if(self.dataItemArray==nil){
        [[Config Instance]setIsRefreshUseRecordList:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //如果为nil或者集合长度为零则自动刷新
    if([[Config Instance]isRefreshUseRecordList]) {
        [self autoRefresh];
    }
}

#pragma mark -
#pragma mark Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.dataItemArray count]>[indexPath row]){
        return 75;
    }else{
        return 50;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *accountUseRecordCell=@"ACAccountUseRecordCell";
    NSInteger row=[indexPath row];
    if([self.dataItemArray count]>row){
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        NSMutableString *strContent=[[NSMutableString alloc]init];
        int cgtype=[[dictionary objectForKey:@"cgtype"]intValue];
        int cgsubtype=[[dictionary objectForKey:@"cgsubtype"]intValue];
        if(cgtype==1){
            [strContent appendString:@"活动-"];
            if(cgsubtype==1){
                [strContent appendString:@"新手注册礼"];
            } else if(cgsubtype==2){
                [strContent appendString:@"新手体验礼"];
            } else {
                [strContent appendString:@"未知"];
            }
        } else if(cgtype==2) {
            [strContent appendString:@"套餐充值购买-"];
            if(cgsubtype==1){
                [strContent appendString:@"存储套餐"];
            } else if(cgsubtype==2){
                [strContent appendString:@"时长套餐"];
            } else if(cgsubtype==3){
                [strContent appendString:@"个人基础套餐"];
            } else {
                [strContent appendString:@"未知"];
            }
        } else if(cgtype==3) {
            [strContent appendString:@"套餐生效-"];
            if(cgsubtype==1){
                [strContent appendString:@"存储套餐"];
            }else if(cgsubtype==3){
                [strContent appendString:@"个人基础套餐"];
            } else {
                [strContent appendString:@"未知"];
            }
        } else if(cgtype==4) {
            [strContent appendString:@"套餐失效-"];
            if(cgsubtype==1){
                [strContent appendString:@"存储套餐"];
            } else if(cgsubtype==3){
                [strContent appendString:@"个人基础套餐"];
            } else if(cgsubtype==0){
                [strContent appendString:@"试用套餐"];
            }
        } else if(cgtype==5) {
            [strContent appendString:@"套餐转换-"];
            if(cgsubtype==2){
                [strContent appendString:@"时长套餐"];
            } else {
                [strContent appendString:@"未知"];
            }
        } else if(cgtype==6) {
            [strContent appendString:@"通话录音-"];
            if(cgsubtype==1){
                [strContent appendString:@"主叫录音"];
            } else if(cgsubtype==2){
                [strContent appendString:@"被叫录音"];
            } else if(cgsubtype==3){
                [strContent appendString:@"WebCall录音"];
            }  else {
                [strContent appendString:@"未知"];
            }
        } else if(cgtype==7) {
            [strContent appendString:@"录音删除-"];
            if(cgsubtype==1){
                [strContent appendString:@"主叫录音删除"];
            } else if(cgsubtype==2){
                [strContent appendString:@"被叫录音删除"];
            } else if(cgsubtype==3){
                [strContent appendString:@"WebCall录音删除"];
            }  else {
                [strContent appendString:@"未知"];
            }
        }
        
        ACAccountUseRecordCell *cell = [self.tableView dequeueReusableCellWithIdentifier:accountUseRecordCell];
        if(!cell) {
            cell = [[ACAccountUseRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountUseRecordCell];
        }
        
        [cell.lblDate setText:[dictionary objectForKey:@"cgtime"]];
        [cell.lblContent setText:strContent];
        
        int cgflag=[[dictionary objectForKey:@"cgflag"]intValue];
        int cgrectime=[[dictionary objectForKey:@"cgrectime"]floatValue];
        float cgquota=[[dictionary objectForKey:@"cgquota"]floatValue];
        NSMutableString *disStr=[[NSMutableString alloc]init];
        if(cgrectime>0){
            if(cgflag==1) {
                [disStr appendString:@"+"];
            } else {
                [disStr appendString:@"-"];
            }
            [disStr appendFormat:@"%d分钟",cgrectime/60];
            if(cgquota>0){
                [disStr appendString:@"\n"];
            }
        }
        if(cgquota>0){
            if(cgflag==1) {
                [disStr appendString:@"+"];
            } else {
                [disStr appendString:@"-"];
            }
            [disStr appendFormat:@"%0.2fMB",cgquota/1024/1024];
        }
        [cell.lblRemark setText:disStr];
        return cell;
    }else{
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex==0){
        [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_1 requestCode:0 data:nil];
    }
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode {
    [super requestFinishedByResponse:response requestCode:reqCode];
    if([response successFlag]) {
        [[Config Instance]setIsRefreshRecordingList:NO];
        if([[response code]isEqualToString:@"110042"]||_currentPage==1) {
            [Common setCacheXmlByList:[response responseString] tag:CACHE_DATA];
        }
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)reloadTableViewDataSource {
	if([[Config Instance]isLogin]) {
        _reloading = YES;
        [self.tableView reloadData];
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:@"6"  forKey:@"cgtype"];
        [requestParams setObject:@"1"  forKey:@"cgsubtype"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_pageSize]  forKey:@"pagesize"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"currentpage"];
        _loadDataHttp=[[HttpRequest alloc]init];
        [_loadDataHttp setDelegate:self];
        [_loadDataHttp setController:self];
        [_loadDataHttp loginhandle:@"v4accnewDetail" requestParams:requestParams];
        
    } else {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

@end
