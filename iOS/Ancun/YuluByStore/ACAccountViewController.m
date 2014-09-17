#import "ACAccountViewController.h"
#import "ACAccountPayCell.h"
#import "ACAccountUseRecordCell.h"
#ifdef JAILBREAK
    #import "ACRechargeByAlipayViewController.h"
#else
    #import "ACRechargeByAppStoreViewController.h"
#endif
#import "DataSingleton.h"
#import "NSString+Utils.h"

#define REFRESHUSERINFOREQUESTCODE 473281947

@interface ACAccountViewController ()

@end

@implementation ACAccountViewController {
    
    int currentTab;
    
    UIButton *_leftTopTab;
    UIButton *_rightTopTab;
    
    NSMutableArray *_leftDataItemArray;
    NSMutableArray *_rightDataItemArray;
    
}

- (id)init {
    
    UIView *container=nil;
    if(IOS7){
        container=[[UIView alloc]initWithFrame:CGRectMake(0, STATUSHEIGHT+TOPNAVIGATIONHEIGHT, self.view.frame.size.width, self.view.frame.size.height-STATUSHEIGHT-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
    }else{
        container=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
    }
    [container setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:container];
    
    int topHeight=91;
    
    self.tableView=[[UITableView alloc]initWithFrame:
                    CGRectMake(0, topHeight,
                               container.frame.size.width,
                               container.frame.size.height-topHeight)];
    [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    [container addSubview:self.tableView];
    if (_refreshHeaderView == nil) {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:
                                           CGRectMake(0.0f,
                                                      0.0f - self.tableView.bounds.size.height,
                                                      self.view.bounds.size.width,
                                                      self.tableView.bounds.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
    
    self = [super init];

    if (self) {
        
        self.title=@"我的账户";
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 15, 300, 21)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextColor:FONTCOLOR2];
        [lbl setBackgroundColor:[UIColor whiteColor]];
        [lbl setTextAlignment:NSTextAlignmentCenter];
        [lbl setText:[NSString stringWithFormat:@"当前账户：%@",[[[Config Instance]userInfo]objectForKey:@"phone"]]];
        [container addSubview:lbl];
        
        _leftTopTab=[[UIButton alloc]initWithFrame:CGRectMake(4, 51, 156, 35)];
        [_leftTopTab setTitle:@"充值套餐" forState:UIControlStateNormal];
        [_leftTopTab setBackgroundImage:[UIImage imageNamed:@"myaccountleftact"] forState:UIControlStateNormal];
        _leftTopTab.showsTouchWhenHighlighted = YES;//指定按钮被按下时发光
        [_leftTopTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_leftTopTab addTarget:self action:@selector(leftTopButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:_leftTopTab];
        
        _rightTopTab=[[UIButton alloc]initWithFrame:CGRectMake(160, 51, 156, 35)];
        [_rightTopTab setTitle:@"使用记录" forState:UIControlStateNormal];
        [_rightTopTab setBackgroundImage:[UIImage imageNamed:@"myaccountright"] forState:UIControlStateNormal];
        _rightTopTab.showsTouchWhenHighlighted = YES;//指定按钮被按下时发光
        [_rightTopTab setTitleColor:FONTCOLOR2 forState:UIControlStateNormal];
        [_rightTopTab addTarget:self action:@selector(rightTopButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:_rightTopTab];
        
        //增加充值按钮
        UIButton* goRecharge= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        [goRecharge setTitle:@"充值" forState:UIControlStateNormal];
        [goRecharge setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[goRecharge titleLabel]setFont:[UIFont systemFontOfSize:16]];
        goRecharge.layer.cornerRadius=10;
        goRecharge.layer.masksToBounds=YES;
        [goRecharge setBackgroundColor:[UIColor colorWithRed:(65/255.0) green:(194/255.0) blue:(252/255.0) alpha:1]];
        [goRecharge addTarget:self action:@selector(accountPay:) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:goRecharge]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //标记当前TAB页为第一页
    currentTab=1;
    
    //显示刷新标记
    [[Config Instance]setIsRefreshAccountPayList:YES];
    [[Config Instance]setIsRefreshAccountUseRecordList:NO];
    
    //读取使用记录缓存信息
    NSMutableDictionary *dictioanry=[Common getCache:[Config Instance].cacheKey];
    if(dictioanry){
        id content=[dictioanry objectForKey:CACHE_DATA];
        if(content){
            _rightDataItemArray=[[Common toResponseData:content] dataItemArray];
        }
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if([[Config Instance]isRefreshUserInfo]) {
        //更新账户信息
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:@"1" forKey:@"raflag"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest setRequestCode:REFRESHUSERINFOREQUESTCODE];
        [self.hRequest loginhandle:@"v4infoGet" requestParams:requestParams];
    } else {
        if(currentTab==1) {
            if([[Config Instance]isRefreshAccountPayList]) {
                [self autoRefresh];
            }
        } else if (currentTab==2) {
            if([[Config Instance]isRefreshAccountUseRecordList]) {
                [self autoRefresh];
            }
        }
    }
}

#pragma mark-
#pragma mark 界面按钮事件

- (void)accountPay:(id)sender{
    if([[Config Instance]isRefreshUserInfo]) {
        //更新账户信息
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:@"1" forKey:@"raflag"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest setRequestCode:REFRESHUSERINFOREQUESTCODE];
        [self.hRequest loginhandle:@"v4infoGet" requestParams:requestParams];
    } else if([[Config Instance]isRefreshAccountPayList]) {
        [_leftTopTab sendActionsForControlEvents:UIControlEventTouchUpInside];
    } else {
#ifdef JAILBREAK
        ACRechargeByAlipayViewController *rechargeByAlipayViewController=[[ACRechargeByAlipayViewController alloc] init];
        rechargeByAlipayViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rechargeByAlipayViewController animated:YES];
#else
        ACRechargeByAppStoreViewController *rechargeByAppStoreViewController=[[ACRechargeByAppStoreViewController alloc] init];
        rechargeByAppStoreViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:rechargeByAppStoreViewController animated:YES];
#endif
    }
}

- (void)leftTopButtonAction {
    currentTab=1;
    
    if([[Config Instance]isRefreshAccountPayList]) {
        [self autoRefresh];
        [[Config Instance] setIsRefreshAccountPayList:NO];
    } else {
        self.dataItemArray=_leftDataItemArray;
        if(_leftDataItemArray){
            [self.tableView reloadData];
        }else{
            [self autoRefresh];
        }
    }
    
    [_leftTopTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightTopTab setTitleColor:FONTCOLOR2 forState:UIControlStateNormal];
    [_leftTopTab setBackgroundImage:[UIImage imageNamed:@"myaccountleftact"] forState:UIControlStateNormal];
    [_rightTopTab setBackgroundImage:[UIImage imageNamed:@"myaccountright"] forState:UIControlStateNormal];
}

- (void)rightTopButtonAction {
    currentTab=2;
    
    self.dataItemArray=_rightDataItemArray;
    if(_rightDataItemArray){
        [self.tableView reloadData];
    }else{
        [self autoRefresh];
    }
    
    [_leftTopTab setTitleColor:FONTCOLOR2 forState:UIControlStateNormal];
    [_rightTopTab setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_leftTopTab setBackgroundImage:[UIImage imageNamed:@"myaccountleft"] forState:UIControlStateNormal];
    [_rightTopTab setBackgroundImage:[UIImage imageNamed:@"myaccountrightact"] forState:UIControlStateNormal];
}

#pragma mark -
#pragma mark Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_1 requestCode:0 data:nil];
    }
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode {
    if (reqCode==REFRESHUSERINFOREQUESTCODE) {
        if([response successFlag]) {
            //更新用户信息
            NSMutableDictionary *dics=[[response mainData] objectForKey:@"v4info"];
            for(NSString *key in dics){
                [[[Config Instance] userInfo]setValue:[dics objectForKey:key] forKey:key];
            }
            [[Config Instance]setIsRefreshUserInfo:NO];
            //重新刷新信息
            [[Config Instance] setIsRefreshAccountPayList:YES];
            [_leftTopTab sendActionsForControlEvents:UIControlEventTouchUpInside];
        }
    } else {
        [super requestFinishedByResponse:response requestCode:reqCode];
        if([response successFlag]) {
            if(currentTab == 1) {
                [[Config Instance] setIsRefreshAccountPayList:NO];
                _leftDataItemArray=self.dataItemArray;
                [[Config Instance] setCurrentPackagesList:_leftDataItemArray];
                if([_leftDataItemArray count]>0) {
                    //计算剩余套餐值
                    int basesum=0,baseuse=0,timecan=0,storsum=0;
                    for (NSMutableDictionary *data in _leftDataItemArray) {
                        int ctype=[[data objectForKey:@"ctype"]intValue];
                        //ctype(1:存储2：时长3：个人基础套餐0：试用套餐)
                        if (ctype==0||ctype==1||ctype==3) {
                            //只计算当前生效的套餐
                            NSDate *currentDate=[NSDate date];
                            NSDate *starttime = [[data objectForKey:@"starttime"] stringConvertDate];
                            NSDate *endtime = [[data objectForKey:@"endtime"] stringConvertDate];
                            if([currentDate compare:starttime]>=0&& [endtime compare:currentDate]>=0){
                                storsum+=[[data objectForKey:@"auciquotalimit"]intValue];
                                if(ctype==0||ctype==3){
                                    basesum=[[data objectForKey:@"rectimelimit"]intValue];
                                    baseuse=[[data objectForKey:@"useurectime"]intValue];
                                }
                            }
                        } else if(ctype==2) {
                            int timesum=[[data objectForKey:@"rectimelimit"]intValue];
                            int timeuse=[[data objectForKey:@"useurectime"]intValue];
                            timecan+=timesum-timeuse;
                        }
                    }
                }
                self.navigationItem.rightBarButtonItem.enabled=YES;
            }
        }
        if(currentTab == 2) {
            [[Config Instance] setIsRefreshAccountUseRecordList:NO];
            _rightDataItemArray=self.dataItemArray;
            if([[response code]isEqualToString:@"110042"]||_currentPage==1){
                NSMutableDictionary *dictionary=[NSMutableDictionary dictionaryWithDictionary:[Common getCache:[Config Instance].cacheKey]];
                [dictionary setObject:[response responseString] forKey:CACHE_DATA];
                //缓存数据
                [Common setCache:[Config Instance].cacheKey data:dictionary];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(currentTab==1) {
        return [self.dataItemArray count];
    } else {
        if([self.dataItemArray count]>0){
            if(PAGESIZE>[self.dataItemArray count]){
                return [self.dataItemArray count];
            }else{
                return [self.dataItemArray count]+1;
            }
        }else{
            return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(currentTab==1) {
        return 75;
    } else {
        if([self.dataItemArray count]>[indexPath row]){
            return 75;
        }else{
            return 50;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *accountPayCell=@"ACAccountPayCell";
    static NSString *accountUseRecordCell=@"ACAccountUseRecordCell";
    //获取当前的行
    NSInteger row=[indexPath row];
    if(currentTab==1) {
        NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
        int ctype=[[dictionary objectForKey:@"ctype"]intValue];
        ACAccountPayCell *cell = [self.tableView dequeueReusableCellWithIdentifier:accountPayCell];
        if(!cell) {
            cell = [[ACAccountPayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountPayCell];
        }
        [cell.lblName setText:[dictionary objectForKey:@"comboname"]];
        if(ctype==3){
            [cell.lblInfo setText:@"录音时长不限,提取码申请次数不限,存储有效期2年(730天)"];
        }else{
            [cell.lblInfo setText:@"60分钟/月(30天),提取码申请次数:5次/月(30天),存储有效期30天"];
        }
        [cell.lblStartTime setText:[[dictionary objectForKey:@"starttime"] substringWithRange:NSMakeRange(0, 10)]];
        [cell.lblEndTime setText:[[dictionary objectForKey:@"endtime"] substringWithRange:NSMakeRange(0, 10)]];
        return cell;
    } else {
        if([self.dataItemArray count]>row){
            NSMutableDictionary *dictionary=[self.dataItemArray objectAtIndex:row];
            NSMutableString *strContent=[[NSMutableString alloc]init];
            int cgtype=[[dictionary objectForKey:@"cgtype"]intValue];
            int cgsubtype=[[dictionary objectForKey:@"cgsubtype"]intValue];
            if(cgtype==1){
                [strContent appendString:@"活动\n"];
                if(cgsubtype==1){
                    [strContent appendString:@"新手注册礼"];
                } else if(cgsubtype==2){
                    [strContent appendString:@"新手体验礼"];
                } else {
                    [strContent appendString:@"未知"];
                }
            } else if(cgtype==2) {
                [strContent appendString:@"套餐充值购买\n"];
                if(cgsubtype==1){
                    [strContent appendString:@"存储套餐"];
                } else if(cgsubtype==2){
                    [strContent appendString:@"时长套餐"];
                } else if(cgsubtype==3){
                    [strContent appendString:@"个人基础套餐"];
                }else if(cgsubtype==9){
                    [strContent appendString:@"免费套餐"];
                } else {
                    [strContent appendString:@"未知"];
                }
            } else if(cgtype==3) {
                [strContent appendString:@"套餐生效\n"];
                if(cgsubtype==1){
                    [strContent appendString:@"存储套餐"];
                }else if(cgsubtype==3){
                    [strContent appendString:@"个人基础套餐"];
                }else if(cgsubtype==9){
                    [strContent appendString:@"免费套餐"];
                } else {
                    [strContent appendString:@"未知"];
                }
            } else if(cgtype==4) {
                [strContent appendString:@"套餐失效\n"];
                if(cgsubtype==1){
                    [strContent appendString:@"存储套餐"];
                } else if(cgsubtype==3){
                    [strContent appendString:@"个人基础套餐"];
                } else if(cgsubtype==0){
                    [strContent appendString:@"试用套餐"];
                }else if(cgsubtype==9){
                    [strContent appendString:@"免费套餐"];
                }
            } else if(cgtype==5) {
                [strContent appendString:@"套餐转换\n"];
                if(cgsubtype==2){
                    [strContent appendString:@"时长套餐"];
                } else {
                    [strContent appendString:@"未知"];
                }
            } else if(cgtype==6) {
                [strContent appendString:@"通话录音\n"];
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
                [strContent appendString:@"录音删除\n"];
                if(cgsubtype==1){
                    [strContent appendString:@"主叫录音删除"];
                } else if(cgsubtype==2){
                    [strContent appendString:@"被叫录音删除"];
                } else if(cgsubtype==3){
                    [strContent appendString:@"WebCall录音删除"];
                }  else {
                    [strContent appendString:@"未知"];
                }
            } else if(cgtype==8) {
                [strContent appendString:@"录音提取"];
                if(cgsubtype==1){
                    
                }else{
                    [strContent appendString:@"\n未知"];
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
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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

- (void)reloadTableViewDataSource {
	if([[Config Instance]isLogin]){
        _reloading = YES;
        if(currentTab == 1){
            self.navigationItem.rightBarButtonItem.enabled=NO;
            [[Config Instance] setIsRefreshAccountPayList:YES];
            self.dataItemArray=_leftDataItemArray;
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest loginhandle:@"v4combinfoGet" requestParams:requestParams];
        } else if (currentTab == 2){
            self.dataItemArray=_rightDataItemArray;
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:[NSString stringWithFormat: @"%d",PAGESIZE]  forKey:@"pagesize"];
            [requestParams setObject:[NSString stringWithFormat: @"%d",_currentPage] forKey:@"currentpage"];
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest loginhandle:@"v4accnewDetail" requestParams:requestParams];
        }
    }else{
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
        [Common noLoginAlert:self];
    }
}

@end