//
//  ACExtractionCodeDetailViewController.m
//  Ancun
//
//  Created by Start on 4/8/14.
//
//

#import "ACExtractionCodeDetailViewController.h"

@interface ACExtractionCodeDetailViewController ()

@end

@implementation ACExtractionCodeDetailViewController{
    NSDictionary *_data;
    UILabel *_lblAccendcode;
    UILabel *_lblAccendtime;
    NSMutableDictionary *_resultDictionary;
}


- (id)initWithLoad:(BOOL)load fileNo:(NSString *)fileNo extractionDics:(NSMutableDictionary*)dics
{
    self = [super init];
    if (self) {
        
        self.fileno=fileNo;
        if(load){
            self.title=@"申请提取码";
        }else{
            self.title=@"查看提取码";
        }
        
        [self.view setBackgroundColor:[UIColor whiteColor]];
        
        self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]
                                               initWithTitle:@"返回"
                                               style:UIBarButtonItemStyleBordered
                                               target:self
                                               action:@selector(back:)];
        _resultDictionary=[[NSMutableDictionary alloc]init];
        [_resultDictionary setObject:@"1" forKey:@"accstatus"];
        
        UIControl *container=nil;
        if(IOS7){
            container=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-STATUSHEIGHT-TOPNAVIGATIONHEIGHT)];
        }else{
            container=[[UIControl alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TOPNAVIGATIONHEIGHT)];
        }
        [self.view addSubview:container];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(14, 10, 291, 247)];
        [view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg2"]]];
        [container addSubview:view];
        
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 65, 41.5)];
        [lbl setFont:[UIFont systemFontOfSize:17]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"提取码:"];
        [view addSubview:lbl];
        
        _lblAccendcode=[[UILabel alloc]initWithFrame:CGRectMake(90, 0, 200, 41.5)];
        [_lblAccendcode setFont:[UIFont systemFontOfSize:17]];
        [_lblAccendcode setTextAlignment:NSTextAlignmentLeft];
        [_lblAccendcode setTextColor:[UIColor colorWithRed:(249/255.0) green:(238/255.0) blue:(48/255.0) alpha:1]];
        [_lblAccendcode setBackgroundColor:[UIColor clearColor]];
        [view addSubview:_lblAccendcode];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 41.5, 75, 41.5)];
        [lbl setFont:[UIFont systemFontOfSize:17]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"有效期:"];
        [view addSubview:lbl];
        
        _lblAccendtime=[[UILabel alloc]initWithFrame:CGRectMake(90, 41.5, 200, 41.5)];
        [_lblAccendtime setFont:[UIFont systemFontOfSize:17]];
        [_lblAccendtime setTextAlignment:NSTextAlignmentLeft];
        [_lblAccendtime setTextColor:[UIColor whiteColor]];
        [_lblAccendtime setBackgroundColor:[UIColor clearColor]];
        [view addSubview:_lblAccendtime];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 103, 271, 90)];
        [lbl setFont:[UIFont systemFontOfSize:17]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"凭提取码可在官网公开查询、下载本条通话录音;并可作为依据提交第三方，以证明录音的真实性、可靠性和法律效力"];
        [lbl setNumberOfLines:0];
        [view addSubview:lbl];
        
        lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 215, 271, 20)];
        [lbl setFont:[UIFont systemFontOfSize:15]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor colorWithRed:(5/255.0) green:(91/255.0) blue:(204/255.0) alpha:1]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"温馨提醒:请妥善保管好您的录音提取码"];
        [view addSubview:lbl];
        
        UIButton *btn1=[[UIButton alloc]initWithFrame:CGRectMake(14.5, inch4?350:265, 291, 40)];
        [btn1 setTitle:@"复制提取码" forState:UIControlStateNormal];
        btn1.titleLabel.font=[UIFont systemFontOfSize:22];
        btn1.layer.cornerRadius=5;
        btn1.layer.masksToBounds=YES;
        [btn1 setBackgroundColor:[UIColor colorWithRed:(69/255.0) green:(168/255.0) blue:(249/255.0) alpha:1]];
        [btn1 addTarget:self action:@selector(pasteBoard:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btn1];
        
        UIButton *btn2=[[UIButton alloc]initWithFrame:CGRectMake(14.5, inch4?400:315, 291, 40)];
        [btn2 setTitle:@"以短信形式改善到手机" forState:UIControlStateNormal];
        btn2.titleLabel.font=[UIFont systemFontOfSize:22];
        btn2.layer.cornerRadius=5;
        btn2.layer.masksToBounds=YES;
        [btn2 setBackgroundColor:[UIColor colorWithRed:(69/255.0) green:(168/255.0) blue:(249/255.0) alpha:1]];
        [btn2 addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btn2];
        
        UIButton *btn3=[[UIButton alloc]initWithFrame:CGRectMake(14.5, inch4?450:365, 291, 40)];
        [btn3 setTitle:@"撤销提取" forState:UIControlStateNormal];
        btn3.titleLabel.font=[UIFont systemFontOfSize:22];
        btn3.layer.cornerRadius=5;
        btn3.layer.masksToBounds=YES;
        [btn3 setBackgroundColor:[UIColor colorWithRed:(69/255.0) green:(168/255.0) blue:(249/255.0) alpha:1]];
        [btn3 addTarget:self action:@selector(cancelextraction:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:btn3];
        
        [_lblAccendcode setText:[dics objectForKey:@"acccode"]];
        [_lblAccendtime setText:[dics objectForKey:@"endtime"]];
        
    }
    return self;
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
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest setRequestCode:REQUESTCODE_ACExtractionDetailViewController_cancel];
            [self.hRequest loginhandle:@"v4recAcccode" requestParams:requestParams];
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
- (void)pasteBoard:(id)sender{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string =[NSString stringWithFormat:@"%@",_lblAccendcode.text];
    [Common alert:@"复制成功"];
}

- (void)sendMessage:(id)sender{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
            picker.messageComposeDelegate = self;
            //收接者的号码
            picker.recipients = nil;
            //短信内容
            picker.body = [NSString stringWithFormat:@"您申请的录音提取码为：http://www.95105856.com/%@，凭该提取码可在官网公开查询、下载本条通话录音，请妥善保管。客服电话:95105856【安存科技】",[_lblAccendcode text]];
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            [Common alert:@"设备没有短信功能"];
        }
    } else {
        [Common alert:@"当前版本暂不支持短信发送"];
    }
}

- (void)cancelextraction:(id)sender{
    [Common actionSheet:self message:@"确定撤销提取？" tag:1];
}

- (void)back:(id)sender{
    [Common resultNavigationViewController:self resultDelegate:_resultDelegate resultCode:RESULTCODE_ACExtractionDetailViewController_back requestCode:0 data:_resultDictionary];
}

@end
