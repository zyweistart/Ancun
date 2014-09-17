#import "ACMyViewController.h"
#import "ACMySubscriptionViewController.h"
#import "ACMyCollectViewController.h"
#import "ACLoginViewController.h"
#import "ACMessageViewController.h"
#import "Config.h"

#define SKEY @"key"
#define SVALUE @"value"
#define SNEXT @"isnext"

@interface ACMyViewController ()

@property BOOL isLogin;
@property (strong,nonatomic) NSArray *loginArr;
@property (strong,nonatomic) NSArray *noLoginArr;

@end

@implementation ACMyViewController

- (id)init
{
    self=[super initWithUITableViewStyle:UITableViewStyleGrouped];
    if(self){
        NSDictionary *d1= @{SKEY: @"我的订阅",SVALUE:@"1",SNEXT:@"1"};
        NSDictionary *d2= @{SKEY: @"我的收藏",SVALUE:@"2",SNEXT:@"1"};
        NSDictionary *d3= @{SKEY: @"消息",SVALUE:@"3",SNEXT:@"1"};
        NSDictionary *d4= @{SKEY: @"登录",SVALUE:@"4",SNEXT:@"1"};
        NSDictionary *d5= @{SKEY: @"退出",SVALUE:@"5",SNEXT:@"0"};
        //未登录状态
        self.noLoginArr=@[@[d4],@[d3]];
        //登录状态
        self.loginArr=@[@[d1,d2],@[d3],@[d5]];
        self.isLogin=[[Config Instance]isLogin];
        [self reloadData];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.isLogin!=[[Config Instance]isLogin]){
        [self reloadData];
        self.isLogin=[[Config Instance]isLogin];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.dataItemArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataItemArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *data=[[self.dataItemArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    [cell.textLabel setText:[data objectForKey:SKEY]];
    if([@"1" isEqualToString:[data objectForKey:SNEXT]]){
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *data=[[self.dataItemArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    int value=[[data objectForKey:SVALUE]intValue];
    if(value==1){
        //我的订阅
        ACMySubscriptionViewController *mySubscriptionViewController=[[ACMySubscriptionViewController alloc]init];
        [self.navigationController pushViewController:mySubscriptionViewController animated:YES];
    }else if(value==2){
        //我的收藏
        ACMyCollectViewController *myCollectViewController=[[ACMyCollectViewController alloc]init];
        [self.navigationController pushViewController:myCollectViewController animated:YES];
    }else if(value==3){
        //消息
        ACMessageViewController *messageViewController=[[ACMessageViewController alloc]init];
        [self.navigationController pushViewController:messageViewController animated:YES];
    }else if(value==4){
        //登陆
        ACLoginViewController *loginViewController=[[ACLoginViewController alloc]init];
        [self.navigationController pushViewController:loginViewController animated:YES];
    }else if(value==5){
        //退出
        [Common alert:@"退出成功"];
        [[Config Instance]setIsLogin:NO];
        [self reloadData];
    }
}

- (void)reloadData
{
    [self.dataItemArray removeAllObjects];
    if([[Config Instance]isLogin]){
        //登录状态
        [self.dataItemArray addObjectsFromArray:self.loginArr];
    }else{
        //未登录状态
        [self.dataItemArray addObjectsFromArray:self.noLoginArr];
    }
    [self.tableView reloadData];
}

@end