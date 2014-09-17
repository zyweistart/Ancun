#import "ACAboutUsViewController.h"

@interface ACAboutUsViewController ()

@end

@implementation ACAboutUsViewController

- (id)init{
    self = [super init];
    if (self) {
        self.title=@"关于我们";
        [self.view setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView=[[UIImageView alloc]init];
    if(inch4){
       [imageView setFrame:CGRectMake(0, 20, 320, 458)];
       [imageView setImage:[UIImage imageNamed:@"aboutus-5"]];
    }else{
       [imageView setFrame:CGRectMake(0, 20, 320, 370)];
       [imageView setImage:[UIImage imageNamed:@"aboutus"]];
    }
    [self.view addSubview:imageView];
}

@end
