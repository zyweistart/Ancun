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

- (id)initWithData:(NSDictionary*)data
{
    self=[self init];
    if(self){
        self.data=data;
    }
    return self;
}

- (void)cTitle:(NSString*)title
{
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(0, 0, 80, 30)];
    [lbl setText:title];
    [lbl setFont:[UIFont systemFontOfSize:20]];
    [lbl setTextColor:DEFAULTITLECOLOR(100)];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    self.navigationItem.titleView=lbl;
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

- (UIButton*)cNavigationRightItemType:(NSInteger)type Title:(NSString*)title action:(SEL)action
{
    UIButton *bButton = [[UIButton alloc]init];
    [bButton setFrame:CGRectMake1(0, 0, 60, 30)];
    [bButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil action:nil];
    negativeSpacer.width = -10;
    if(type==1||type==2){
        [bButton setTitle:title forState:UIControlStateNormal];
        [bButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [bButton setTitleColor:COLOR2552160 forState:UIControlStateNormal];
        if(type==1){
            [bButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:bButton], nil];
        }else if(type==2){
            [bButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:bButton], nil];
        }
    }else if(type==3||type==4){
        if(type==3){
            [bButton setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
            [bButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateHighlighted];
        }else if(type==4){
            [bButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
            [bButton setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateHighlighted];
        }
        [bButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:bButton], nil];
    }
    return bButton;
}

- (void)onControllerResult:(NSInteger)resultCode data:(NSMutableDictionary*)result
{
    
}

//- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
//{
//    if([response successFlag]){
//        
//    }
//}
//
//- (void)requestFailed:(int)reqCode
//{
//    NSLog(@"网络请求失败");
//}

@end
