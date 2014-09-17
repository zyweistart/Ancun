#import "ACDialsViewController.h"
#import "LongPressButton.h"

@interface ACDialsViewController ()

@end

@implementation ACDialsViewController{
    //长按标记
    Boolean longFlag;
    //退格定时器
    NSTimer *_timerBackDel;
    NSMutableString *_dialString;
    NSMutableDictionary *mapping;
    UILabel *lblDisplayPhone;
    UILabel *lbl_name;
    UIView *headDisplay;
}

- (id)init
{
    self=[super init];
    if(self){
        
        _dialString=[[NSMutableString alloc]init];
        //按钮映射
        mapping=[[NSMutableDictionary alloc]init];
        [mapping setObject:@"1" forKey:@"1"];
        [mapping setObject:@"2" forKey:@"2"];
        [mapping setObject:@"3" forKey:@"3"];
        [mapping setObject:@"4" forKey:@"4"];
        [mapping setObject:@"5" forKey:@"5"];
        [mapping setObject:@"6" forKey:@"6"];
        [mapping setObject:@"7" forKey:@"7"];
        [mapping setObject:@"8" forKey:@"8"];
        [mapping setObject:@"9" forKey:@"9"];
        [mapping setObject:@"#" forKey:@"10"];
        [mapping setObject:@"0" forKey:@"11"];
        [mapping setObject:@"*" forKey:@"12"];
        
        UIView *container=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:container];
        int topHeight;
        if(IOS7){
            topHeight=74+20;
            headDisplay=[[UIView alloc]initWithFrame:CGRectMake(0, 20, container.frame.size.width, 74)];
        }else{
            topHeight=74;
            headDisplay=[[UIView alloc]initWithFrame:CGRectMake(0, 0, container.frame.size.width, 74)];
        }
        [container addSubview:headDisplay];
        
        UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake(0,17,40,40)];
        [leftBtn setImage:[UIImage imageNamed:@"dialadd"] forState:UIControlStateNormal];
        [leftBtn setTag:14];
        [leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [headDisplay addSubview:leftBtn];
        
        lblDisplayPhone=[[UILabel alloc]initWithFrame:CGRectMake(40, 0, headDisplay.frame.size.width-80, headDisplay.frame.size.height)];
        [lblDisplayPhone setTextColor:[UIColor whiteColor]];
        [lblDisplayPhone setBackgroundColor:[UIColor clearColor]];
        [headDisplay addSubview:lblDisplayPhone];
        
        lbl_name=[[UILabel alloc]initWithFrame:CGRectMake(0, headDisplay.frame.size.height-20, lblDisplayPhone.frame.size.width, 20)];
        [lbl_name setFont:[UIFont systemFontOfSize:12]];
        [lbl_name setTextColor:[UIColor whiteColor]];
        [lbl_name setBackgroundColor:[UIColor clearColor]];
        [lbl_name setTextAlignment:NSTextAlignmentCenter];
        [lblDisplayPhone addSubview:lbl_name];
        
        LongPressButton *rightBtn=[[LongPressButton alloc]initWithFrame:CGRectMake(280,17,40,40)];
        [rightBtn setImage:[UIImage imageNamed:@"dialdel"] forState:UIControlStateNormal];
        [rightBtn setTag:15];
        [rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn addTarget:self action:@selector(longPressed) forControlEvents:ControlEventTouchLongPress];
        [rightBtn addTarget:self action:@selector(cancelLongPress) forControlEvents:ControlEventTouchCancel];
        [headDisplay addSubview:rightBtn];
        [headDisplay setHidden:YES];
        
        int howLeft=27.5;
        int wspacing=20;
        int hspacing=20;
        int width=75;
        int height=70;
        if(!inch4){
            howLeft=15;
            wspacing=10;
            hspacing=10;
            width=90;
            height=60;
        }
        
        for(int i=0;i<4;i++){
            for(int j=0;j<3;j++){
                int value=(i*3)+(j+1);
                UIButton *dial=[[UIButton alloc]initWithFrame:CGRectMake(howLeft+j*width+(j)*wspacing, topHeight+i*height+(i)*hspacing, width, height)];
                [dial setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dial%d",value]] forState:UIControlStateNormal];
                if(inch4){
                    [dial setBackgroundImage:[UIImage imageNamed:@"dialbg"] forState:UIControlStateNormal];
                }else{
                    [dial setBackgroundImage:[UIImage imageNamed:@"dialbg4"] forState:UIControlStateNormal];
                }
                [dial setTag:value];
                [dial addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [container addSubview:dial];
            }
        }
        UIButton *dial=nil;
        
        if(inch4){
            dial=[[UIButton alloc]initWithFrame:CGRectMake(29, topHeight+4*height+(4)*hspacing, 262, 62)];
            [dial setBackgroundImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
        }else{
            dial=[[UIButton alloc]initWithFrame:CGRectMake(14, topHeight+4*height+(4)*hspacing, 292, 52)];
            [dial setBackgroundImage:[UIImage imageNamed:@"call4"] forState:UIControlStateNormal];
        }
        
        [dial setTag:13];
        [dial addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [container addSubview:dial];
    }
    return self;
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
#ifdef TEST
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",PHONENUMBER]]];
#else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",[[[response mainData] objectForKey:@"serverinfo"] objectForKey:@"serverno"]]]];
#endif
        [_dialString deleteCharactersInRange:NSMakeRange(0, [_dialString length])];
        [self showDialText];
        [[Config Instance]setIsRefreshUserInfo:YES];
        [[Config Instance]setIsRefreshRecordingList:YES];
        //拨打完电话刷新使用记录
        [[Config Instance]setIsRefreshUseRecordList:YES];
    }
}

- (void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        ABNewPersonViewController *newPersonViewController=[[ABNewPersonViewController alloc]init];
        ABRecordRef newPerson=ABPersonCreate();
        ABMutableMultiValueRef multiValue=ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
        CFErrorRef error=NULL;
        multiValue=ABMultiValueCreateMutable(kABMultiStringPropertyType);
        ABMultiValueAddValueAndLabel(multiValue, (__bridge CFTypeRef)(_dialString), kABPersonPhoneMainLabel, NULL);
        ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiValue, &error);
        newPersonViewController.displayedPerson=newPerson;
        newPersonViewController.newPersonViewDelegate=self;
        
        UINavigationController *newPersonViewControllerNav = [[UINavigationController alloc] initWithRootViewController:newPersonViewController];
        [self presentViewController:newPersonViewControllerNav animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)click:(id)sender
{
    NSInteger tag=[sender tag];
    switch(tag){
        case 13:
            //拔号
            //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
            // [[NSString alloc] initWithFormat:@"tel://%@",number];
            //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
            //[[NSString alloc] initWithFormat:@"telprompt://%@",@"18368013123"];
            if([_dialString length]>0){
                [self dial:_dialString];
            }
            break;
        case 14:
            //添加到联系人
            if([_dialString length]>0){
                [Common actionSheet:self message:nil ok:@"创建联系人" tag:1];
            }
            break;
        case 15:
            [self backDel];
            break;
        default:
            [_dialString appendString:[mapping objectForKey:[NSString stringWithFormat:@"%d",tag]]];
            [self showDialText];
            break;
    }
}

//拨号
- (void)dial:(NSString*)phone{
    if([[[Config Instance]noDialPhoneNumber] containsObject:[Common formatPhone:phone]]){
        [Common alert:@"禁止通过安存语录拨打该号码"];
    }else if([HttpRequest isNetworkConnection]){
        //网络连接时用网络拔号
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:@"1" forKey:@"calltype"];
        [requestParams setObject:[Common formatPhone:phone] forKey:@"oppno"];
        self.hRequest=[[HttpRequest alloc]init];
        [self.hRequest setDelegate:self];
        [self.hRequest setController:self];
        [self.hRequest setIsShowMessage:YES];
        [self.hRequest loginhandle:@"v4Call" requestParams:requestParams];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@,%@#",PHONENUMBER,phone]]];
    }
}

//显示拨号盘号码
- (void)showDialText{
    int len=[_dialString length];
    
    if(len>0){
        [headDisplay setHidden:NO];
        static int size[] = {37,36,35,34,33,32,31,30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19}; //这么多字体，从大到小挨个尝试
        static int array_length = 19;
        UIFont *font;
        for(int i = 0; i < array_length; i++) {
            font=[UIFont systemFontOfSize:size[i]];
            //设定宽度，高度无限高
            CGSize constraintSize = CGSizeMake(FLT_MAX,FLT_MAX);
            //计算实际需要得视图大小
            CGSize labelSize = [_dialString sizeWithFont:font constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
            //因为宽度已经限定了，所以判断高度是否符合需求，如果不符合，继续找更小得字体，如果符合，跳出循环
            if(labelSize.width <= lblDisplayPhone.frame.size.width) {
                lblDisplayPhone.font = font;
                lblDisplayPhone.text = _dialString;
                break;
            }else{
                if(array_length-1==18){
                    lblDisplayPhone.font = font;
                    if(len>21){
                        int mocount=len-21;
                        NSMutableString *tmpString=[[NSMutableString alloc]initWithString:@"..."];
                        [tmpString appendString:[_dialString substringWithRange:NSMakeRange(mocount,21)]];
                        lblDisplayPhone.text = tmpString;
                    }else{
                        lblDisplayPhone.text = _dialString;
                    }
                }
            }
        }
        [lbl_name setText:[[[Config Instance]contact] objectForKey:_dialString]];
    }else{
        [headDisplay setHidden:YES];
    }
}

- (void)backDel{
    if([_dialString length]>0){
        [_dialString deleteCharactersInRange:NSMakeRange([_dialString length]-1, 1)];
    }
    [self showDialText];
}

- (void)longPressed{
    if([_dialString length]>0){
        _timerBackDel= [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(backDel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timerBackDel forMode:NSDefaultRunLoopMode];
        longFlag=YES;
    }
}

- (void)cancelLongPress{
    if(longFlag){
        if(_timerBackDel){
            [_timerBackDel invalidate];
        }
    }else{
        [self backDel];
    }
    longFlag=NO;
}

@end
