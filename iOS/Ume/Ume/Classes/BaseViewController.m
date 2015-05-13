#import "BaseViewController.h"
#ifndef TEST
#endif

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)init{
    self=[super init];
    if(self){
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    [super viewDidLoad];
}

- (void)goBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result
{
    
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        
    }
}

- (void)requestFailed:(int)reqCode
{
    NSLog(@"网络请求失败");
}

@end
