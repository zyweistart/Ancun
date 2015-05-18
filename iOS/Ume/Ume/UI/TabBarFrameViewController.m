#import "TabBarFrameViewController.h"
#import "MainViewController.h"
#import "MessageViewController.h"
#import "PublishedSpeechSoundViewController.h"
#import "DiscoverViewController.h"
#import "MyViewController.h"

@interface TabBarFrameViewController ()

@end

@implementation TabBarFrameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    self.viewControllers = [NSArray arrayWithObjects:
                            [self viewControllerWithTabTitle:@"懂你" image:[UIImage imageNamed:@"tab_feed"] ViewController:[[MainViewController alloc]init]],
                            [self viewControllerWithTabTitle:@"消息" image:[UIImage imageNamed:@"tab_live"] ViewController:[[MessageViewController alloc]init]],
                            [self viewControllerWithTabTitle:@"" image:nil ViewController:[[PublishedSpeechSoundViewController alloc]init]],
                            [self viewControllerWithTabTitle:@"发现" image:[UIImage imageNamed:@"tab_feed_profile"] ViewController:[[DiscoverViewController alloc]init]],
                            [self viewControllerWithTabTitle:@"我的" image:[UIImage imageNamed:@"tab_messages"] ViewController:[[MyViewController alloc]init]], nil];
    [self addCenterButtonWithImage:[UIImage imageNamed:@"camera_button_take"] highlightImage:[UIImage imageNamed:@"tabBar_cameraButton_ready_matte"]];
}

- (UINavigationController*)createNavigation:(UIViewController*)viewController
{
    UINavigationController *frameViewControllerNav=[[UINavigationController alloc]initWithRootViewController:viewController];
    [[frameViewControllerNav navigationBar]setBarTintColor:NAVBG];
    [[frameViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    return frameViewControllerNav;
}

@end