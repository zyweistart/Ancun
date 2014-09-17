#import "MyViewController.h"
#import "ACLoginViewController.h"

@interface MyViewController () {
    int pageNumber;
}

@end

@implementation MyViewController

- (id)initWithPageNumber:(NSUInteger)page {
    if (self = [super init]) {
        pageNumber = page;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, iPhone5?522:434)];
    [self.view addSubview:self.numberImage];
    if(pageNumber==4){
        int left=self.view.frame.size.width;
        int top=iPhone5?360:310;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(left/2-37, top, 74, 79)];
        [btn setImage:[UIImage imageNamed:@"guide_button_f_gb"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"guide_button_b_gb"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(welcomeOnClick:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
    }
}

- (void)welcomeOnClick:(id)sender {
    [UIApplication sharedApplication].keyWindow.rootViewController=[[ACLoginViewController alloc]init];
    //进入应用之后才进行存储
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    [Common setCache:DEFAULTDATA_LASTVERSIONNO data:[infoDict objectForKey:@"CFBundleVersion"]];
}

@end