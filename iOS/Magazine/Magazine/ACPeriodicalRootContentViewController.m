#import "ACPeriodicalRootContentViewController.h"
#import "ACPeriodicalDataContentViewController.h"

@interface ACPeriodicalRootContentViewController ()

@property NSInteger index;
@property (strong,nonatomic) Book *book;
@property (strong,nonatomic) NSArray *dataItemArray;
@property (strong, nonatomic) UIPageViewController *pageViewController;

@end

@implementation ACPeriodicalRootContentViewController

- (id)initWithData:(NSArray *)data Index:(NSInteger)index book:(Book *)book
{
    self=[super init];
    if(self){
        
        self.book=book;
        self.index=index;
        self.dataItemArray=data;
        
        self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        self.pageViewController.delegate = self;
        self.pageViewController.dataSource = self;
        
        NSArray *viewControllers = @[[self viewControllerAtIndex:self.index]];
        [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

        [self addChildViewController:self.pageViewController];
        [self.view addSubview:self.pageViewController.view];
        
        self.pageViewController.view.frame = self.view.bounds;
        [self.pageViewController didMoveToParentViewController:self];
        
        self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    }
    return self;
}

- (ACPeriodicalDataContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.dataItemArray count] == 0) || (index >= [self.dataItemArray count])) {
        return nil;
    }
    ACPeriodicalDataContentViewController *periodicalDataContentViewController=[[ACPeriodicalDataContentViewController alloc]initWithData:self.dataItemArray[index]];
    [periodicalDataContentViewController setIndex:index];
    [periodicalDataContentViewController setBook:self.book];
    [periodicalDataContentViewController loadData];
    return periodicalDataContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ACPeriodicalDataContentViewController *)viewController).index;
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((ACPeriodicalDataContentViewController *)viewController).index;
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == [self.dataItemArray count]) {
        [Common alert:@"已经到达最后一页"];
        return nil;
    }
    return [self viewControllerAtIndex:index];
}

@end