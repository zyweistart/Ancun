#import "ACExtractionDetailViewController.h"

@interface ACExtractionDetailViewController ()

@end

@implementation ACExtractionDetailViewController{
    HttpRequest *_detailHttp;
        
    NSMutableDictionary *_resultDictionary;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACExtractionDetailViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACExtractionDetailViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithTitle:@"返回"
                                                style:UIBarButtonItemStyleBordered
                                                target:self
                                                action:@selector(back:)];
        _resultDictionary=[[NSMutableDictionary alloc]init];
        [_resultDictionary setObject:@"1" forKey:@"accstatus"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    if(_load){
        self.navigationItem.title=@"查看提取码";
    }else{
        self.navigationItem.title=@"申请提取码";
    }
    [_lbl_accendcode setText:[_extractionDics objectForKey:@"acccode"]];
    [_lbl_accendtime setText:[_extractionDics objectForKey:@"endtime"]];
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        if(reqCode==REQUESTCODE_ACExtractionDetailViewController_cancel){
            [_resultDictionary setObject:@"2" forKey:@"accstatus"];
            [self back:nil];
            [Common alert:@"提取码已取消"];
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==1){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:_fileno forKey:@"fileno"];
            //1:生成;2:查看;3:取消;:4:短信发送（安存语录后台发送，暂不支持）
            [requestParams setObject:@"3" forKey:@"acccodeact"];
            _detailHttp=[[HttpRequest alloc]init];
            [_detailHttp setDelegate:self];
            [_detailHttp setController:self];
            [_detailHttp setIsShowMessage:YES];
            [_detailHttp setRequestCode:REQUESTCODE_ACExtractionDetailViewController_cancel];
            [_detailHttp loginhandle:@"v4recAcccode" requestParams:requestParams];
        }
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    switch (result){
        case MessageComposeResultCancelled:
            //发送取消
            break;
        case MessageComposeResultSent:
            [Common alert:@"发送成功"];
            break;
        case MessageComposeResultFailed:
            [Common alert:@"发送失败"];
            break;
        default:
            [Common alert:@"未知异常"];
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Custom Methods
- (IBAction)pasteBoard:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =[NSString stringWithFormat:@"%@",_lbl_accendcode.text];
    [Common notificationMessage:@"复制成功" inView:self.view];
}

- (IBAction)sendMessage:(id)sender{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            //收接者的号码
            picker.recipients = nil;
            //短信内容
            picker.body = [NSString stringWithFormat:@"您申请的录音提取码为：http://www.95105856.com/%@，凭该提取码可在官网公开查询、下载本条通话录音，请妥善保管。客服电话:95105856【安存科技】",[_lbl_accendcode text]];
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            [Common alert:@"设备没有短信功能"];
        }
    } else {
        [Common alert:@"当前版本暂不支持短信发送"];
    }
}

- (IBAction)cancelextraction:(id)sender{
    if([[Config Instance]isAuth:auth_v4recalter8]){
        [Common actionSheet:self message:@"确定撤销提取？" tag:1];
    }else{
        [Common alert:@"暂无权限"];
    }
}

- (void)back:(id)sender{
    [Common resultNavigationViewController:self resultDelegate:_resultDelegate resultCode:RESULTCODE_ACExtractionDetailViewController_back requestCode:0 data:_resultDictionary];
}
@end
