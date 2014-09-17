#import "ACMainViewController.h"
#import "ACMagazineViewController.h"
#import "ACHistoryViewController.h"
#import "ACRecentViewController.h"
#import "ACMyViewController.h"

@implementation ACMainViewController

- (void)viewDidLoad
{
    ACMagazineViewController *magazineViewController=[[ACMagazineViewController alloc]init];
    magazineViewController.title=@"杂志";
    UINavigationController *magazineViewControllerNav=[[UINavigationController alloc]initWithRootViewController:magazineViewController];
    [magazineViewControllerNav setTitle:@"杂志"];
    
    ACHistoryViewController *historyViewController=[[ACHistoryViewController alloc]init];
    historyViewController.title=@"往期";
    UINavigationController *historyViewControllerNav=[[UINavigationController alloc]initWithRootViewController:historyViewController];
    [historyViewControllerNav setTitle:@"往期"];
    
    ACRecentViewController *recentViewController=[[ACRecentViewController alloc]init];
    recentViewController.title=@"最近阅读";
    UINavigationController *recentViewControllerNav=[[UINavigationController alloc]initWithRootViewController:recentViewController];
    [recentViewControllerNav setTitle:@"最近阅读"];
    
    ACMyViewController *myViewController=[[ACMyViewController alloc]init];
    myViewController.title=@"我的";
    UINavigationController *myViewControllerNav=[[UINavigationController alloc]initWithRootViewController:myViewController];
    [myViewControllerNav setTitle:@"我的"];
    
    self.viewControllers=[NSArray arrayWithObjects:magazineViewControllerNav,historyViewControllerNav,recentViewControllerNav,myViewControllerNav,nil];
    [super viewDidLoad];
}

@end
