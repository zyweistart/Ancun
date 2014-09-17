#import "ACLoginViewController.h"
#import "ACDialViewController.h"
#import "ACContactsViewController.h"
#import "ACAccountViewController.h"
#import "ACOldAccountViewController.h"
#import "ACRecordingManagerViewController.h"
#import "ACMoreViewController.h"
#import "ACRegisterViewController.h"
#import "ACForgetPwdViewController.h"
#import "SSCheckBoxView.h"
#import "ACRecordingManagerListViewController.h"

@interface ACLoginViewController ()

- (void)autoLogin;

@end

@implementation ACLoginViewController {
    
    UITextField *_txtUserName;
    UITextField *_txtPassword;
    
    SSCheckBoxView *_checkbox;
    
    int m_lastTabIndex;
    
    HttpRequest *_loginHttp;
    
}

- (id)init {
    self=[super init];
    if(self) {
        //登录代理
        [[Config Instance] setLoginResultDelegate:self];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    //背景
    [control setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:iPhone5?@"login_gb-568h":@"login_gb"]]];
    [self.view addSubview:control];
    //LOGO
    UIView *logonv=[[UIView alloc]initWithFrame:CGRectMake(width/2-53.5, iPhone5?55:40, 107, 82)];
    [logonv setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_logo"]]];
    [control addSubview:logonv];
    //登录输入框
    UIView *inputView=[[UIView alloc]initWithFrame:CGRectMake(width/2-131, iPhone5?195:160, 262, 75)];
    [inputView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_input_gb"]]];
    [control addSubview:inputView];
    //账户输入框
    _txtUserName=[[UITextField alloc] initWithFrame:CGRectMake(40, 5, 210, 27.5)];
    [_txtUserName setPlaceholder:@"请输入账号"];
    [_txtUserName setFont:[UIFont systemFontOfSize: 12.0]];
    
    [_txtUserName setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_txtUserName setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_txtUserName setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_txtUserName setKeyboardType:UIKeyboardTypePhonePad];
    [inputView addSubview:_txtUserName];
    //密码输入框
    _txtPassword=[[UITextField alloc] initWithFrame:CGRectMake(40, 42.5, 210, 27.5)];
    [_txtPassword setPlaceholder:@"请输入密码"];
    [_txtPassword setFont:[UIFont systemFontOfSize: 12.0]];
    [_txtPassword setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_txtPassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [_txtPassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_txtPassword setSecureTextEntry:YES];
    [_txtPassword setDelegate:self];
    [_txtPassword setReturnKeyType:UIReturnKeyDone];
    [inputView addSubview:_txtPassword];
    //记住密码复选框
    _checkbox = [[SSCheckBoxView alloc]
                 initWithFrame:CGRectMake(25, iPhone5?296:256, 25, 25)
                 style:kSSCheckBoxViewStyleGlossy
                 checked:![Common getCacheByBool:DEFAULTDATA_FIRSTLOGIN]?YES:[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN]];
    [control addSubview:_checkbox];
    //记住密码文字
    UILabel *lblcheckboxtxt=[[UILabel alloc]initWithFrame:CGRectMake(55, iPhone5?305:265, 50, 18)];
    lblcheckboxtxt.font=[UIFont systemFontOfSize:12.0];
    [lblcheckboxtxt setText:@"记住密码"];
    [lblcheckboxtxt setTextColor:[UIColor whiteColor]];
    [lblcheckboxtxt setBackgroundColor:[UIColor clearColor]];
    [control addSubview:lblcheckboxtxt];
    //找回密码
    UIButton *btnForgetPwd=[[UIButton alloc]initWithFrame:CGRectMake(width/2+60, iPhone5?305:265, 68, 18)];
    btnForgetPwd.titleLabel.font=[UIFont systemFontOfSize: 10.0];
    [btnForgetPwd setTitle:@"找回密码" forState:UIControlStateNormal];
    [btnForgetPwd setBackgroundImage:[UIImage imageNamed:@"login_forgetpwd_gb"] forState:UIControlStateNormal];
    [btnForgetPwd addTarget:self action:@selector(onClickForgetPwd:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnForgetPwd];
    //登录按钮
    UIButton *btnLogin=[[UIButton alloc]initWithFrame:CGRectMake(width/2-131, iPhone5?370:320, 262, 32)];
    [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [btnLogin setBackgroundImage:[UIImage imageNamed:@"button_gb"] forState:UIControlStateNormal];
    [btnLogin addTarget:self action:@selector(onClickLogin:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnLogin];
    
    UILabel *lblTipTxt=[[UILabel alloc]initWithFrame:CGRectMake(width/2-147.5, iPhone5?420:370, 295, 64)];
    lblTipTxt.font=[UIFont systemFontOfSize:12.0];
    [lblTipTxt setNumberOfLines:0];
    [lblTipTxt setText:@"请使用本机号码注册或登录，非本机号码登录时通话录音将无法被正确保全."];
    [lblTipTxt setTextColor:[UIColor whiteColor]];
    [lblTipTxt setBackgroundColor:[UIColor clearColor]];
    [control addSubview:lblTipTxt];
    
    //触摸屏幕事件
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    
    [self autoLogin];
    
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode{
    if([response successFlag]){
        NSString *phone=_txtUserName.text;
        [[Config Instance] setIsLogin:YES];
        [[Config Instance] setIsCalculateTotal:YES];
        [[Config Instance] setUserInfo:[[response mainData] objectForKey:@"v4info"]];
        if(![[Config Instance]isMaster]){
            //如果为主账户则解析权限列表
           [[Config Instance] setUserAuthList:[XML analysisAuth:[response responseString]]]; 
        }
        //个人用户无法登录
        if([@"1" isEqualToString:[[[Config Instance]userInfo]objectForKey:@"usertype"]]) {
            [Common alert:@"仅适用于企业及机构手机用户"];
            return;
        }
        [[Config Instance] setCacheKey:[NSString stringWithFormat:@"cache_%@",phone]];
        if(![Common getCacheByBool:DEFAULTDATA_FIRSTLOGIN]){
            //TODO:第一次登录
        }
        [Common setCacheByBool:DEFAULTDATA_FIRSTLOGIN data:YES];
        [Common setCache:DEFAULTDATA_PHONE data:phone];
        if([Common getCacheByBool:DEFAULTDATA_AUTOLOGIN]){
            [Common setCache:DEFAULTDATA_PASSWORD data:_txtPassword.text];
        }else{
            [Common setCache:DEFAULTDATA_PASSWORD data:@""];
        }
        //拔号盘
        UINavigationController *dialViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACDialViewController alloc]init]];
        //是否隐藏导航条
        dialViewControllerNav.navigationBarHidden = YES;
        //联系人
        UINavigationController *contactViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACContactsViewController alloc]init]];
        contactViewControllerNav.navigationBar.tintColor=NAVCOLOR;
        //我的账户
        UINavigationController *accountViewControllerNav;
        if([[Config Instance]isOldUser]) {
            accountViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACOldAccountViewController alloc]init]];
        } else {
            accountViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACAccountViewController alloc]init]];
        }
        accountViewControllerNav.navigationBar.tintColor=NAVCOLOR;
        //录音管理
        UINavigationController *recordingManagerViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACRecordingManagerViewController alloc]init]];
        recordingManagerViewControllerNav.navigationBar.tintColor=NAVCOLOR;
        //更多
        UINavigationController *moreViewControllerNav = [[UINavigationController alloc] initWithRootViewController:[[ACMoreViewController alloc]init]];
        moreViewControllerNav.navigationBar.tintColor=NAVCOLOR;
        
        //添加标签控制器
        UITabBarController *_tabBarController = [[UITabBarController alloc] init];
        _tabBarController.delegate = self;
        _tabBarController.viewControllers = [NSArray arrayWithObjects:
                                             dialViewControllerNav,
                                             contactViewControllerNav,
//                                             accountViewControllerNav,
                                             recordingManagerViewControllerNav,
                                             moreViewControllerNav,
                                             nil];
        [self presentViewController:_tabBarController animated:YES completion:nil];
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
    [Common notificationMessage:@"网络请求出错，请重试" inView:self.view];
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
        //自动登陆
        [self autoLogin];
    }
}

- (void)tabBarController:(UITabBarController*)tabBarController didSelectViewController:(UIViewController*)viewController {
    int newTabIndex = tabBarController.selectedIndex;
    if (newTabIndex == m_lastTabIndex) {
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_TabClick_ACRecordingManagerViewController object:@"load"];
    } else {
        m_lastTabIndex = newTabIndex;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *phone=_txtUserName.text;
    if(phone==nil||[@"" isEqualToString:phone]) {
        [_txtPassword resignFirstResponder];
    } else {
        [self onClickLogin:nil];
    }
    return YES;
}

#pragma mark -
#pragma mark Custom Methods

- (void)autoLogin {
    NSString *phone=[Common getCache:DEFAULTDATA_PHONE];
    if(phone!=nil&&![@"" isEqualToString:phone]){
        [_txtUserName setText:phone];
        NSString *password=[Common getCache:DEFAULTDATA_PASSWORD];
        if(password!=nil&&![@"" isEqualToString:password]){
            [_txtPassword setText:password];
            [_checkbox setChecked:[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN]];
            if([Common getCacheByBool:DEFAULTDATA_AUTOLOGIN]){
                [self performSelector:@selector(onClickLogin:) withObject:self afterDelay:0.5];
            }
        }
    }
}

- (void)onClickLogin:(id)sender {
    
    [self backgroundDoneEditing:nil];
    
    NSString *phone=_txtUserName.text;
    NSString *password=_txtPassword.text;
    
    [Common setCacheByBool:DEFAULTDATA_AUTOLOGIN data:[_checkbox checked]];
    
    if(phone==nil||[phone isEqualToString:@""]){
        [Common notificationMessage:@"账号不能为空" inView:self.view];
    }else if(password==nil||[password isEqualToString:@""]){
        [Common notificationMessage:@"密码不能为空" inView:self.view];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:phone forKey:@"username"];
        [requestParams setObject:@"c" forKey:@"loginsource"];
        [requestParams setObject:@"" forKey:@"mac"];
        [requestParams setObject:@"" forKey:@"ip"];
        [requestParams setObject:@"1" forKey:@"raflag"];
        _loginHttp=[[HttpRequest alloc]init];
        [_loginHttp setIsShowMessage:YES];
        [_loginHttp setDelegate:self];
        [_loginHttp setController:self];
        [_loginHttp handle:@"v4Login" signKey:[_txtPassword.text md5] requestParams:requestParams];
    }
}

//忘记密码
- (void)onClickForgetPwd:(id)sender {
    ACForgetPwdViewController *forgetPwdViewController=[[ACForgetPwdViewController alloc]init];
    UINavigationController *forgetPwdViewControllerNav = [[UINavigationController alloc] initWithRootViewController:forgetPwdViewController];
    forgetPwdViewControllerNav.navigationBar.tintColor=NAVCOLOR;
    [self presentViewController:forgetPwdViewControllerNav animated:YES completion:nil];
}

- (void)backgroundDoneEditing:(id)sender {
    [_txtUserName resignFirstResponder];
    [_txtPassword resignFirstResponder];
}

@end
