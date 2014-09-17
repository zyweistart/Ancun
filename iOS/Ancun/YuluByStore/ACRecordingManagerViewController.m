#import "ACRecordingManagerViewController.h"
#import "ACRecordingManagerDetailListViewController.h"
#import "ACRecordingCell.h"
#import "ACRecording2Cell.h"
#import "DataSingleton.h"

@interface ACRecordingManagerViewController ()

@end

@implementation ACRecordingManagerViewController

- (id)init {
    self = [super init];
    if (self) {
        
        self.title=@"我的录音";
        
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
        
        if([[[[Config Instance]userInfo]objectForKey:@"oldflag"]intValue]==1) {
            [dictionary setObject:[dictionary objectForKey:@"nrttime"] forKey:@"onrttime"];
            [dictionary setObject:[dictionary objectForKey:@"nrtcount"] forKey:@"onrtcount"];
        }
        
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

- (void)reloadTableViewDataSource {
	if([[Config Instance]isLogin]) {
        _reloading = YES;
        [self.tableView reloadData];
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:@"" forKey:@"oppno"];
        [requestParams setObject:@"" forKey:@"begintime"];
        [requestParams setObject:@"" forKey:@"endtime"];
        [requestParams setObject:@"desc" forKey:@"ordersort"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",PAGESIZE]  forKey:@"pagesize"];
        [requestParams setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"currentpage"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        //如果是从老用户转过来则查询新接口
        if([[[[Config Instance]userInfo]objectForKey:@"oldflag"]intValue]==1) {
            [self.hRequest loginhandle:@"v4recStatn" requestParams:requestParams];
        }else{
            [self.hRequest loginhandle:@"v4recStat" requestParams:requestParams];
        }
    } else {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

@end