//
//  ACSetGesturePasswordViewController.m
//  Ancun
//
//  Created by Start on 4/10/14.
//
//

#import "ACSetGesturePasswordViewController.h"
#import "NSString+Utils.h"

@interface ACSetGesturePasswordViewController ()

@end

@implementation ACSetGesturePasswordViewController{
    NSString *firstPassCode;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"密码绘制";
        [self.lblInfo setText:@"请绘制解锁图案"];
    }
    return self;
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    if([firstPassCode isNotEmpty]){
        if([firstPassCode isEqualToString:passcode]){
            [self.lockView doneSelectedButtons];
            [Common setCache:DEFAULTDATA_GESTUREPWD data:passcode];
            [Common setCache:DEFAULTDATA_PHONE data:[[Config Instance] USERNAME]];
            [Common setCache:DEFAULTDATA_PASSWORD data:[[Config Instance] PASSWORD]];
            [Common setCacheByBool:DEFAULTDATA_AUTOLOGIN data:YES];
            [[Config Instance] setLock:NO];
            [self.lblInfo setText:@"手势密码设置成功"];
            [self performSelector:@selector(toRootViewController) withObject:nil afterDelay:0.5];
        }else{
            [self.lockView failSelectedButtons];
            firstPassCode=nil;
            [self.lblInfo setText:@"与上一次输入不一致，请重试"];
        }
    }else{
        [self.lockView doneSelectedButtons];
        firstPassCode=passcode;
        [self.lblInfo setText:@"请再次绘制解锁图案"];
    }
}

- (void)toRootViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end