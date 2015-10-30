#import "BaseViewController.h"

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

- (void)setTitle:(NSString *)title
{
    [super setTitle:@""];
    UILabel *lblTitle=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGWidth(100), 44)];
    [lblTitle setText:title];
    [lblTitle setTextColor:[UIColor whiteColor]];
    [lblTitle setFont:GLOBAL_FONTSIZE(20)];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView=lblTitle;
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
}

- (void)requestFailed:(int)reqCode
{
    NSLog(@"请求失败编号:%d",reqCode);
}

- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableDictionary*)result
{
    
}

@end