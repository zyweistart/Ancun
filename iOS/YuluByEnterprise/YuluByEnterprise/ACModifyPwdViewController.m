#import "ACModifyPwdViewController.h"

@interface ACModifyPwdViewController ()

@end

@implementation ACModifyPwdViewController{
    HttpRequest *_modifyPwdHttp;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACModifyPwdViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACModifyPwdViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.title=@"密码修改";
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode{
    if([response successFlag]){
        [Common alert:@"密码修改成功！"];
        //如果为自动登录则更新已保存的密码
        if((BOOL)[Common getCacheByBool:DEFAULTDATA_AUTOLOGIN]) {
            [Common setCache:DEFAULTDATA_PASSWORD data:_inputNewPassword.text];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [_inputOldPassword setText:@""];
        [_inputNewPassword setText:@""];
        [_inputReNewPassword setText:@""];
        //将光标移到第一个文本框位置
        [_inputOldPassword becomeFirstResponder];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (IBAction)submitPwdModify:(id)sender{
    NSString *oldPwd=_inputOldPassword.text;
    NSString *newPwd=_inputNewPassword.text;
    NSString *reNewPwd=_inputReNewPassword.text;
    if([oldPwd isEqualToString:@""]){
        [Common alert:@"原始密码不能为空"];
    }else if([newPwd isEqualToString:@""]){
        [Common alert:@"新密码不能为空"];
    }else if([reNewPwd isEqualToString:@""]){
        [Common alert:@"请再输入一次新密码"];
    }else if(![newPwd isEqualToString: reNewPwd]){
        [Common alert:@"两次密码输入不相同"];
    }else{
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:[oldPwd md5] forKey:@"passwordold"];
        [requestParams setObject:[newPwd md5] forKey:@"passwordnew"];
        _modifyPwdHttp=[[HttpRequest alloc]init];
        [_modifyPwdHttp setIsShowMessage:YES];
        [_modifyPwdHttp setDelegate:self];
        [_modifyPwdHttp setController:self];
        [_modifyPwdHttp loginhandle:@"v4pwdModify" requestParams:requestParams];
    }
}

- (IBAction)backgroundDoneEditing:(id)sender{
    [_inputOldPassword resignFirstResponder];
    [_inputNewPassword resignFirstResponder];
    [_inputReNewPassword resignFirstResponder];
}

@end
