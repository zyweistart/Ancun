#import "ACNotaryDetailViewController.h"

@interface ACNotaryDetailViewController ()

@end

@implementation ACNotaryDetailViewController

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACNotaryDetailViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACNotaryDetailViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"成功";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
    }
    return self;
}

#pragma mark -
#pragma mark Custom Methods

- (void)back:(id)sender {
    [Common resultNavigationViewController:self resultDelegate:nil resultCode:0 requestCode:0 data:0];
}

@end
