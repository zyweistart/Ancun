#import "ACLoginViewController.h"
#import "ACResetPasswordViewController.h"
#import "ACRegisterViewController.h"
#import "NSString+Utils.h"

@interface ACLoginViewController ()

@property (strong,nonatomic) UITextField *txtUserName;
@property (strong,nonatomic) UITextField *txtPassword;

@end

@implementation ACLoginViewController

- (id)init
{
    self = [super init];
    if (self) {
        UIControl *control=[[UIControl alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:control];
        
        self.txtUserName=[[UITextField alloc]initWithFrame:CGRectMake(4, 10, 240, 50)];
        [self.txtUserName setBorderStyle:UITextBorderStyleRoundedRect];
        [self.txtUserName setPlaceholder:@"请输入账号"];
        [control addSubview:self.txtUserName];
        self.txtPassword=[[UITextField alloc]initWithFrame:CGRectMake(4, 80, 240, 50)];
        [self.txtPassword setBorderStyle:UITextBorderStyleRoundedRect];
        [self.txtPassword setPlaceholder:@"请输入密码"];
        [self.txtPassword setSecureTextEntry:YES];
        [control addSubview:self.txtPassword];
        
        UIButton *btnLogin=[[UIButton alloc]initWithFrame:CGRectMake(30, 150, 150, 44)];
        [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        [btnLogin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnLogin addTarget:self action:@selector(goLogin:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnLogin];
        
        UIButton *btnResetPassword=[[UIButton alloc]initWithFrame:CGRectMake(30, 200, 150, 44)];
        [btnResetPassword setTitle:@"重置密码" forState:UIControlStateNormal];
        [btnResetPassword setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnResetPassword addTarget:self action:@selector(goResetPwd:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnResetPassword];
        
        UIButton *btnRegsiter=[[UIButton alloc]initWithFrame:CGRectMake(30, 260, 150, 44)];
        [btnRegsiter setTitle:@"获取登录账号" forState:UIControlStateNormal];
        [btnRegsiter setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btnRegsiter addTarget:self action:@selector(goRegsiter:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btnRegsiter];
        
        [self.txtUserName setText:@"18368013123"];
        [self.txtPassword setText:@"123456"];
        
    }
    return self;
}

- (void)goLogin:(id)sender
{
    NSString *userName=[self.txtUserName text];
    NSString *passWord=[self.txtPassword text];
    if(![userName isNotEmpty]){
        [Common alert:@"请输入账号"];
    }else if(![passWord isNotEmpty]){
        [Common alert:@"请输入密码"];
    }else{
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"login_ios" forKey:@"act"];
        [params setObject:passWord forKey:@"pwd"];
        [params setObject:userName forKey:@"mobile"];
        [params setObject:@"1" forKey:@"type"];
        [params setObject:@"132" forKey:@"imei"];
        [params setObject:@"21312" forKey:@"imsi"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest handle:@"" headParams:nil requestParams:params];
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        [[Config Instance]setIsLogin:YES];
        [Common alert:@"登陆成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [[Config Instance]setIsLogin:NO];
        [Common alert:@"登陆失败，请检查用户名或密码是否正确"];
    }
}

- (void)goResetPwd:(id)sender
{
    ACResetPasswordViewController *resetPasswordViewController=[[ACResetPasswordViewController alloc]init];
    [self.navigationController pushViewController:resetPasswordViewController animated:YES];
}

- (void)goRegsiter:(id)sender
{
    ACRegisterViewController *registerViewController=[[ACRegisterViewController alloc]init];
    [self.navigationController pushViewController:registerViewController animated:YES];
}

@end
