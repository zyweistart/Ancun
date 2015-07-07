#import "BaseViewController.h"
#ifndef TEST
#import "BaiduMobStat.h"
#import "MobClick.h"
#endif

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)init{
    self=[super init];
    if(self){
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    [self buildUI7];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#ifndef TEST
    //有盟统计
    [MobClick beginLogPageView:@"PageOne"];
    //百度统计
    [[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithUTF8String:object_getClassName(self)]];
#endif
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
#ifndef TEST
    //有盟统计
    [MobClick endLogPageView:@"PageOne"];
    //百度统计
    [[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithUTF8String:object_getClassName(self)]];
#endif
}

- (void)buildUI56
{
    //适配于5、6
}

- (void)buildUI7
{
    //适配于7
}

@end
