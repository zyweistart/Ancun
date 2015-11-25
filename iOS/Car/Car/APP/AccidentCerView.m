//
//  AccidentCerView.m
//  Car
//
//  Created by Start on 11/16/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#define GLOBAL_GETCODE_STRING @"%ds后重发"
#define GLOBAL_SECOND 60

#import "AccidentCerView.h"

@implementation AccidentCerView{
    int second;
    NSTimer *verificationCodeTime;
    XLButton *bGetCode;
}

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if(self){
        [self setBackgroundColor:BCOLORA(100, 0.5)];
        [self setUserInteractionEnabled:YES];
        CGFloat topX=64+CGHeight(20);
        if(inch35){
            topX=frame.size.height-CGHeight(440);
        }
        UIView *viewFrameChild=[[UIView alloc]initWithFrame:CGRectMake(CGWidth(10), topX, CGWidth(300), CGHeight(450))];
        viewFrameChild.layer.borderWidth=CGWidth(1);
        viewFrameChild.layer.borderColor=BCOLOR(150).CGColor;
        [viewFrameChild setBackgroundColor:BCOLOR(244)];
        [viewFrameChild setUserInteractionEnabled:YES];
        [self addSubview:viewFrameChild];
        
        self.tfCarNumber=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 10, 280, 40)];
        [self.tfCarNumber setPlaceholder:@"当事人车牌号"];
        [self.tfCarNumber setStyle:2];
        [viewFrameChild addSubview:self.tfCarNumber];
        self.tfPhone=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 60, 280, 40)];
        [self.tfPhone setPlaceholder:@"当事人手机号"];
        [self.tfPhone setStyle:2];
        [self.tfPhone setKeyboardType:UIKeyboardTypePhonePad];
        [viewFrameChild addSubview:self.tfPhone];
        self.tfCode=[[XLTextField alloc]initWithFrame:CGRectMake1(10, 110, 145, 40)];
        [self.tfCode setPlaceholder:@"请输入验证码"];
        [self.tfCode setStyle:2];
        [self.tfCode setKeyboardType:UIKeyboardTypeNamePhonePad];
        [viewFrameChild addSubview:self.tfCode];
        bGetCode=[[XLButton alloc]initWithFrame:CGRectMake1(160,110,130,40) Name:@"获取验证码" Type:3];
        [bGetCode addTarget:self action:@selector(goGetCode) forControlEvents:UIControlEventTouchUpInside];
        [viewFrameChild addSubview:bGetCode];
        self.lblCompany=[[XLLabel alloc]initWithFrame:CGRectMake1(10, 160, 280, 40) Text:@"平安保险"];
        [viewFrameChild addSubview:self.lblCompany];
        self.cameraViewPai=[[CameraView alloc]initWithFrame:CGRectMake1(10, 210, 280, 180)];
        [self.cameraViewPai.lblInfo setText:@"当事人1驾驶证、行驶证"];
        [self.cameraViewPai.currentImageView setImage:[UIImage imageNamed:@"证件小"]];
//        [self.cameraViewPai setControler:self];
        [viewFrameChild addSubview:self.cameraViewPai];
        self.bCancel=[[XLButton alloc]initWithFrame:CGRectMake1(10,400,135,40) Name:@"取消" Type:2];
        [self.bCancel addTarget:self action:@selector(goCancel:) forControlEvents:UIControlEventTouchUpInside];
        [viewFrameChild addSubview:self.bCancel];
        self.bOk=[[XLButton alloc]initWithFrame:CGRectMake1(155,400,135,40) Name:@"确定" Type:3];
        [self.bOk addTarget:self action:@selector(goOK:) forControlEvents:UIControlEventTouchUpInside];
        [viewFrameChild addSubview:self.bOk];
    }
    return self;
}

- (void)goGetCode
{
    NSString *userName=[self.tfPhone text];
    if([userName isEmpty]){
        [Common alert:@"请输入手机号"];
        return;
    }
    if(verificationCodeTime==nil){
        NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
        [params setObject:@"sendcode" forKey:@"act"];
        [params setObject:userName forKey:@"mobile"];
        [params setObject:@"3" forKey:@"type"];
        self.hRequest=[[HttpRequest alloc]initWithRequestCode:500];
        [self.hRequest setDelegate:self];
        [self.hRequest setView:self];
        [self.hRequest setIsShowFailedMessage:YES];
        [self.hRequest handleWithParams:params];
    }
}

- (void)updateTimer
{
    --second;
    if(second==0){
        [bGetCode setEnabled:YES];
        [bGetCode setTitle:@"获取校验码" forState:UIControlStateNormal];
        if(verificationCodeTime){
            [verificationCodeTime invalidate];
            verificationCodeTime=nil;
        }
    }else{
        [bGetCode setEnabled:NO];
        [bGetCode setTitle:[NSString stringWithFormat:GLOBAL_GETCODE_STRING,second] forState:UIControlStateNormal];
    }
}

- (void)goOK:(id)sender
{
    NSString *carNumber=[self.tfCarNumber text];
    if([carNumber isEmpty]){
        [Common alert:@"请输入车牌号"];
        return;
    }
    NSString *userName=[self.tfPhone text];
    if([userName isEmpty]){
        [Common alert:@"请输入手机号"];
        return;
    }
    NSString *code=[self.tfCode text];
    if([code isEmpty]){
        [Common alert:@"请输入验证码"];
        return;
    }
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"confirmInfo" forKey:@"act"];
    [params setObject:userName forKey:@"mobile"];
    [params setObject:code forKey:@"code"];
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
    [self.hRequest setDelegate:self];
    [self.hRequest setView:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

- (void)goCancel:(id)sender
{
    if([self.delegate respondsToSelector:@selector(accidentCerViewCancel:)]){
        [self.delegate accidentCerViewCancel:sender];
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        if(reqCode==500){
            second=GLOBAL_SECOND;
            [bGetCode setEnabled:NO];
            [bGetCode setTitle:[NSString stringWithFormat:GLOBAL_GETCODE_STRING,second] forState:UIControlStateNormal];
            verificationCodeTime = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        }else{
            if([self.delegate respondsToSelector:@selector(accidentCerViewOK:)]){
                [self.delegate accidentCerViewOK:self.bOk];
            }
        }
    }
}

@end