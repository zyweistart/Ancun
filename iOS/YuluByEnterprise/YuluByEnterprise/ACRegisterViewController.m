#import "ACRegisterViewController.h"
#import "ACNavigationWebPageViewController.h"

#define SECOND 60

@interface ACRegisterViewController ()

@end

@implementation ACRegisterViewController{
    HttpRequest *_registerHttp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACRegisterViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACRegisterViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"用户注册";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
        [self.view removeFromSuperview];
        self.view=_regFirstView;
        if(iPhone5){
            _checkbox = [[SSCheckBoxView alloc] initWithFrame:CGRectMake(30, 252, 100, 30)
                                                        style:kSSCheckBoxViewStyleGlossy
                                                      checked:YES];
        }else{
            _checkbox = [[SSCheckBoxView alloc] initWithFrame:CGRectMake(30, 200, 100, 30)
                                                        style:kSSCheckBoxViewStyleGlossy
                                                      checked:YES];
        }
        [_checkbox setText:@""];
        [_regFirstView addSubview:_checkbox];
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        switch (reqCode) {
            case REQUESTCODE_GETVERIFICATIONCODE:
                if(self.view!=_regSecondView){
                    self.view=_regSecondView;
                }
                _regBtnReVerificationCode.hidden=YES;
                _regViewVerificationCodeTip.hidden=NO;
                _second=SECOND;
                _verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
                break;
            case REQUESTCODE_SUBMITVERIFICATIONCODE:
                if(_second>0){
                    if(_verificationCodeTime){
                        [_verificationCodeTime invalidate];
                    }
                }
                self.view=_regThirdView;
                break;
            case REQUESTCODE_SIGNUP:
                [Common setCache:DEFAULTDATA_PHONE data:_phone];
                [Common setCache:DEFAULTDATA_PASSWORD data:_password];
                [Common setCacheByBool:DEFAULTDATA_AUTOLOGIN data:YES];
                self.view=_regFourthView;
                break;
            default:
                break;
        }
    }else if([[response code] isEqualToString:@"120169"]){
        //该手机号码已被注册
        switch (reqCode) {
            case REQUESTCODE_GETVERIFICATIONCODE:
                if(self.view!=_regSecondView){
                    self.view=_regSecondView;
                }
                _regBtnReVerificationCode.hidden=YES;
                _regViewVerificationCodeTip.hidden=NO;
                _second=SECOND;
                _verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
                break;

        }
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//验证号码是否已经注册过
- (IBAction) validPhoneByVerificationCode{
    _phone=_regInputPhone.text;
    if([_phone isEqualToString:@""]){
        [Common alert:@"号码不能为空"];
    }else{
        if(_checkbox.checked){
            [self getVerificationCode:nil];
        }else{
            [Common alert:@"注册前请先阅读服务条款"];
        }
    }
}

- (IBAction)getVerificationCode:(id)sender{
    _regBtnReVerificationCode.hidden=NO;
    _regViewVerificationCodeTip.hidden=YES;
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setObject:_phone forKey:@"phone"];
    [requestParams setObject:@"1" forKey:@"actype"];
    _registerHttp=[[HttpRequest alloc]init];
    [_registerHttp setDelegate:self];
    [_registerHttp setController:self];
    [_registerHttp setIsShowMessage:YES];
    [_registerHttp setMessage:@"获取验证码..."];
    [_registerHttp setRequestCode:REQUESTCODE_GETVERIFICATIONCODE];
    [_registerHttp handle:@"v4scodeGet" signKey:nil headParams:nil requestParams:requestParams];
}

- (IBAction)submitVerificationCode:(id)sender{
    _verificationCode=_regInputVerificationCode.text;
    if([_verificationCode isEqualToString:@""]){
        [Common alert:@"验证码不能为空"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_phone forKey:@"phone"];
        [requestParams setObject:@"1" forKey:@"actype"];
        [requestParams setObject:_verificationCode forKey:@"authcode"];
        _registerHttp=[[HttpRequest alloc]init];
        [_registerHttp setIsShowMessage:YES];
        [_registerHttp setDelegate:self];
        [_registerHttp setController:self];
        [_registerHttp setRequestCode:REQUESTCODE_SUBMITVERIFICATIONCODE];
        [_registerHttp handle:@"v4scodeVer" signKey:nil headParams:nil requestParams:requestParams];
    }
}

- (IBAction)setPassword:(id)sender{
    _password=_regInputPassword.text;
    NSString *rePassword=_regInputRePassword.text;
    if([_password isEqualToString:@""]){
        [Common alert:@"密码不能为空"];
    }else if([rePassword isEqualToString:@""]){
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
        _registerHttp=[[HttpRequest alloc]init];
        [_registerHttp setDelegate:self];
        [_registerHttp setController:self];
        [_registerHttp setIsShowMessage:YES];
        [_registerHttp setMessage:@"注册信息提交中..."];
        [_registerHttp setRequestCode:REQUESTCODE_SIGNUP];
        [_registerHttp handle:@"v4Signup" signKey:nil headParams:nil requestParams:requestParams];
    }
}

- (IBAction)registerDone:(id)sender{
    [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_3 requestCode:0 data:nil];
}

- (IBAction)backgroundDoneEditing:(id)sender{
    [_regInputPhone resignFirstResponder];
    [_regInputVerificationCode resignFirstResponder];
    [_regInputPassword resignFirstResponder];
    [_regInputRePassword resignFirstResponder];
}

- (IBAction)TermsOfService:(id)sender{
    ACNavigationWebPageViewController *navigationWebPageViewController=[[ACNavigationWebPageViewController alloc]initWithNavigationTitle:@"服务条款" resourcePath:@"TermsOfService"];
    navigationWebPageViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:navigationWebPageViewController animated:YES];
}

- (void)updateTimer{
    --_second;
    if(_second==0){
        _regViewVerificationCodeTip.hidden=YES;
        _regBtnReVerificationCode.hidden=NO;
        _regLblVerificationCodeSecond.text=[NSString stringWithFormat:@"%d",SECOND];
        if(_verificationCodeTime){
            [_verificationCodeTime invalidate];
        }
    }else{
        _regLblVerificationCodeSecond.text=[NSString stringWithFormat:@"%d",_second];
    }
}

@end