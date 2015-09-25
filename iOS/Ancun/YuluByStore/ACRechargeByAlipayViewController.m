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

#ifdef  TEST
#define PRODUCTRECORDNO_STRING @"d7025d331c315d856dfdee440f3f9c34"
#else
#define PRODUCTRECORDNO_STRING @"2cec276a043223d9ff47859082cd99bc"
#endif

@interface ACRechargeByAlipayViewController ()

@end

@implementation ACRechargeByAlipayViewController {
    
    ACRechargeNav *_rechargeNav;
    
}

- (id)init {
    self=[super init];
    if (self) {
        
        self.navigationItem.title=@"账户充值";
        _rechargeNav=[[ACRechargeNav alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [_rechargeNav firstStep];
        [self.tableView setTableHeaderView:_rechargeNav];
    }
    
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self autoRefresh];;
}

#pragma mark -
#pragma mark Delegate Methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.dataItemArray count]>[indexPath row]){
        return CGHeight(60);
    }else{
        return CGHeight(50);
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
        NSString *valid=[dictionary objectForKey:@"valid"];
        NSString *duration=[dictionary objectForKey:@"duration"];
        NSString *storage=[dictionary objectForKey:@"storage"];
        [cell.lblTimeLong setHidden:[valid intValue]==0];
        [cell.lblTimeLong setText:[NSString stringWithFormat:@"有效期%@天",valid]];
        [cell.lblTime setHidden:[duration intValue]==0];
        [cell.lblTime setText:[NSString stringWithFormat:@"%@分钟",duration]];
        [cell.lblStorage setHidden:[storage intValue]==0];
        [cell.lblStorage setText:[NSString stringWithFormat:@"%@MB",storage]];
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
    if([self.dataItemArray count]>[indexPath row]) {
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
        [requestParams setObject:[NSString stringWithFormat: @"%ld",_currentPage] forKey:@"currentpage"];
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
