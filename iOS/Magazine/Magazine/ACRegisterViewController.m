#import "ACRegisterViewController.h"

@interface ACRegisterViewController ()

@property (strong,nonatomic)UIView *stepView1;
@property (strong,nonatomic)UIView *stepView2;
@property (strong,nonatomic)UIView *stepView3;
@property (strong,nonatomic)UIView *stepView4;

@property (strong,nonatomic) UIButton *btnGetCaptcha;
@property (strong,nonatomic) UITextField *txtAccount;
@property (strong,nonatomic) UITextField *txtCaptcha;
@property (strong,nonatomic) UITextField *txtPassword;
@property (strong,nonatomic) UITextField *txtRePassword;


@end

@implementation ACRegisterViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title=@"注册";
        
        self.stepView1=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.stepView1];
        self.stepView2=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.stepView2];
        self.stepView3=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.stepView3];
        self.stepView4=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:self.stepView4];
        
        [self.stepView1 setHidden:NO];
        [self.stepView2 setHidden:YES];
        [self.stepView3 setHidden:YES];
        [self.stepView4 setHidden:YES];
        
        //第一步
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 10, 300, 20)];
        lbl.font=[UIFont systemFontOfSize:12];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"《中国公证》移动客户端登陆账号获取"];
        [self.stepView1 addSubview:lbl];
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 35, 300, 80)];
        lbl.font=[UIFont systemFontOfSize:12];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setNumberOfLines:0];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"订阅了印刷版《中国公证》的用户，可以开通订阅期内ipad版/iphone版访问权限，如您已订阅，请改善订阅凭证（发票或回单扫描件），姓名，地址，联系电话到54545@4531102.com，我们会根据您的订阅信息为您开通登陆账号，登际账号会改善到您的邮箱。"];
        [self.stepView1 addSubview:lbl];
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 130, 300, 40)];
        [btn setTitle:@"立即在线注册" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(goStart:) forControlEvents:UIControlEventTouchDown];
        [self.stepView1 addSubview:btn];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 175, 300, 80)];
        lbl.font=[UIFont systemFontOfSize:12];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setNumberOfLines:0];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"FAQ:\n1.授权失败，登录设备数超出限制。\n2.登录失败：没有绑定订单。\n3.账号异常：登录密码连续5次输入错误，被锁定。"];
        [self.stepView1 addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 260, 300, 20)];
        lbl.font=[UIFont systemFontOfSize:12];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor blackColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"更多问题，请联系服务热线：0571-88888888"];
        [self.stepView1 addSubview:lbl];
        //第二步
        self.txtAccount=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        [self.txtAccount setFont:[UIFont systemFontOfSize:13]];
        [self.txtAccount setPlaceholder:@"手机/电子邮箱"];
        [self.txtAccount setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.txtAccount setBorderStyle:UITextBorderStyleRoundedRect];
        [self.stepView2 addSubview:self.txtAccount];
        
        self.txtCaptcha=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 180, 30)];
        [self.txtCaptcha setFont:[UIFont systemFontOfSize:13]];
        [self.txtCaptcha setPlaceholder:@"手机/电子邮箱"];
        [self.txtCaptcha setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.txtCaptcha setBorderStyle:UITextBorderStyleRoundedRect];
        [self.stepView2 addSubview:self.txtCaptcha];
        
        self.btnGetCaptcha=[[UIButton alloc]initWithFrame:CGRectMake(200, 50, 110, 30)];
        [self.btnGetCaptcha.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [self.btnGetCaptcha setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.btnGetCaptcha setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.btnGetCaptcha setBackgroundColor:[UIColor redColor]];
        [self.btnGetCaptcha addTarget:self action:@selector(getCaptcha:) forControlEvents:UIControlEventTouchDown];
        [self.stepView2 addSubview:self.btnGetCaptcha];
        
        btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 90, 300, 30)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(goSetting:) forControlEvents:UIControlEventTouchDown];
        [self.stepView2 addSubview:btn];
        //第三步
        self.txtPassword=[[UITextField alloc]initWithFrame:CGRectMake(10, 10, 300, 30)];
        [self.txtPassword setFont:[UIFont systemFontOfSize:13]];
        [self.txtPassword setPlaceholder:@"请输入密码"];
        [self.txtPassword setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.txtPassword setBorderStyle:UITextBorderStyleRoundedRect];
        [self.stepView3 addSubview:self.txtPassword];
        
        self.txtRePassword=[[UITextField alloc]initWithFrame:CGRectMake(10, 50, 300, 30)];
        [self.txtRePassword setFont:[UIFont systemFontOfSize:13]];
        [self.txtRePassword setPlaceholder:@"请重新输入密码"];
        [self.txtRePassword setClearButtonMode:UITextFieldViewModeWhileEditing];
        [self.txtRePassword setBorderStyle:UITextBorderStyleRoundedRect];
        [self.stepView3 addSubview:self.txtRePassword];
        
        btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 90, 300, 30)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(goDone:) forControlEvents:UIControlEventTouchDown];
        [self.stepView3 addSubview:btn];
        
        //第四步
        btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 90, 300, 30)];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchDown];
        [self.stepView4 addSubview:btn];
        
    }
    return self;
}
//开始
- (void)goStart:(id)sender
{
    [self.stepView1 setHidden:YES];
    [self.stepView2 setHidden:NO];
    [self.stepView3 setHidden:YES];
    [self.stepView4 setHidden:YES];
}
//设置
- (void)goSetting:(id)sender
{
    [self.stepView1 setHidden:YES];
    [self.stepView2 setHidden:YES];
    [self.stepView3 setHidden:NO];
    [self.stepView4 setHidden:YES];
}
//完成
- (void)goDone:(id)sender
{
    [self.stepView1 setHidden:YES];
    [self.stepView2 setHidden:YES];
    [self.stepView3 setHidden:YES];
    [self.stepView4 setHidden:NO];
}
//获取验证码
- (void)getCaptcha:(id)sender
{
    [self.btnGetCaptcha setTitle:@"正在获取..." forState:UIControlStateNormal];
}
//完成跳转
- (void)done:(id)sender
{
    //完成直接跳转至登陆界面
    [self.navigationController popViewControllerAnimated:YES];
}

@end
