#import "ACLoginViewController.h"
#import "ACDialsViewController.h"
#import "ACContactsViewController.h"
#import "ACAccountViewController.h"
#import "ACRecordingManagerViewController.h"
#import "ACMoreViewController.h"
#import "ACRegistrationViewController.h"
#import "ACForgetPasswordViewController.h"
#import "ACAgainSetGesturePasswordViewController.h"
#import "NSString+Utils.h"

@interface ACLoginViewController ()

@end

@implementation ACLoginViewController {
    
    UITextField *_txtUserName;
    UITextField *_txtPassword;
    
    unsigned long m_lastTabIndex;
    
    BOOL rememberPassword;
    
    UIButton *btnRememberPwdImg;
}

- (id)init {
    self=[super init];
    if(self) {
        //登录代理
        [[Config Instance] setLoginResultDelegate:self];
        int h=0;
        if(IOS7){
            h=STATUSHEIGHT;
        }
        //背景
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"loginbg"]]];
        
        float width=self.view.frame.size.width;
        float height=self.view.frame.size.height;
        UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, h, width, height-h)];
        //触摸屏幕事件
        [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:control];
        //LOGO
        UIView *logonv=[[UIView alloc]initWithFrame:CGRectMake(width/2-130/2, inch4?54:30, 130, 130)];
        [logonv setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_logo2"]]];
        [control addSubview:logonv];
        //登录输入框
        UIView *userNameInputView=[[UIView alloc]initWithFrame:CGRectMake(width/2-271/2, inch4?225:170, 271, 51)];
        [userNameInputView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_input_bg"]]];
        [control addSubview:userNameInputView];
        //账户输入框
        _txtUserName=[[UITextField alloc] initWithFrame:CGRectMake(20, 5, 231, 41)];
        [_txtUserName setPlaceholder:@"账号"];
        [_txtUserName setFont:[UIFont systemFontOfSize: 22]];
        [_txtUserName setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_txtUserName setTextAlignment:NSTextAlignmentCenter];
        [_txtUserName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_txtUserName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_txtUserName setKeyboardType:UIKeyboardTypePhonePad];
        [userNameInputView addSubview:_txtUserName];
        UIView *passwordInputView=[[UIView alloc]initWithFrame:CGRectMake(width/2-271/2, inch4?293:233, 271, 51)];
        [passwordInputView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_input_bg"]]];
        [control addSubview:passwordInputView];
        //密码输入框
        _txtPassword=[[UITextField alloc] initWithFrame:CGRectMake(20, 5, 231, 41)];
        [_txtPassword setPlaceholder:@"密码"];
        [_txtPassword setFont:[UIFont systemFontOfSize: 22]];
        [_txtPassword setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_txtPassword setTextAlignment:NSTextAlignmentCenter];
        [_txtPassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [_txtPassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [_txtPassword setSecureTextEntry:YES];
        [_txtPassword setDelegate:self];
        [_txtPassword setReturnKeyType:UIReturnKeyDone];
        [passwordInputView addSubview:_txtPassword];
        //记住密码复选框
        btnRememberPwdImg=[[UIButton alloc]initWithFrame:CGRectMake(35, inch4?356:296, 15, 15)];
        [btnRememberPwdImg addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnRememberPwdImg];
        rememberPassword=[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN];
        if(rememberPassword){
            [btnRememberPwdImg setImage:[UIImage imageNamed:@"login_g"] forState:UIControlStateNormal];
        }else{
            [btnRememberPwdImg setImage:[UIImage imageNamed:@"login_g_hover"] forState:UIControlStateNormal];
        }
        //记住密码文字
        UIButton *btnRemberPwdLbl=[[UIButton alloc]initWithFrame:CGRectMake(55, inch4?354:294, 60, 18)];
        btnRemberPwdLbl.titleLabel.font=[UIFont systemFontOfSize: 15];
        [btnRemberPwdLbl setTitle:@"记住密码" forState:UIControlStateNormal];
        [btnRemberPwdLbl addTarget:self action:@selector(rememberPassword:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnRemberPwdLbl];
        //找回密码
        UIButton *btnForgetPwd=[[UIButton alloc]initWithFrame:CGRectMake(width/2+60, inch4?354:294, 68, 18)];
        btnForgetPwd.titleLabel.font=[UIFont systemFontOfSize: 15];
        [btnForgetPwd setTitle:@"找回密码" forState:UIControlStateNormal];
        [btnForgetPwd addTarget:self action:@selector(onClickForgetPwd:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnForgetPwd];
        //登录按钮
        UIButton *btnLogin=[[UIButton alloc]initWithFrame:CGRectMake(width/2-271/2, inch4?387:327, 271, 51)];
        [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        btnLogin.titleLabel.font=[UIFont systemFontOfSize:30];
        [btnLogin setBackgroundImage:[UIImage imageNamed:@"login_button"] forState:UIControlStateNormal];
        [btnLogin addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnLogin];
        //注册按钮
        UIButton *btnRegister=[[UIButton alloc]initWithFrame:CGRectMake(width/2-147.5, inch4?455:385, 295, 32)];
        btnRegister.titleLabel.font=[UIFont systemFontOfSize: 17.0];
        [btnRegister setTitle:@"还没有账户，马上去注册>>" forState:UIControlStateNormal];
        [btnRegister addTarget:self action:@selector(onClickRegister:) forControlEvents:UIControlEventTouchUpInside];
        [control addSubview:btnRegister];
        
        UILabel *lblTipTxt=[[UILabel alloc]initWithFrame:CGRectMake(width/2-147.5, inch4?492:402, 295, 64)];
        lblTipTxt.font=[UIFont systemFontOfSize:14];
        [lblTipTxt setNumberOfLines:0];
        [lblTipTxt setText:@"请使用本机号码注册或登录，非本机号码登录时通话录音将无法被正确保全."];
        [lblTipTxt setTextColor:[UIColor whiteColor]];
        [lblTipTxt setBackgroundColor:[UIColor clearColor]];
        [control addSubview:lblTipTxt];
        
        [self autoLogin];
        
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode{
    if([response successFlag]){
        NSString *phone=_txtUserName.text;
        NSString *password=_txtPassword.text;
        [[Config Instance] setUSERNAME:phone];
        [[Config Instance] setPASSWORD:password];
        [[Config Instance] setIsLogin:YES];
        [[Config Instance] setIsCalculateTotal:YES];
        [[Config Instance] setUserInfo:[[NSMutableDictionary alloc]initWithDictionary:[[response mainData] objectForKey:@"v4info"]]];
        //企业版用户无法登录
        if([@"2" isEqualToString:[[[Config Instance]userInfo]objectForKey:@"usertype"]]) {
            [Common alert:@"您的号码属于政企用户，目前尚不能使用APP登录，如需通话录音可直接拨打95105856"];
            return;
        }
        [[Config Instance] setCacheKey:[NSString stringWithFormat:@"cache_%@",[[Config Instance]USERNAME]]];
        [Common setCache:DEFAULTDATA_PHONE data:[[Config Instance]USERNAME]];
        if([Common getCacheByBool:DEFAULTDATA_AUTOLOGIN]){
            [Common setCache:DEFAULTDATA_PASSWORD data:[[Config Instance]PASSWORD]];
        }else{
            [Common setCache:DEFAULTDATA_PASSWORD data:@""];
        }
        
        //拔号盘
        ACDialsViewController *dialViewController = [[ACDialsViewController alloc]init];
        dialViewController.tabBarItem.title = @"拨号盘";
        [[dialViewController tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon_dial_hover"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon_dial"]];
        [[dialViewController tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                       dictionaryWithObjectsAndKeys: [UIColor whiteColor],
                                                                       UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [[dialViewController tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                       dictionaryWithObjectsAndKeys: TABNORMALBGCOLOR,
                                                                       UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        //联系人
        UINavigationController *contactViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACContactsViewController alloc]init]];
        contactViewControllerNav.tabBarItem.title = @"通讯录";
        [[contactViewControllerNav tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon_contact_hover"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon_contact"]];
        [[contactViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                       dictionaryWithObjectsAndKeys: [UIColor whiteColor],
                                                                       UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [[contactViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                       dictionaryWithObjectsAndKeys: TABNORMALBGCOLOR,
                                                                       UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        if(IOS7){
            [[contactViewControllerNav navigationBar]setBarTintColor:MAINBG];
            [[contactViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
        }else{
            [contactViewControllerNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbg"] forBarMetrics:UIBarMetricsDefault];
        }
        
        //我的账户
        UINavigationController *accountViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACAccountViewController alloc]init]];
        accountViewControllerNav.tabBarItem.title = @"我的账户";
        [[accountViewControllerNav tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon_account_hover"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon_account"]];
        [[accountViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                 dictionaryWithObjectsAndKeys: [UIColor whiteColor],
                                                                 UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [[accountViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                 dictionaryWithObjectsAndKeys: TABNORMALBGCOLOR,
                                                                 UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        if(IOS7){
            [[accountViewControllerNav navigationBar]setBarTintColor:MAINBG];
            [[accountViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
        }else{
            [accountViewControllerNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbg"] forBarMetrics:UIBarMetricsDefault];
        }
        
        //录音管理
        UINavigationController *recordingManagerViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACRecordingManagerViewController alloc]init]];
        recordingManagerViewControllerNav.tabBarItem.title = @"我的录音";
        [[recordingManagerViewControllerNav tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon_recording_hover"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon_recording"]];
        [[recordingManagerViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                       dictionaryWithObjectsAndKeys: [UIColor whiteColor],
                                                                       UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [[recordingManagerViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                       dictionaryWithObjectsAndKeys: TABNORMALBGCOLOR,
                                                                       UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        if(IOS7){
            [[recordingManagerViewControllerNav navigationBar]setBarTintColor:MAINBG];
            [[recordingManagerViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
        }else{
            [recordingManagerViewControllerNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbg"] forBarMetrics:UIBarMetricsDefault];
        }
        //更多
        ACMoreViewController *moreViewController=[[ACMoreViewController alloc]init];
        [moreViewController checkVersion:NO];
        UINavigationController *moreViewControllerNav = [[UINavigationController alloc] initWithRootViewController:moreViewController];
        moreViewControllerNav.tabBarItem.title = @"更多";
        [[moreViewControllerNav tabBarItem] setFinishedSelectedImage:[UIImage imageNamed:@"nav_icon_more_hover"] withFinishedUnselectedImage:[UIImage imageNamed:@"nav_icon_more"]];
        [[moreViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                                dictionaryWithObjectsAndKeys: [UIColor whiteColor],
                                                                                UITextAttributeTextColor, nil] forState:UIControlStateNormal];
        [[moreViewControllerNav tabBarItem] setTitleTextAttributes:[NSDictionary
                                                                                dictionaryWithObjectsAndKeys: TABNORMALBGCOLOR,
                                                                                UITextAttributeTextColor, nil] forState:UIControlStateSelected];
        if(IOS7){
            [[moreViewControllerNav navigationBar]setBarTintColor:MAINBG];
            [[moreViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
        }else{
            [moreViewControllerNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbg"] forBarMetrics:UIBarMetricsDefault];
        }
        //添加标签控制器
        UITabBarController *_tabBarController = [[UITabBarController alloc] init];
        [_tabBarController.view setBackgroundColor:MAINBG];
        if([[[UIDevice currentDevice] systemVersion]floatValue]>=6){
            [[_tabBarController tabBar] setShadowImage:[[UIImage alloc] init]];
        }
        [[_tabBarController tabBar] setBackgroundImage:[[UIImage alloc] init]];
        _tabBarController.delegate = self;
        _tabBarController.viewControllers = [NSArray arrayWithObjects:
                                             dialViewController,
                                             contactViewControllerNav,
                                             accountViewControllerNav,
                                             recordingManagerViewControllerNav,
                                             moreViewControllerNav,
                                             nil];
        
        [self presentViewController:_tabBarController animated:YES completion:^{
            if(self.gotoAgainGesurePassword){
                UINavigationController *againSetGesturePasswordViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACAgainSetGesturePasswordViewController alloc]init]];
                if(IOS7){
                    [[againSetGesturePasswordViewControllerNav navigationBar]setBarTintColor:MAINBG];
                    [[againSetGesturePasswordViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
                }else{
                    [againSetGesturePasswordViewControllerNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbg"] forBarMetrics:UIBarMetricsDefault];
                }
                [_tabBarController presentViewController:againSetGesturePasswordViewControllerNav animated:YES completion:nil];
                self.gotoAgainGesurePassword=NO;
            }
        }];
        
    }else if([[response code] isEqualToString:@"120020"]){
        //用户不存在
        [Common alert:@"用户名或密码不正确"];
    }
    if(![response successFlag]){
        //执行失败则清空
        [Common setCache:DEFAULTDATA_PHONE data:@""];
        [Common setCache:DEFAULTDATA_PASSWORD data:@""];
    }
}

- (void)requestFailed:(int)reqCode {
    [Common alert:@"网络请求出错，请重试"];
    //执行失败则清空密码
    [Common setCache:DEFAULTDATA_PASSWORD data:@""];
}

- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableArray*)result{
    if(resultCode==RESULTCODE_ACLoginViewController_1) {
        //登录
        [Config resetConfig];
        [[Config Instance] setLoginResultDelegate:self];
        [_txtPassword setText:@""];
        [Common setCache:DEFAULTDATA_PASSWORD data:@""];
    } else if(resultCode==RESULTCODE_ACLoginViewController_2) {
        //重新登录
        [Config resetConfig];
        [[Config Instance] setLoginResultDelegate:self];
        [_txtUserName setText:@""];
        [_txtPassword setText:@""];
        [Common setCache:DEFAULTDATA_PHONE data:@""];
        [Common setCache:DEFAULTDATA_PASSWORD data:@""];
    } else if(resultCode==RESULTCODE_ACLoginViewController_3) {
        rememberPassword=[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN];
        //自动登陆
        [self autoLogin];
    }
}

- (void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController {
    unsigned long newTabIndex = tabBarController.selectedIndex;
    if (newTabIndex == m_lastTabIndex) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TabClick_ACRecordingManagerViewController object:@"load"];
    } else {
        m_lastTabIndex = newTabIndex;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *phone=_txtUserName.text;
    if(![phone isNotEmpty]) {
        [_txtPassword resignFirstResponder];
    } else {
        [self onClickLogin:nil];
    }
    return YES;
}

#pragma mark -
#pragma mark Custom Methods

- (void)rememberPassword:(id)sender
{
    rememberPassword=!rememberPassword;
    if(rememberPassword){
        [btnRememberPwdImg setImage:[UIImage imageNamed:@"login_g"] forState:UIControlStateNormal];
    }else{
        [btnRememberPwdImg setImage:[UIImage imageNamed:@"login_g_hover"] forState:UIControlStateNormal];
    }
}

- (void)autoLogin {
    NSString *userName=[Common getCache:DEFAULTDATA_PHONE];
    if([userName isNotEmpty]){
        [_txtUserName setText:userName];
        if(rememberPassword){
            NSString *password=[Common getCache:DEFAULTDATA_PASSWORD];
            if([password isNotEmpty]){
                [_txtPassword setText:password];
                [self performSelector:@selector(onClickLogin:) withObject:self afterDelay:0.5];
            }
        }
    }
}

- (void)onClickLogin:(id)sender {
    
    [self backgroundDoneEditing:nil];
    
    NSString *username=_txtUserName.text;
    NSString *password=_txtPassword.text;
    
    [Common setCacheByBool:DEFAULTDATA_AUTOLOGIN data:rememberPassword];
    
    if(![username isNotEmpty]){
        [Common alert:@"账号不能为空"];
    }else if(![password isNotEmpty]){
        [Common alert:@"密码不能为空"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:username forKey:@"username"];
        [requestParams setObject:@"c" forKey:@"loginsource"];
        [requestParams setObject:@"" forKey:@"mac"];
        [requestParams setObject:@"" forKey:@"ip"];
        [requestParams setObject:@"1" forKey:@"raflag"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest handle:@"v4Login" signKey:[_txtPassword.text md5] requestParams:requestParams];
    }
}

//注册
- (void)onClickRegister:(id)sender {
    ACRegistrationViewController *registrationViewController=[[ACRegistrationViewController alloc]init];
    [self presentViewController:registrationViewController animated:YES completion:nil];
}

//忘记密码
- (void)onClickForgetPwd:(id)sender {
    ACForgetPasswordViewController *frgetPasswordViewController=[[ACForgetPasswordViewController alloc]init];
    [self presentViewController:frgetPasswordViewController animated:YES completion:nil];
}

- (void)backgroundDoneEditing:(id)sender {
    [_txtUserName resignFirstResponder];
    [_txtPassword resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        curFrame.origin.y-=150;
        self.view.frame=curFrame;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        if(IOS7){
            curFrame.origin.y=0;
        }else{
            curFrame.origin.y=20;
        }
        self.view.frame=curFrame;
    }];
}

@end
