#import "ACRecordingDetailViewController.h"
#import "ACExtractionDetailViewController.h"
#import "ACNotaryDetailViewController.h"

@interface ACRecordingDetailViewController ()

@end

@implementation ACRecordingDetailViewController{
    HttpRequest *_recordingDetailHttp;
}

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACRecordingDetailViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACRecordingDetailViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.navigationItem.title=@"录音详细";
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                 initWithBarButtonSystemItem: UIBarButtonSystemItemSave
                                                 target:self
                                                 action:@selector(submitRemark:)];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setObject:@"1" forKey:@"status"];
    [requestParams setObject:_fileno forKey:@"fileno"];
    _recordingDetailHttp=[[HttpRequest alloc]init];
    [_recordingDetailHttp setDelegate:self];
    [_recordingDetailHttp setRequestCode:REQUESTCODE_GETINFO];
    [_recordingDetailHttp setController:self];
    [_recordingDetailHttp loginhandle:@"v4recGet" requestParams:requestParams];
}
#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        if(reqCode==REQUESTCODE_GETINFO){
//            _mainData=[[NSMutableDictionary alloc]init];
            _mainData=[[NSMutableDictionary alloc]initWithDictionary:[[response mainData]objectForKey:@"recinfo"]];
            
            _lbl_callerno.text=[_mainData objectForKey:@"callerno"];
            _lbl_calledno.text=[_mainData objectForKey:@"calledno"];
            _lbl_begintime.text=[_mainData objectForKey:@"begintime"];
            _lbl_endtime.text=[_mainData objectForKey:@"endtime"];
            _lbl_duration.text=[Common secondConvertFormatTimerByCn:[_mainData objectForKey:@"duration"]];
            _tv_remark.text=[_mainData objectForKey:@"remark"];
            //公证
            if([[_mainData objectForKey:@"cerflag"] isEqualToString:@"1"]){
                [_btn_notary setTitle:@"申办公证" forState:UIControlStateNormal];
            }else if([[_mainData objectForKey:@"cerflag"] isEqualToString:@"2"]){
                [_btn_notary setTitle:@"取消公证" forState:UIControlStateNormal];
            }
            //提取码
            if([[_mainData objectForKey:@"accstatus"] isEqualToString:@"1"]){
                [_btn_extraction setTitle:@"查看提取码" forState:UIControlStateNormal];
            }else if([[_mainData objectForKey:@"accstatus"] isEqualToString:@"2"]){
                [_btn_extraction setTitle:@"申请提取码" forState:UIControlStateNormal];
            }
        }else if(reqCode==REQUESTCODE_SUBMITREMARK){
            if(_mainData){
                [_mainData setObject:_tv_remark.text forKey:@"remark"];
            }
            [Common notificationMessage:@"备注修改成功" inView:self.view];
        }else if(reqCode==REQUESTCODE_APPLYNOTARY){
            [_btn_notary setTitle:@"取消公证" forState:UIControlStateNormal];
            [_mainData setObject:@"2" forKey:@"cerflag"];
            
            ACNotaryDetailViewController *notaryDetailViewController=[[ACNotaryDetailViewController alloc]init];
            notaryDetailViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:notaryDetailViewController animated:YES];
        }else if(reqCode==REQUESTCODE_CANCELNOTARY){
            [_btn_notary setTitle:@"申办公证" forState:UIControlStateNormal];
            [_mainData setObject:@"1" forKey:@"cerflag"];
            
            [Common notificationMessage:@"取消成功" inView:self.view];
        }else if(reqCode==REQUESTCODE_ACExtractionDetailViewController_apply||
                 reqCode==REQUESTCODE_ACExtractionDetailViewController_view){
            [_btn_extraction setTitle:@"查看提取码" forState:UIControlStateNormal];
            [_mainData setObject:@"1" forKey:@"accstatus"];
            ACExtractionDetailViewController *extractionDetailViewController=[[ACExtractionDetailViewController alloc]init];
            [extractionDetailViewController setFileno:_fileno];
            if(reqCode==REQUESTCODE_ACExtractionDetailViewController_apply){
                [extractionDetailViewController setLoad:NO];
            }else{
                [extractionDetailViewController setLoad:YES];
            }
            [extractionDetailViewController setResultDelegate:self];
            [extractionDetailViewController setExtractionDics:[[response mainData]objectForKey:@"acccodeinfo"]];
            extractionDetailViewController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:extractionDetailViewController animated:YES];
        }
        NSString *remark=_tv_remark.text;
        if([remark isEqualToString:@""]){
            _lblRemarkTip.hidden=NO;
        } else {
            _lblRemarkTip.hidden=YES;
        }
    }
}

- (void)onControllerResult:(NSInteger)resultCode requestCode:(NSInteger)requestCode data:(NSMutableDictionary*)result{
    if(resultCode==RESULTCODE_ACExtractionDetailViewController_back){
        if([[result objectForKey:@"accstatus"] isEqualToString:@"2"]){
            [_btn_extraction setTitle:@"申请提取码" forState:UIControlStateNormal];
            [_mainData setObject:@"2" forKey:@"accstatus"];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==1){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:_fileno forKey:@"fileno"];
            //1:取消出证;2:申请出证
            [requestParams setObject:@"2" forKey:@"cerflag"];
            _recordingDetailHttp=[[HttpRequest alloc]init];
            [_recordingDetailHttp setDelegate:self];
            [_recordingDetailHttp setController:self];
            [_recordingDetailHttp setRequestCode:REQUESTCODE_APPLYNOTARY];
            [_recordingDetailHttp loginhandle:@"v4recCer" requestParams:requestParams];
        }
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:_fileno forKey:@"fileno"];
            //1:取消出证;2:申请出证
            [requestParams setObject:@"1" forKey:@"cerflag"];
            _recordingDetailHttp=[[HttpRequest alloc]init];
            [_recordingDetailHttp setDelegate:self];
            [_recordingDetailHttp setController:self];
            [_recordingDetailHttp setRequestCode:REQUESTCODE_CANCELNOTARY];
            [_recordingDetailHttp loginhandle:@"v4recCer" requestParams:requestParams];
        }
    }else if(actionSheet.tag==3){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:_fileno forKey:@"fileno"];
            //1:生成;2:查看;3:取消;:4:短信发送（安存语录后台发送，暂不支持）
            [requestParams setObject:@"1" forKey:@"acccodeact"];
            [requestParams setObject:@"10" forKey:@"vtime"];
            _recordingDetailHttp=[[HttpRequest alloc]init];
            [_recordingDetailHttp setDelegate:self];
            [_recordingDetailHttp setController:self];
            [_recordingDetailHttp setRequestCode:REQUESTCODE_ACExtractionDetailViewController_apply];
            [_recordingDetailHttp loginhandle:@"v4recAcccode" requestParams:requestParams];
        }
    }
}

#pragma mark -
#pragma mark Custom Methods

- (IBAction)backgroundDoneEditing:(id)sender {
    [_tv_remark resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    _lblRemarkTip.hidden=YES;
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        curFrame.origin.y-=150;
        self.view.frame=curFrame;
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSString *remark=_tv_remark.text;
    if([remark isEqualToString:@""]){
        _lblRemarkTip.hidden=NO;
    } else {
        _lblRemarkTip.hidden=YES;
    }
    __block CGRect curFrame=self.view.frame;
    [UIView animateWithDuration:0.3f animations:^{
        curFrame.origin.y=0;
        self.view.frame=curFrame;
    }];
}

- (IBAction)notary:(id)sender {
    if([[Config Instance] isMaster]){
        if([[_mainData objectForKey:@"cerflag"] isEqualToString:@"1"]){
            [Common actionSheet:self message:@"您确定将该录音提交至公证机构申办公证吗？" tag:1];
        }else if([[_mainData objectForKey:@"cerflag"] isEqualToString:@"2"]){
            [Common actionSheet:self message:@"您确定要取消该录音申办公证吗？" tag:2];
        }
    }else{
        [Common alert:@"暂无权限"];
    }
}

- (IBAction)extraction:(id)sender {
    if([[_mainData objectForKey:@"accstatus"] isEqualToString:@"1"]){
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_fileno forKey:@"fileno"];
        //1:生成;2:查看;3:取消;:4:短信发送（安存语录后台发送，暂不支持）
        [requestParams setObject:@"2" forKey:@"acccodeact"];
        _recordingDetailHttp=[[HttpRequest alloc]init];
        [_recordingDetailHttp setDelegate:self];
        [_recordingDetailHttp setController:self];
        [_recordingDetailHttp setRequestCode:REQUESTCODE_ACExtractionDetailViewController_view];
        [_recordingDetailHttp loginhandle:@"v4recAcccode" requestParams:requestParams];
    }else if([[_mainData objectForKey:@"accstatus"] isEqualToString:@"2"]){
        if([[Config Instance]isAuth:auth_v4recalter8]){
            [Common actionSheet:self message:@"凭提取码可在官网公开查询、验证本条通话录音，确定申请？" tag:3];
        }else{
            [Common alert:@"暂无权限"];
        }
    }
}

//后退
- (void)back:(id)sender{
    [Common resultNavigationViewController:self resultDelegate:_resultDelegate resultCode:RESULTCODE_ACRecordingDetailViewController_back requestCode:0 data:_mainData];
}

//提交备注
- (void)submitRemark:(id)sender{
    if([[Config Instance]isAuth:auth_v4recremark]){
        NSString *remark=_tv_remark.text;
        if([remark isEqualToString:@""]){
            [Common alert:@"请输入备注内容"];
        } else if([remark length]>100) {
            [Common alert:@"备注长度请在100字以内"];
        } else {
            [_tv_remark resignFirstResponder];
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:_fileno forKey:@"fileno"];
            [requestParams setObject:remark forKey:@"remark"];
            _recordingDetailHttp=[[HttpRequest alloc]init];
            [_recordingDetailHttp setDelegate:self];
            [_recordingDetailHttp setController:self];
            [_recordingDetailHttp setIsShowMessage:YES];
            [_recordingDetailHttp setRequestCode:REQUESTCODE_SUBMITREMARK];
            [_recordingDetailHttp loginhandle:@"v4recRemark" requestParams:requestParams];
        }
    }else{
        [Common alert:@"暂无权限"];
    }
}

@end
