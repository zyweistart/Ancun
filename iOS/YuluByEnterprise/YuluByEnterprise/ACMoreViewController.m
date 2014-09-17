#import "ACMoreViewController.h"
#import "ACNavigationWebPageViewController.h"
#import "ACAboutUsViewController.h"
#import "ACFeedBackViewController.h"
#import "ACModifyPwdViewController.h"
#import "ACMoreCell.h"
#import "ACMore.h"
#import "FileUtils.h"

@interface ACMoreViewController ()

- (void)calculateTotal;

@end

@implementation ACMoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.navigationItem.title=@"更多";
        self.tabBarItem.image = [UIImage imageNamed:@"nav_icon_more"];
        self.tabBarItem.title = @"更多";
        self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [self.view addSubview:self.tableView];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self reloadTableViewDataSource];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([[Config Instance]isCalculateTotal]){
        [NSThread detachNewThreadSelector:@selector(calculateTotal) toTarget:self withObject:nil];
    }
}

#pragma mark -
#pragma mark Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.dataItemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_moreInSection objectForKey:[self.dataItemArray objectAtIndex:section]] count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    static NSString *cellReuseIdentifier=@"ACMoreCellIdentifier";
    ACMoreCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    if(!cell){
        cell = [[ACMoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
    }
    ACMore *more=[[_moreInSection objectForKey:[self.dataItemArray objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    cell.lblName.text=[more name];
    cell.imgView.image=[UIImage imageNamed:[more img]];
    
    switch(more.tag){
        case 1:
        case 2:
        case 3:
        case 5:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            cell.accessoryType=UITableViewCellAccessoryNone;
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    ACNavigationWebPageViewController *navigationWebPageViewController=[[ACNavigationWebPageViewController alloc]initWithNavigationTitle:@"小贴士" resourcePath:@"TipContent"];
    ACFeedBackViewController *feedBackViewController=[[ACFeedBackViewController alloc]init];
    ACAboutUsViewController *aboutUsViewController=[[ACAboutUsViewController alloc]init];
    ACModifyPwdViewController *modifyPwdViewController=[[ACModifyPwdViewController alloc]init];
    ACMore *more=[[_moreInSection objectForKey:[self.dataItemArray objectAtIndex:[indexPath section]]] objectAtIndex:[indexPath row]];
    switch([more tag]){
        case 1:
            //小贴士
            navigationWebPageViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:navigationWebPageViewController animated:YES];
            break;
        case 2:
            //意见反馈
            feedBackViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:feedBackViewController animated:YES];
            break;
        case 3:
            //关于我们
            aboutUsViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutUsViewController animated:YES];
            break;
        case 4:
            //清理缓存
            if([[Config Instance]isCalculateTotal]){
                [Common alert:@"正在计算缓存大小"];
            }else{
                if(cachesize>0){
                    [Common actionSheet:self message:@"确定要清除所有缓存文件吗？" tag:2];
                }else{
                    [Common notificationMessage:@"当前的缓存文件为0KB，无须清除" inView:self.view];
                }
            }
            break;
        case 5:
            //修改密码
            modifyPwdViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:modifyPwdViewController animated:YES];
            break;
        case 6:
            //重新登录
            [Common actionSheet:self message:@"确定要重新登录吗？" tag:1];
            break;
    }
}

- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableArray *)result{
    [_moreInSection removeAllObjects];
    [self reloadTableViewDataSource];
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==1){
        if(buttonIndex==0){
            [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_2 requestCode:0 data:nil];
        }
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            [FileUtils removeCacheFile];
            //            [Common setCache:[Config Instance].cacheKey data:nil];
            [[Config Instance]setIsCalculateTotal:YES];
            cachesize=0;
            [Common notificationMessage:@"清除完成" inView:self.view];
            [self reloadTableViewDataSource];
        }
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)reloadTableViewDataSource{
    if(!_moreInSection){
        _moreInSection = [[NSMutableDictionary alloc] initWithCapacity:3];
    }
    [_moreInSection setObject:
     [[NSArray alloc] initWithObjects:
      [[ACMore alloc]initWith:@"小贴士" andImg:@"more_icon_tip" andTag:1],
      [[ACMore alloc]initWith:@"意见反馈" andImg:@"more_icon_feedback" andTag:2],
      [[ACMore alloc]initWith:@"关于我们" andImg:@"more_icon_aboutus" andTag:3],
      nil] forKey:@"first"];
    
    [_moreInSection setObject:
     [[NSArray alloc] initWithObjects:
      [[ACMore alloc]initWith:@"缓存大小:正在计算" andImg:@"more_icon_delcache" andTag:4],
      [[ACMore alloc]initWith:@"修改密码" andImg:@"more_icon_modifypwd" andTag:5],
      nil] forKey:@"second"];
    
    [_moreInSection setObject:
     [[NSArray alloc] initWithObjects:
      [[ACMore alloc]initWith:@"重新登录" andImg:@"more_icon_relogin" andTag:6],
      nil] forKey:@"third"];
    
    if(!self.dataItemArray){
        self.dataItemArray = [[NSMutableArray alloc] initWithObjects:@"first",@"second",@"third",nil];
    }
    [self.tableView reloadData];
    if([[Config Instance]isCalculateTotal]){
        [NSThread detachNewThreadSelector:@selector(calculateTotal) toTarget:self withObject:nil];
    }
}

//计算空间大小
- (void)calculateTotal{
    NSString *cacheName=nil;
    cachesize=[FileUtils getCacheSize];
    if(cachesize/1024/1024>1024){//GB
        float totla=(float)cachesize/1024/1024;
        cacheName=[NSString stringWithFormat:@"%.2fGB",totla/1024];
    }else if(cachesize/1024>1024){//MB
        float totla=(float)cachesize/1024;
        cacheName=[NSString stringWithFormat:@"%.2fMB",totla/1024];
    }else{//KB
        cacheName=[NSString stringWithFormat:@"%lldKB",cachesize/1024];
    }
    [_moreInSection setObject:
     [[NSArray alloc] initWithObjects:
      [[ACMore alloc]initWith:[NSString stringWithFormat:@"缓存大小:%@",cacheName] andImg:@"more_icon_delcache" andTag:4],
      [[ACMore alloc]initWith:@"修改密码" andImg:@"more_icon_modifypwd" andTag:5],
      nil] forKey:@"second"];
    [self.tableView reloadData];
    [[Config Instance]setIsCalculateTotal:NO];
}

@end
