#import "ACRecordingManagerViewController.h"
#import "ACRecordingManagerDetailListViewController.h"
#import "ACRecordingManagerDetailListOldViewController.h"
#import "ACRecordingCell.h"
#import "ACRecording2Cell.h"
#import "DataSingleton.h"

@interface ACRecordingManagerViewController ()

@end

@implementation ACRecordingManagerViewController {
    HttpRequest *_loadDataHttp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.navigationItem.title=@"我的录音";
        
        self.tabBarItem.title = @"我的录音";
        self.tabBarItem.image = [UIImage imageNamed:@"nav_icon_recording"];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshed:) name:Notification_TabClick_ACRecordingManagerViewController object:nil];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataItemArray=[Common getCacheXmlByList:CACHE_DATA];
    if(self.dataItemArray==nil){
        [[Config Instance]setIsRefreshRecordingList:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(self.navigationItem.rightBarButtonItem==nil) {
        if([[[[Config Instance]userInfo]objectForKey:@"oldflag"]intValue]==1) {
            self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"时长版录音" style:UIBarButtonItemStyleDone target:self action:@selector(oldRecordingManagerList:)];
        }
    }
    //如果为nil或者集合长度为零则自动刷新
    if([[Config Instance]isRefreshRecordingList]) {
        [self autoRefresh];
    }
}

#pragma mark -
#pragma mark Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int row=[indexPath row];
    if([self.dataItemArray count]>row) {
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        NSString *oppno=[dictionary objectForKey:@"oppno"];
        NSString* name=[[[Config Instance]contact] objectForKey:oppno];
        if(name==nil||[name isEqualToString:oppno]) {
            return 60;
        } else {
            return 75;
        }
    } else {
        return 50;
    }
}

static NSString *cellReuseIdentifier=@"ACRecordingCellIdentifier";
static NSString *cell2ReuseIdentifier=@"ACRecording2CellIdentifier";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row=[indexPath row];
    if([self.dataItemArray count]>row) {
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        NSString *oppno=[dictionary objectForKey:@"oppno"];
        NSString* name=[[[Config Instance]contact] objectForKey:oppno];
        if(name==nil||[oppno isEqualToString:name]) {
            ACRecordingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
            if(!cell){          
                cell = [[ACRecordingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
            }
            cell.lblOppno.text=[dictionary objectForKey:@"oppno"];
            cell.lblLcalltime.text=[[dictionary objectForKey:@"lcalltime"] substringWithRange:NSMakeRange(0, 10)];
            cell.lblOrttime.text=[[NSString alloc]initWithFormat:@"%@",[Common secondConvertFormatTimerByCn:[dictionary objectForKey:@"onrttime"]]];
            cell.lblRtcount.text=[[NSString alloc]initWithFormat:@"%@个录音",[dictionary objectForKey:@"onrtcount"]];
            cell.selectionStyle = UITableViewCellSelectionStyleBlue;
            return cell;
        } else {
            ACRecording2Cell *cell2 = [self.tableView dequeueReusableCellWithIdentifier:cell2ReuseIdentifier];
            if(!cell2) {
                cell2 = [[ACRecording2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cell2ReuseIdentifier];
            }
            cell2.lblName.text=name;
            cell2.lblOppno.text=[dictionary objectForKey:@"oppno"];
            cell2.lblLcalltime.text=[[dictionary objectForKey:@"lcalltime"] substringWithRange:NSMakeRange(0, 10)];
            cell2.lblOrttime.text=[[NSString alloc]initWithFormat:@"%@",[Common secondConvertFormatTimerByCn:[dictionary objectForKey:@"onrttime"] ]];
            cell2.lblRtcount.text=[[NSString alloc]initWithFormat:@"%@个录音",[dictionary objectForKey:@"onrtcount"]];
            cell2.selectionStyle = UITableViewCellSelectionStyleBlue;
            return cell2;
        }
    } else {
        return [[DataSingleton Instance] getLoadMoreCell:tableView andIsLoadOver:_loadOver andIsLoading:_reloading
                                      currentPage:_currentPage];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if([self.dataItemArray count]>[indexPath indexAtPosition:1]) {
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:[indexPath row]];
        if(dictionary) {
            ACRecordingManagerDetailListViewController* recordingManagerDetailListViewController=[[ACRecordingManagerDetailListViewController alloc] initWithOppno:[dictionary objectForKey:@"oppno"]];
            recordingManagerDetailListViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:recordingManagerDetailListViewController animated:YES];
        }
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

- (void)refreshed:(NSNotification *)notification {
    if (notification.object){
        if ([(NSString *)notification.object isEqualToString:@"load"]) {
            [self autoRefresh];
        }
    }
}

//导航至原时长版录音数据
- (void)oldRecordingManagerList:(id)sender {
    ACRecordingManagerDetailListOldViewController* recordingManagerDetailListOldViewController=[[ACRecordingManagerDetailListOldViewController alloc] init];
    recordingManagerDetailListOldViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordingManagerDetailListOldViewController animated:YES];
}

- (void)reloadTableViewDataSource {
    
	if([[Config Instance]isLogin]) {
        if([[Config Instance]isAuth:auth_4recqry1]){
            _reloading = YES;
            [self.tableView reloadData];
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:@"" forKey:@"oppno"];
            [requestParams setObject:@"" forKey:@"begintime"];
            [requestParams setObject:@"" forKey:@"endtime"];
            [requestParams setObject:@"desc" forKey:@"ordersort"];
            [requestParams setObject:[NSString stringWithFormat: @"%d",_pageSize]  forKey:@"pagesize"];
            [requestParams setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"currentpage"];
            _loadDataHttp=[[HttpRequest alloc]init];
            [_loadDataHttp setDelegate:self];
            [_loadDataHttp setController:self];
            [_loadDataHttp loginhandle:@"v4recStat" requestParams:requestParams];
        }else{
            [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
            [Common alert:@"暂无权限"];
        }
    } else {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

@end
