#import "ACForgetPwdViewController.h"

#define SECOND 60

@interface ACForgetPwdViewController ()

@end

@implementation ACForgetPwdViewController{
    HttpRequest *_forgetPwdHttp;
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACForgetPwdViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACForgetPwdViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.navigationItem.title=@"找回密码";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
        [self.view removeFromSuperview];
        self.view=_regFirstView;
    }
    return self;
}

- (IBAction)backgroundDoneEditing:(id)sender {
    [_regInputPhone resignFirstResponder];
    [_regInputVerificationCode resignFirstResponder];
    [_regInputPassword resignFirstResponder];
    [_regInputRePassword resignFirstResponder];
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode {
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
                self.view=_regFourthView;
                [Common setCache:DEFAULTDATA_PHONE data:_phone];
                [Common setCache:DEFAULTDATA_PASSWORD data:_regInputPassword.text];
                [Common setCacheByBool:DEFAULTDATA_AUTOLOGIN data:YES];
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

- (void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//验证号码是否已经注册过
- (IBAction)validPhoneByVerificationCode{
    _phone=_regInputPhone.text;
    if([_phone isEqualToString:@""]){
        [Common alert:@"号码不能为空"];
    }else{
        [self getVerificationCode:nil];
    }
}

- (IBAction)getVerificationCode:(id)sender{
    _regBtnReVerificationCode.hidden=NO;
    _regViewVerificationCodeTip.hidden=YES;
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setObject:_phone forKey:@"phone"];
    [requestParams setObject:@"2" forKey:@"actype"];
    _forgetPwdHttp=[[HttpRequest alloc]init];
    [_forgetPwdHttp setDelegate:self];
    [_forgetPwdHttp setController:self];
    [_forgetPwdHttp setIsShowMessage:YES];
    [_forgetPwdHttp setMessage:@"获取验证码..."];
    [_forgetPwdHttp setRequestCode:REQUESTCODE_GETVERIFICATIONCODE];
    [_forgetPwdHttp handle:@"v4scodeGet" signKey:nil headParams:nil requestParams:requestParams];
}

- (IBAction)submitVerificationCode:(id)sender{
    _verificationCode=_regInputVerificationCode.text;
    if([_verificationCode isEqualToString:@""]){
        [Common alert:@"验证码不能为空"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_phone forKey:@"phone"];
        [requestParams setObject:@"2" forKey:@"actype"];
        [requestParams setObject:_verificationCode forKey:@"authcode"];
        _forgetPwdHttp=[[HttpRequest alloc]init];
        [_forgetPwdHttp setDelegate:self];
        [_forgetPwdHttp setController:self];
        [_forgetPwdHttp setIsShowMessage:YES];
        [_forgetPwdHttp setRequestCode:REQUESTCODE_SUBMITVERIFICATIONCODE];
        [_forgetPwdHttp handle:@"v4scodeVer" signKey:nil headParams:nil requestParams:requestParams];
    }
}

- (IBAction)setPassword:(id)sender{
    NSString *password=_regInputPassword.text;
    NSString *rePassword=_regInputRePassword.text;
    if([password isEqualToString:@""]){
        [Common alert:@"密码不能为空"];
    }else if([rePassword isEqualToString:@""]){
        [Common alert:@"请再输入一次密码"];
    }else if(![password isEqualToString:rePassword]){
        [Common alert:@"两次密码不相同"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_phone forKey:@"phone"];
        [requestParams setObject:[password md5] forKey:@"password"];
        [requestParams setObject:_verificationCode forKey:@"authcode"];
        [requestParams setObject:@"c" forKey:@"operatesource"];
        [requestParams setObject:@"" forKey:@"ip"];
        [requestParams setObject:@"" forKey:@"mac"];
        [requestParams setObject:@"" forKey:@"raflag"];
        _forgetPwdHttp=[[HttpRequest alloc]init];
        [_forgetPwdHttp setDelegate:self];
        [_forgetPwdHttp setController:self];
        [_forgetPwdHttp setIsShowMessage:YES];
        [_forgetPwdHttp setRequestCode:REQUESTCODE_SIGNUP];
        [_forgetPwdHttp handle:@"v4pwdReset" signKey:nil headParams:nil requestParams:requestParams];
    }
}

- (IBAction)forgetPwdDone:(id)sender{
    [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_3 requestCode:0 data:nil];
}

@end