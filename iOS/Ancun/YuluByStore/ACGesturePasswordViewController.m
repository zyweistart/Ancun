//
//  ACGesturePasswordViewController.m
//  Ancun
//
//  Created by Start on 4/10/14.
//
//

#import "ACGesturePasswordViewController.h"
#import "ACLoginViewController.h"

#define SUCCESSCOLOR [[UIColor colorWithRed:(107/255.0) green:(166/255.0) blue:(216/255.0) alpha:1] colorWithAlphaComponent:0.3]
#define FAILCOLOR [[UIColor colorWithRed:(136/255.0) green:(74/255.0) blue:(108/255.0) alpha:1] colorWithAlphaComponent:0.3]

@interface ACGesturePasswordViewController () 

@end

@implementation ACGesturePasswordViewController{
    int errorCount;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:MAINBG];
        self.lockView=[[KKGestureLockView alloc]initWithFrame:self.view.bounds];
        [self.lockView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg3"]]];
        [self.view addSubview:self.lockView];
        self.lockView.normalGestureNodeImage = [UIImage imageNamed:@"gesture_node_normal"];
        
        self.lockView.successSelectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected_success"];
        self.lockView.failSelectedGestureNodeImage = [UIImage imageNamed:@"gesture_node_selected_fail"];
        self.lockView.selectedGestureNodeImage = self.lockView.successSelectedGestureNodeImage;
        
        self.lockView.successLineColor = SUCCESSCOLOR;
        self.lockView.failLineColor = FAILCOLOR;
        self.lockView.lineColor = self.lockView.successLineColor;
        
        self.lockView.lineWidth = 12;
        self.lockView.delegate = self;
        if(inch4){
            self.lockView.contentInsets = UIEdgeInsetsMake(120, 20, 100, 20);
        }else{
            self.lockView.contentInsets = UIEdgeInsetsMake(80, 20, 100, 20);
        }
        errorCount=0;
        
        self.lblInfo=[[UILabel alloc]initWithFrame:CGRectMake(0, inch4?50:30, self.view.frame.size.width, 30)];
        [self.lblInfo setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
        [self.lblInfo setTextColor:[UIColor whiteColor]];
        [self.lblInfo setBackgroundColor:[UIColor clearColor]];
        [self.lblInfo setTextAlignment:NSTextAlignmentCenter];
        [self.lockView addSubview:self.lblInfo];
        
    }
    return self;
}

- (id)initWithFlag:(BOOL)flag
{
    self=[self init];
    if(self){
        
        _flag=flag;
        
        [[Config Instance] setLock:YES];
        
        [self.lblInfo setFont:[UIFont systemFontOfSize:25]];
        [self.lblInfo setText:[Common getCache:DEFAULTDATA_PHONE]];
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(20, self.lockView.frame.size.height-60, 120, 40)];
        btn.titleLabel.font=[UIFont systemFontOfSize: 15];
        [btn setTitle:@"忘记手势密码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onClickForgetPwd:) forControlEvents:UIControlEventTouchUpInside];
        [self.lockView addSubview:btn];
        
        btn=[[UIButton alloc]initWithFrame:CGRectMake(180, self.lockView.frame.size.height-60, 120, 40)];
        btn.titleLabel.font=[UIFont systemFontOfSize: 15];
        [btn setTitle:@"切换登录账户" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onClickSwitchUser:) forControlEvents:UIControlEventTouchUpInside];
        [self.lockView addSubview:btn];
        
    }
    return self;
}

- (void)onClickForgetPwd:(id)sender
{
    //清除登录密码
    [Common setCache:DEFAULTDATA_PASSWORD data:@""];
    [self goLoginPage:YES];
}

- (void)onClickSwitchUser:(id)sender
{
    //清除登录用户密码
    [Common setCache:DEFAULTDATA_PHONE data:@""];
    [Common setCache:DEFAULTDATA_PASSWORD data:@""];
    [self goLoginPage:NO];
}

- (void)gestureLockView:(KKGestureLockView *)gestureLockView didEndWithPasscode:(NSString *)passcode{
    
    NSString *value=[Common getCache:DEFAULTDATA_GESTUREPWD];
    if([passcode isEqualToString:value]){
        [self.lockView doneSelectedButtons];
        if(_flag){
            [[Config Instance] setLock:NO];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [Common setCacheByBool:DEFAULTDATA_AUTOLOGIN data:YES];
            [self goLoginPage:NO];
        }
        return;
    }
    [self.lockView failSelectedButtons];
    if(errorCount>2){
        [Common alert:@"超过限制请重新登录"];
        //清除登录密码
        [Common setCache:DEFAULTDATA_PASSWORD data:@""];
        [self goLoginPage:YES];
    }
    errorCount++;
}

- (void)goLoginPage:(BOOL)agp
{
    ACLoginViewController *loginViewController=[[ACLoginViewController alloc]init];
    [loginViewController setGotoAgainGesurePassword:agp];
    [self presentViewController:loginViewController animated:YES completion:^{
        [[Config Instance] setLock:NO];
    }];
}

@end
