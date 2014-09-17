//
//  ACRegistrationViewController.m
//  Ancun
//
//  Created by Start on 4/2/14.
//
//

#import "ACRegistrationViewController.h"
#import "ACNavigationWebPageViewController.h"

@interface ACRegistrationViewController ()

@end

@implementation ACRegistrationViewController {
    BOOL checked;
}

- (id)init
{
    self=[super init];
    if(self){
        _type=1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    int h=0;
    if(IOS7){
        h=STATUSHEIGHT;
    }
    //背景
    [self.view setBackgroundColor:MAINBG1];
    
    float width=self.view.frame.size.width;
    float height=self.view.frame.size.height;
    UIControl *control=[[UIControl alloc]initWithFrame:CGRectMake(0, h, width, height-h)];
    
    [control addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:control];
    
    UIButton *btnBack=[[UIButton alloc]initWithFrame:CGRectMake(10, 0, 60, 30)];
    [btnBack setTitle:@"返回" forState:UIControlStateNormal];
    btnBack.titleLabel.font=[UIFont fontWithName:@"Helvetica-Bold" size:15];
    [btnBack setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnBack setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [btnBack setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btnBack addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [control addSubview:btnBack];
    
    _lblTitlte=[[UILabel alloc]initWithFrame:CGRectMake(110, 0, 100, 30)];
    _lblTitlte.font=[UIFont fontWithName:@"Helvetica-Bold" size:20];
    [_lblTitlte setText:@"注册"];
    [_lblTitlte setTextColor:[UIColor whiteColor]];
    [_lblTitlte setBackgroundColor:[UIColor clearColor]];
    [_lblTitlte setTextAlignment:NSTextAlignmentCenter];
    [control addSubview:_lblTitlte];
    
    //LOGO
    UIView *logonv=[[UIView alloc]initWithFrame:CGRectMake(width/2-106/2, inch4?70:40, 106, 103)];
    [logonv setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_logo"]]];
    [control addSubview:logonv];
    
    UIView *schedule=[[UIView alloc]initWithFrame:CGRectMake(10, inch4?210:150, 300, 66)];
    [control addSubview:schedule];
    
    UIImageView *step1=[[UIImageView alloc]initWithFrame:CGRectMake(12, 10, 26, 26)];
    [step1 setImage:[UIImage imageNamed:@"pass"]];
    [schedule addSubview:step1];
    UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 36, 50, 20)];
    lbl.font=[UIFont systemFontOfSize:12];
    [lbl setNumberOfLines:0];
    [lbl setText:@"手机验证"];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [schedule addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(39, 20, 97, 6)];
    [lbl setBackgroundColor:MAINBG2];
    [schedule addSubview:lbl];
    
    step2=[[UIImageView alloc]initWithFrame:CGRectMake(137, 10, 26, 26)];
    [step2 setImage:[UIImage imageNamed:@"wait"]];
    [schedule addSubview:step2];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(125, 36, 50, 20)];
    lbl.font=[UIFont systemFontOfSize:12];
    [lbl setNumberOfLines:0];
    [lbl setText:@"设置密码"];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [schedule addSubview:lbl];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(164, 20, 97, 6)];
    [lbl setBackgroundColor:MAINBG2];
    [schedule addSubview:lbl];
    
    step3=[[UIImageView alloc]initWithFrame:CGRectMake(262, 10, 26, 26)];
    [step3 setImage:[UIImage imageNamed:@"wait"]];
    [schedule addSubview:step3];
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(250, 36, 50, 20)];
    lbl.font=[UIFont systemFontOfSize:12];
    [lbl setNumberOfLines:0];
    [lbl setText:@"完成"];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [schedule addSubview:lbl];
    //////////第一步
    int heigh1=inch4?280:220;
    _regFirstView=[[UIControl alloc]initWithFrame:CGRectMake(0, heigh1, width, 183)];
    [_regFirstView addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [control addSubview:_regFirstView];
    _regInputPhone=[[UITextField alloc] initWithFrame:CGRectMake(width/2-271/2, 5, 271, 51)];
    [_regInputPhone setPlaceholder:@"请输入手机号码"];
    [_regInputPhone setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_input_bg"]]];
    [_regInputPhone setFont:[UIFont systemFontOfSize: 22]];
    [_regInputPhone setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_regInputPhone setTextAlignment:NSTextAlignmentCenter];
    [_regInputPhone setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_regInputPhone setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_regInputPhone setKeyboardType:UIKeyboardTypeNumberPad];
    [_regInputPhone setDelegate:self];
    [_regFirstView addSubview:_regInputPhone];
    
    checked=YES;
    _btnReadAgreementCheck=[[UIButton alloc]initWithFrame:CGRectMake(30, 84, 15, 15)];
    [_btnReadAgreementCheck setImage:[UIImage imageNamed:@"login_g"] forState:UIControlStateNormal];
    [_btnReadAgreementCheck addTarget:self action:@selector(readAgreementCheck:) forControlEvents:UIControlEventTouchUpInside];
    [_regFirstView addSubview:_btnReadAgreementCheck];
    
    _btnReadAgreement=[[UIButton alloc]initWithFrame:CGRectMake(50, 82.5, 240, 18)];
    [_btnReadAgreement setTitle:@"已阅读并同意《安存语录服务条款》" forState:UIControlStateNormal];
    _btnReadAgreement.titleLabel.font=[UIFont systemFontOfSize: 15];
    [_btnReadAgreement addTarget:self action:@selector(termsOfService:) forControlEvents:UIControlEventTouchUpInside];
    [_regFirstView addSubview:_btnReadAgreement];
    
    UIButton *btnValidPhoneByVerificationCode=[[UIButton alloc]initWithFrame:CGRectMake(width/2-271/2, 127, 271, 51)];
    [btnValidPhoneByVerificationCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    btnValidPhoneByVerificationCode.titleLabel.font=[UIFont systemFontOfSize:30];
    [btnValidPhoneByVerificationCode setBackgroundImage:[UIImage imageNamed:@"buttuon1"] forState:UIControlStateNormal];
    [btnValidPhoneByVerificationCode addTarget:self action:@selector(validPhoneByVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [_regFirstView addSubview:btnValidPhoneByVerificationCode];
    //////////第二步
    _regSecondView=[[UIControl alloc]initWithFrame:CGRectMake(0, heigh1, width, 183)];
    [_regSecondView addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [control addSubview:_regSecondView];
    _regInputVerificationCode=[[UITextField alloc] initWithFrame:CGRectMake(width/2-271/2, 5, 271, 51)];
    [_regInputVerificationCode setPlaceholder:@"请输入验证码"];
    [_regInputVerificationCode setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_input_bg"]]];
    [_regInputVerificationCode setFont:[UIFont systemFontOfSize: 22]];
    [_regInputVerificationCode setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_regInputVerificationCode setTextAlignment:NSTextAlignmentCenter];
    [_regInputVerificationCode setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_regInputVerificationCode setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_regInputVerificationCode setKeyboardType:UIKeyboardTypeNumberPad];
    [_regInputVerificationCode setDelegate:self];
    [_regSecondView addSubview:_regInputVerificationCode];
    
    _lblVerificationCodeInfo=[[UILabel alloc]initWithFrame:CGRectMake(50, 66, 240, 51)];
    [_lblVerificationCodeInfo setText:@"验证码已发送，\n58秒后，可重新获取"];
    [_lblVerificationCodeInfo setFont:[UIFont systemFontOfSize:15]];
    [_lblVerificationCodeInfo setTextColor:[UIColor whiteColor]];
    [_lblVerificationCodeInfo setBackgroundColor:[UIColor clearColor]];
    [_lblVerificationCodeInfo setNumberOfLines:0];
    [_lblVerificationCodeInfo setTextAlignment:NSTextAlignmentCenter];
    [_regSecondView addSubview:_lblVerificationCodeInfo];
    
    _btnGetVerificationCode=[[UIButton alloc]initWithFrame:CGRectMake(width/2-271/2, 66, 271, 51)];
    [_btnGetVerificationCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    _btnGetVerificationCode.titleLabel.font=[UIFont systemFontOfSize:30];
    [_btnGetVerificationCode setBackgroundImage:[UIImage imageNamed:@"buttuon1"] forState:UIControlStateNormal];
    [_btnGetVerificationCode addTarget:self action:@selector(getVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [_regSecondView addSubview:_btnGetVerificationCode];
    
    UIButton *btnSubmitVerificationCode=[[UIButton alloc]initWithFrame:CGRectMake(width/2-271/2, 127, 271, 51)];
    [btnSubmitVerificationCode setTitle:@"确认" forState:UIControlStateNormal];
    btnSubmitVerificationCode.titleLabel.font=[UIFont systemFontOfSize:30];
    [btnSubmitVerificationCode setBackgroundImage:[UIImage imageNamed:@"buttuon1"] forState:UIControlStateNormal];
    [btnSubmitVerificationCode addTarget:self action:@selector(submitVerificationCode:) forControlEvents:UIControlEventTouchUpInside];
    [_regSecondView addSubview:btnSubmitVerificationCode];
    //////////第三步
    _regThirdView=[[UIControl alloc]initWithFrame:CGRectMake(0, heigh1, width, 216)];
    [_regThirdView addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [control addSubview:_regThirdView];
    _regInputPassword=[[UITextField alloc] initWithFrame:CGRectMake(width/2-271/2, 5, 271, 51)];
    [_regInputPassword setPlaceholder:@"请输入密码"];
    [_regInputPassword setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_input_bg"]]];
    [_regInputPassword setFont:[UIFont systemFontOfSize: 22]];
    [_regInputPassword setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_regInputPassword setTextAlignment:NSTextAlignmentCenter];
    [_regInputPassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_regInputPassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_regInputPassword setSecureTextEntry:YES];
    [_regInputPassword setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_regInputPassword setDelegate:self];
    [_regThirdView addSubview:_regInputPassword];
    
    _regInputRePassword=[[UITextField alloc] initWithFrame:CGRectMake(width/2-271/2, 66, 271, 51)];
    [_regInputRePassword setPlaceholder:@"再输入一次"];
    [_regInputRePassword setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"login_input_bg"]]];
    [_regInputRePassword setFont:[UIFont systemFontOfSize: 22]];
    [_regInputRePassword setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_regInputRePassword setTextAlignment:NSTextAlignmentCenter];
    [_regInputRePassword setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [_regInputRePassword setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [_regInputRePassword setSecureTextEntry:YES];
    [_regInputRePassword setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [_regInputRePassword setDelegate:self];
    [_regThirdView addSubview:_regInputRePassword];
    
    lbl=[[UILabel alloc]initWithFrame:CGRectMake(width/2-271/2, 127, 271, 18)];
    [lbl setText:@"密码由6-16位英文字母、数字或符号组成"];
    [lbl setFont:[UIFont systemFontOfSize:12]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setTextColor:[UIColor whiteColor]];
    [lbl setBackgroundColor:[UIColor clearColor]];
    [_regThirdView addSubview:lbl];
    
    UIButton *btnSubmitPwd=[[UIButton alloc]initWithFrame:CGRectMake(width/2-271/2, 155, 271, 51)];
    [btnSubmitPwd setTitle:@"提交密码" forState:UIControlStateNormal];
    btnSubmitPwd.titleLabel.font=[UIFont systemFontOfSize:30];
    [btnSubmitPwd setBackgroundImage:[UIImage imageNamed:@"buttuon1"] forState:UIControlStateNormal];
    [btnSubmitPwd addTarget:self action:@selector(setPassword:) forControlEvents:UIControlEventTouchUpInside];
    [_regThirdView addSubview:btnSubmitPwd];
    //////////第四步
    _regFourthView=[[UIControl alloc]initWithFrame:CGRectMake(0, heigh1, width, 216)];
    [_regFourthView addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
    [control addSubview:_regFourthView];
    
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(width/2-48/2, 0, 48, 46)];
    [img1 setImage:[UIImage imageNamed:@"sucsse"]];
    [_regFourthView addSubview:img1];
    
    _lblSuccessInfo=[[UILabel alloc]initWithFrame:CGRectMake(width/2-271/2, 40, 271, 80)];
    [_lblSuccessInfo setText:@"恭喜您，成功开通\n安存语录"];
    [_lblSuccessInfo setFont:[UIFont systemFontOfSize:25]];
    [_lblSuccessInfo setTextColor:[UIColor whiteColor]];
    [_lblSuccessInfo setNumberOfLines:0];
    [_lblSuccessInfo setTextAlignment:NSTextAlignmentCenter];
    [_lblSuccessInfo setBackgroundColor:[UIColor clearColor]];
    [_regFourthView addSubview:_lblSuccessInfo];
    UIButton *btnDone=[[UIButton alloc]initWithFrame:CGRectMake(width/2-271/2, 127, 271, 51)];
    [btnDone setTitle:@"完成" forState:UIControlStateNormal];
    btnDone.titleLabel.font=[UIFont systemFontOfSize:30];
    [btnDone setBackgroundImage:[UIImage imageNamed:@"buttuon1"] forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(registerDone:) forControlEvents:UIControlEventTouchUpInside];
    [_regFourthView addSubview:btnDone];
    
    [_regFirstView setHidden:NO];
    [_regSecondView setHidden:YES];
    [_regThirdView setHidden:YES];
    [_regFourthView setHidden:YES];
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        switch (reqCode) {
            case REQUESTCODE_GETVERIFICATIONCODE:
                [_regFirstView setHidden:YES];
                [_regSecondView setHidden:NO];
                _lblVerificationCodeInfo.hidden=NO;
                _btnGetVerificationCode.hidden=YES;
                _second=SECOND;
                _verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
                break;
            case REQUESTCODE_SUBMITVERIFICATIONCODE:
                if(_second>0){
                    if(_verificationCodeTime){
                        [_verificationCodeTime invalidate];
                    }
                }
                [step2 setImage:[UIImage imageNamed:@"pass"]];
                [_regFirstView setHidden:YES];
                [_regSecondView setHidden:YES];
                [_regThirdView setHidden:NO];
                break;
            case REQUESTCODE_SIGNUP:
                [Common setCache:DEFAULTDATA_PHONE data:_phone];
                [Common setCache:DEFAULTDATA_PASSWORD data:_password];
                [Common setCacheByBool:DEFAULTDATA_AUTOLOGIN data:YES];
                [step3 setImage:[UIImage imageNamed:@"pass"]];
                [_regFirstView setHidden:YES];
                [_regSecondView setHidden:YES];
                [_regThirdView setHidden:YES];
                [_regFourthView setHidden:NO];
                break;
            default:
                break;
        }
    }else if([@"120169" isEqualToString:[response code]]||
             [@"120020" isEqualToString:[response code]]){
        //120169:该手机号码已被注册
        //120020:用户不存在
        switch (reqCode) {
            case REQUESTCODE_GETVERIFICATIONCODE:
                [_regFirstView setHidden:YES];
                [_regSecondView setHidden:NO];
                _lblVerificationCodeInfo.hidden=NO;
                _btnGetVerificationCode.hidden=YES;
                _second=SECOND;
                _verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
                break;
            case REQUESTCODE_SUBMITVERIFICATIONCODE:
                [Common alert:@"验证码有误"];
                break;
        }
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)readAgreementCheck:(id)sender
{
    checked=!checked;
    if(checked){
        [sender setImage:[UIImage imageNamed:@"login_g"] forState:UIControlStateNormal];
    }else{
        [sender setImage:[UIImage imageNamed:@"login_g_hover"] forState:UIControlStateNormal];
    }
}

//验证号码是否已经注册过
- (void)validPhoneByVerificationCode:(id)sender{
    [self backgroundDoneEditing:nil];
    _phone=_regInputPhone.text;
    if([@"" isEqualToString:_phone]){
        [Common alert:@"号码不能为空"];
    }else{
        if(checked){
            [self getVerificationCode:nil];
        }else{
            [Common alert:@"注册前请先阅读服务条款"];
        }
    }
}

- (void)getVerificationCode:(id)sender{
    [self backgroundDoneEditing:nil];
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setObject:_phone forKey:@"phone"];
    [requestParams setObject:[NSString stringWithFormat:@"%d",_type] forKey:@"actype"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest setMessage:@"获取验证码..."];
    [self.hRequest setRequestCode:REQUESTCODE_GETVERIFICATIONCODE];
    [self.hRequest handle:@"v4scodeGet" signKey:nil headParams:nil requestParams:requestParams];
}

- (void)submitVerificationCode:(id)sender{
    [self backgroundDoneEditing:nil];
    _verificationCode=_regInputVerificationCode.text;
    if([@"" isEqualToString:_verificationCode]){
        [Common alert:@"验证码不能为空"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_phone forKey:@"phone"];
        [requestParams setObject:[NSString stringWithFormat:@"%d",_type] forKey:@"actype"];
        [requestParams setObject:_verificationCode forKey:@"authcode"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setRequestCode:REQUESTCODE_SUBMITVERIFICATIONCODE];
        [self.hRequest handle:@"v4scodeVer" signKey:nil headParams:nil requestParams:requestParams];
    }
}

- (void)setPassword:(id)sender{
    [self backgroundDoneEditing:nil];
    _password=_regInputPassword.text;
    NSString *rePassword=_regInputRePassword.text;
    if([@"" isEqualToString:_password]){
        [Common alert:@"密码不能为空"];
    }else if([@"" isEqualToString:rePassword]){
        [Common alert:@"请再输入一次密码"];
    }else if(![_password isEqualToString:rePassword]){
        [Common alert:@"两次密码不相同"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_phone forKey:@"phone"];
        [requestParams setObject:[_password md5] forKey:@"password"];
        [requestParams setObject:_verificationCode forKey:@"authcode"];
        [requestParams setObject:@"c" forKey:@"signupsource"];
        [requestParams setObject:@"" forKey:@"ip"];
        [requestParams setObject:@"" forKey:@"mac"];
        [requestParams setObject:@"" forKey:@"loginflag"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest setMessage:@"注册信息提交中..."];
        [self.hRequest setRequestCode:REQUESTCODE_SIGNUP];
        [self.hRequest handle:@"v4Signup" signKey:nil headParams:nil requestParams:requestParams];
    }
}

- (void)registerDone:(id)sender{
    [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_3 requestCode:0 data:nil];
}

- (void)backgroundDoneEditing:(id)sender{
    [_regInputPhone resignFirstResponder];
    [_regInputVerificationCode resignFirstResponder];
    [_regInputPassword resignFirstResponder];
    [_regInputRePassword resignFirstResponder];
}

- (void)termsOfService:(id)sender{
    [self backgroundDoneEditing:nil];
    ACNavigationWebPageViewController *navigationWebPageViewController=[[ACNavigationWebPageViewController alloc]initWithNavigationTitle:@"服务条款" resourcePath:@"TermsOfService"];
    UINavigationController *navigationWebPageViewControllerNav=[[UINavigationController alloc]initWithRootViewController:navigationWebPageViewController];
    if(IOS7){
        [[navigationWebPageViewControllerNav navigationBar]setBarTintColor:MAINBG];
        [[navigationWebPageViewControllerNav navigationBar]setBarStyle:UIBarStyleBlackTranslucent];
    }else{
        navigationWebPageViewControllerNav.navigationBar.tintColor=MAINBG;
    }
    navigationWebPageViewController.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                                       initWithTitle:@"返回"
                                                                       style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(back:)];
    [self presentViewController:navigationWebPageViewControllerNav animated:YES completion:nil];
}

- (void)updateTimer{
    --_second;
    if(_second==0){
        _lblVerificationCodeInfo.hidden=YES;
        _btnGetVerificationCode.hidden=NO;
        _lblVerificationCodeInfo.text=[NSString stringWithFormat:@"验证码已发送，\n%d秒后，可重新获取",SECOND];
        if(_verificationCodeTime){
            [_verificationCodeTime invalidate];
        }
    }else{
        _lblVerificationCodeInfo.text=[NSString stringWithFormat:@"验证码已发送，\n%d秒后，可重新获取",_second];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        if(curFrame.origin.y>=0){
            if([_regInputPassword isFirstResponder]||[_regInputRePassword isFirstResponder]){
                curFrame.origin.y-=200;
            }else{
                curFrame.origin.y-=150;
            }
        }
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
