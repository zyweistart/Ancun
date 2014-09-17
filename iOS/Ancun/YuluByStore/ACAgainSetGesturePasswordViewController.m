//
//  ACAgainSetGesturePasswordViewController.m
//  Ancun
//
//  Created by Start on 4/14/14.
//
//

#import "ACAgainSetGesturePasswordViewController.h"

@interface ACAgainSetGesturePasswordViewController () <UIAlertViewDelegate>

@end

@implementation ACAgainSetGesturePasswordViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"重绘密码";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"关闭"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(close)];
        //重绘密码先清除原密码
        [Common setCache:DEFAULTDATA_GESTUREPWD data:@""];
    }
    return self;
}

- (void)close
{
    [Common alert:@"未设置新手势密码，确认退出吗？" cancel:@"取消" ok:@"确定" delegate:self];
}

- (void)toRootViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1){
        [self toRootViewController];
    }
}

@end
