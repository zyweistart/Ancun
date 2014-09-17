#import "ACAboutUsViewController.h"

@interface ACAboutUsViewController ()

@end

@implementation ACAboutUsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"关于我们";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView=[[UIImageView alloc]init];
    if(iPhone5){
       [imageView setFrame:CGRectMake(0, 20, 320, 458)];
       [imageView setImage:[UIImage imageNamed:@"aboutus-568h"]];
    }else{
       [imageView setFrame:CGRectMake(0, 20, 320, 370)];
       [imageView setImage:[UIImage imageNamed:@"aboutus"]];
    }
    [self.view addSubview:imageView];
}

@end
