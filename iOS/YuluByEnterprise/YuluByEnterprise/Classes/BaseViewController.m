#import "BaseViewController.h"
#ifndef TEST
#import "BaiduMobStat.h"
#endif

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
#ifndef TEST
    //百度统计
    [[BaiduMobStat defaultStat] pageviewStartWithName:[NSString stringWithUTF8String:object_getClassName(self)]];
#endif
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
#ifndef TEST
    //百度统计
    [[BaiduMobStat defaultStat] pageviewEndWithName:[NSString stringWithUTF8String:object_getClassName(self)]];
#endif
}

@end
