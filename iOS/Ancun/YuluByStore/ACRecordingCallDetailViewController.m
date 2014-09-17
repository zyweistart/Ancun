//
//  ACRecordingCallDetailViewController.m
//  Ancun
//
//  Created by Start on 4/3/14.
//
//

#import "ACRecordingCallDetailViewController.h"
#import "ACExtractionCodeDetailViewController.h"

@interface ACRecordingCallDetailViewController () <ResultDelegate,HttpViewDelegate,UITextViewDelegate,UIActionSheetDelegate>

@end

@implementation ACRecordingCallDetailViewController{
    NSMutableDictionary *_data;
    UILabel *_lblRemarkTip;
    UITextView *_tv_remark;
    
    UIButton *_btn_notary;
    UIButton *_btn_extraction;
    NSString *_fileno;
}


- (id)initWithData:(NSDictionary *)data
{
    _data=[[NSMutableDictionary alloc]initWithDictionary:data];
    _fileno=[_data objectForKey:@"fileno"];
    self=[super init];
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
        
        UIControl *container=[[UIControl alloc]initWithFrame:self.view.bounds];
        [container addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [container setBackgroundColor:[UIColor whiteColor]];
        [self.view addSubview:container];
        
        NSArray *names=[[NSArray alloc]initWithObjects:@"主叫号码:",@"被叫号码:",@"起始时间:",@"结束时间:",@"录音时长:",@"录音到期:", nil];
        NSArray *value=[[NSArray alloc]initWithObjects:
                        [_data objectForKey:@"callerno"],
                        [_data objectForKey:@"calledno"],
                        [_data objectForKey:@"begintime"],
                        [_data objectForKey:@"endtime"],
                        [Common secondConvertFormatTimerByCn:[_data objectForKey:@"duration"]],
                        [_data objectForKey:@"recendtime"], nil];
        int vFrameWidth=291;
        int height=35;
        UIControl *vFrame=[[UIControl alloc]initWithFrame:CGRectMake(14.5, 10, vFrameWidth, 345)];
        [vFrame setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"xqbg"]]];
        [vFrame addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [container addSubview:vFrame];
        for(int i=0;i<[names count];i++){
            UIControl *view=[[UIControl alloc]initWithFrame:CGRectMake(0, i*height, vFrameWidth, height)];
            [view addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
            [vFrame addSubview:view];
            UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, 75, height)];
            [lbl setFont:[UIFont systemFontOfSize:17]];
            [lbl setTextAlignment:NSTextAlignmentRight];
            [lbl setTextColor:[UIColor whiteColor]];
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setText:[names objectAtIndex:i]];
            [view addSubview:lbl];
            lbl=[[UILabel alloc]initWithFrame:CGRectMake(105, 0, 195, height)];
            [lbl setFont:[UIFont systemFontOfSize:17]];
            [lbl setTextAlignment:NSTextAlignmentLeft];
            if(i==[names count]-1){
                [lbl setTextColor:[UIColor redColor]];
            }else{
                [lbl setTextColor:[UIColor whiteColor]];
            }
            [lbl setBackgroundColor:[UIColor clearColor]];
            [lbl setText:[value objectAtIndex:i]];
            [view addSubview:lbl];
        }
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(20, 210, 75, height)];
        [lbl setFont:[UIFont systemFontOfSize:17]];
        [lbl setTextAlignment:NSTextAlignmentLeft];
        [lbl setTextColor:[UIColor whiteColor]];
        [lbl setBackgroundColor:[UIColor clearColor]];
        [lbl setText:@"备注"];
        [vFrame addSubview:lbl];
        UIControl *view=[[UIControl alloc]initWithFrame:CGRectMake(0, 240, vFrameWidth, 110)];
        [view addTarget:self action:@selector(backgroundDoneEditing:) forControlEvents:UIControlEventTouchDown];
        [view setBackgroundColor:[UIColor clearColor]];
        [vFrame addSubview:view];
        
        _tv_remark=[[UITextView alloc]initWithFrame:CGRectMake(25, 10, 245,75)];
        [_tv_remark setDelegate:self];
        [view addSubview:_tv_remark];
        
        _lblRemarkTip=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 240, 20)];
        [_lblRemarkTip setText:@"备注内容长度请在100字以内"];
        [_lblRemarkTip setFont:[UIFont systemFontOfSize:13]];
        [_lblRemarkTip setTextColor:[UIColor grayColor]];
        [_lblRemarkTip setBackgroundColor:[UIColor clearColor]];
        [_tv_remark addSubview:_lblRemarkTip];
        
        _btn_notary=[[UIButton alloc]initWithFrame:CGRectMake(20, inch4?410:370, 127, 35)];
        _btn_notary.titleLabel.font=[UIFont systemFontOfSize:22];
        _btn_notary.layer.cornerRadius=5;
        _btn_notary.layer.masksToBounds=YES;
        [_btn_notary setBackgroundColor:[UIColor colorWithRed:(247/255.0) green:(90/255.0) blue:(83/255.0) alpha:1]];
        [_btn_notary addTarget:self action:@selector(notary:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:_btn_notary];
        
        _btn_extraction=[[UIButton alloc]initWithFrame:CGRectMake(173, inch4?410:370, 127, 35)];
        _btn_extraction.titleLabel.font=[UIFont systemFontOfSize:22];
        _btn_extraction.layer.cornerRadius=5;
        _btn_extraction.layer.masksToBounds=YES;
        [_btn_extraction setBackgroundColor:[UIColor colorWithRed:(1/255.0) green:(133/255.0) blue:(241/255.0) alpha:1]];
        [_btn_extraction addTarget:self action:@selector(extraction:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:_btn_extraction];
        
        NSString *remark=[_data objectForKey:@"remark"];
        if(![@"" isEqualToString:remark]){
            [_lblRemarkTip setHidden:YES];
            [_tv_remark setText:remark];
        }
        
        //公证
        if([@"1" isEqualToString:[_data objectForKey:@"cerflag"]]){
            [_btn_notary setTitle:@"申办公证" forState:UIControlStateNormal];
        }else if([@"2" isEqualToString:[_data objectForKey:@"cerflag"]]){
            [_btn_notary setTitle:@"取消公证" forState:UIControlStateNormal];
        }
        
        //提取码
        if([@"1" isEqualToString:[_data objectForKey:@"accstatus"]]){
            [_btn_extraction setTitle:@"查看提取码" forState:UIControlStateNormal];
        }else if([@"2" isEqualToString:[_data objectForKey:@"accstatus"]]){
            [_btn_extraction setTitle:@"申请提取码" forState:UIControlStateNormal];
        }
        
    }
    return self;
}

//后退
- (void)back:(id)sender{
    [Common resultNavigationViewController:self resultDelegate:_resultDelegate resultCode:RESULTCODE_ACRecordingDetailViewController_back requestCode:0 data:_data];
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        if(reqCode==REQUESTCODE_SUBMITREMARK){
            if(_data){
                [_data setObject:_tv_remark.text forKey:@"remark"];
            }
            [Common alert:@"备注修改成功"];
        }else if(reqCode==REQUESTCODE_APPLYNOTARY){
            [_btn_notary setTitle:@"取消公证" forState:UIControlStateNormal];
            [_data setObject:@"2" forKey:@"cerflag"];
            
            [Common alert:@"申办成功，更多信息请登录官网"];
        }else if(reqCode==REQUESTCODE_CANCELNOTARY){
            [_btn_notary setTitle:@"申办公证" forState:UIControlStateNormal];
            [_data setObject:@"1" forKey:@"cerflag"];
            
            [Common alert:@"取消成功"];
        }else if(reqCode==REQUESTCODE_ACExtractionDetailViewController_apply||
                 reqCode==REQUESTCODE_ACExtractionDetailViewController_view){
            [_btn_extraction setTitle:@"查看提取码" forState:UIControlStateNormal];
            [_data setObject:@"1" forKey:@"accstatus"];
//            ACExtractionDetailViewController *extractionDetailViewController=[[ACExtractionDetailViewController alloc]init];
//            [extractionDetailViewController setFileno:_fileno];
//            if(reqCode==REQUESTCODE_ACExtractionDetailViewController_apply){
//                [extractionDetailViewController setLoad:NO];
//            }else{
//                [extractionDetailViewController setLoad:YES];
//            }
//            [extractionDetailViewController setResultDelegate:self];
//            [extractionDetailViewController setExtractionDics:[[response mainData]objectForKey:@"acccodeinfo"]];
//            extractionDetailViewController.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:extractionDetailViewController animated:YES];
            
            
            
            
            
            ACExtractionCodeDetailViewController *extractionDetailViewController=[[ACExtractionCodeDetailViewController alloc]initWithLoad:reqCode==REQUESTCODE_ACExtractionDetailViewController_apply fileNo:_fileno extractionDics:[[response mainData]objectForKey:@"acccodeinfo"]];
            [extractionDetailViewController setResultDelegate:self];
            
//            [extractionDetailViewController setFileno:_fileno];
//            if(reqCode==REQUESTCODE_ACExtractionDetailViewController_apply){
//                [extractionDetailViewController setLoad:NO];
//            }else{
//                [extractionDetailViewController setLoad:YES];
//            }
//            [extractionDetailViewController setExtractionDics:[[response mainData]objectForKey:@"acccodeinfo"]];
            
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
        if([@"2" isEqualToString:[result objectForKey:@"accstatus"]]){
            [_btn_extraction setTitle:@"申请提取码" forState:UIControlStateNormal];
            [_data setObject:@"2" forKey:@"accstatus"];
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
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest setRequestCode:REQUESTCODE_APPLYNOTARY];
            [self.hRequest loginhandle:@"v4recCer" requestParams:requestParams];
        }
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:_fileno forKey:@"fileno"];
            //1:取消出证;2:申请出证
            [requestParams setObject:@"1" forKey:@"cerflag"];
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest setRequestCode:REQUESTCODE_CANCELNOTARY];
            [self.hRequest loginhandle:@"v4recCer" requestParams:requestParams];
        }
    }else if(actionSheet.tag==3){
        if(buttonIndex==0){
            NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
            [requestParams setObject:_fileno forKey:@"fileno"];
            //1:生成;2:查看;3:取消;:4:短信发送（安存语录后台发送，暂不支持）
            [requestParams setObject:@"1" forKey:@"acccodeact"];
            [requestParams setObject:@"10" forKey:@"vtime"];
            self.hRequest=[[HttpRequest alloc]init];
            [self.hRequest setDelegate:self];
            [self.hRequest setController:self];
            [self.hRequest setIsShowMessage:YES];
            [self.hRequest setRequestCode:REQUESTCODE_ACExtractionDetailViewController_apply];
            [self.hRequest loginhandle:@"v4recAcccode" requestParams:requestParams];
        }
    }
}

- (void)notary:(id)sender {
    [self backgroundDoneEditing:nil];
    if([@"1" isEqualToString:[_data objectForKey:@"cerflag"]]){
        [Common actionSheet:self message:@"您确定将该录音提交至公证机构申办公证吗？" tag:1];
    }else if([@"2" isEqualToString:[_data objectForKey:@"cerflag"]]){
        [Common actionSheet:self message:@"您确定要取消该录音申办公证吗？" tag:2];
    }
}

- (void)extraction:(id)sender {
    [self backgroundDoneEditing:nil];
    if([@"1" isEqualToString:[_data objectForKey:@"accstatus"]]){
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_fileno forKey:@"fileno"];
        //1:生成;2:查看;3:取消;:4:短信发送（安存语录后台发送，暂不支持）
        [requestParams setObject:@"2" forKey:@"acccodeact"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest setRequestCode:REQUESTCODE_ACExtractionDetailViewController_view];
        [self.hRequest loginhandle:@"v4recAcccode" requestParams:requestParams];
    }else if([[_data objectForKey:@"accstatus"] isEqualToString:@"2"]){
        [Common actionSheet:self message:@"凭提取码可在官网公开查询、验证本条通话录音，确定申请？" tag:3];
    }
}

//提交备注
- (void)submitRemark:(id)sender{
    [self backgroundDoneEditing:nil];
    NSString *remark=_tv_remark.text;
    if([@"" isEqualToString:remark]){
        [Common alert:@"请输入备注内容"];
    } else if([remark length]>100) {
        [Common alert:@"备注长度请在100字以内"];
    } else {
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:_fileno forKey:@"fileno"];
        [requestParams setObject:remark forKey:@"remark"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest setRequestCode:REQUESTCODE_SUBMITREMARK];
        [self.hRequest loginhandle:@"v4recRemark" requestParams:requestParams];
    }
}

- (void)backgroundDoneEditing:(id)sender {
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
        if(IOS7){
            curFrame.origin.y=64;
        }else{
            curFrame.origin.y=0;
        }
        self.view.frame=curFrame;
    }];
}

@end