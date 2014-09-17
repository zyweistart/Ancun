#import "ACGuideViewController.h"
#import "ACGesturePasswordViewController.h"
#import "ACLoginViewController.h"

@interface ACGuideViewController ()

@end

#pragma mark -

@implementation ACGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EAIntroPage *page1 = [EAIntroPage page];
    page1.bgImage = [UIImage imageNamed:@"guide1"];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.bgImage = [UIImage imageNamed:@"guide2"];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.bgImage = [UIImage imageNamed:@"guide3"];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.bgImage = [UIImage imageNamed:@"guide4"];
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.bgImage = [UIImage imageNamed:@"guide5"];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5]];
    
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0.0];
}

- (void)introDidFinish {
    //进入应用之后才进行存储
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    [Common setCache:DEFAULTDATA_LASTVERSIONNO data:[infoDict objectForKey:@"CFBundleVersion"]];
    
    NSString *GESTUREPWD=[Common getCache:DEFAULTDATA_GESTUREPWD];
    NSString *PHONE=[Common getCache:DEFAULTDATA_PHONE];
    NSString *PASSWORD=[Common getCache:DEFAULTDATA_PASSWORD];
    BOOL AUTOLOGIN=[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN];
    if([GESTUREPWD isNotEmpty]&&[PHONE isNotEmpty]&&[PASSWORD isNotEmpty]&&AUTOLOGIN){
        [UIApplication sharedApplication].keyWindow.rootViewController=[[ACGesturePasswordViewController alloc]initWithFlag:NO];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController=[[ACLoginViewController alloc]init];
    }
    
}

@end
