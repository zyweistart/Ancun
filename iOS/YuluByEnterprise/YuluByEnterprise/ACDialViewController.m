#import "ACDialViewController.h"
#import "LongPressButton.h"

@interface ACDialViewController ()

- (void) dial:(NSString*)phone;
- (void) showDialText;

@end

@implementation ACDialViewController{
    HttpRequest *_dialHttp;
    
    NSMutableString *_dialString;
    //退格定时器
    NSTimer *_timerBackDel;
    //长按标记
    Boolean longFlag;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if(iPhone5){
        nibNameOrNil=@"ACDialViewController@iPhone5";
    }else{
        nibNameOrNil=@"ACDialViewController";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.image = [UIImage imageNamed:@"nav_icon_dial"];
        self.tabBarItem.title = @"拨号盘";
        
        _dialString=[[NSMutableString alloc]init];
        
        LongPressButton *button;
        if(iPhone5){
            button=[[LongPressButton alloc] initWithFrame:CGRectMake(214, 429, 106, 70)];
        }else{
            button=[[LongPressButton alloc] initWithFrame:CGRectMake(214, 347, 106, 65)];
        }
        [button addTarget:self action:@selector(longPressed) forControlEvents:ControlEventTouchLongPress];
        [button addTarget:self action:@selector(cancelLongPress) forControlEvents:ControlEventTouchCancel];
        [button setBackgroundImage:[UIImage imageNamed:@"i5press.png"] forState:UIControlStateHighlighted];
        [self.view addSubview:button];
        
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
    [self dismissModalViewControllerAnimated:YES];
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
        [self presentModalViewController:newPersonViewControllerNav animated:YES];
    }
}

#pragma mark -
#pragma mark Custom Methods

- (IBAction)btnTouchUpInside:(id)sender{
    NSInteger tag=[sender tag];
    switch(tag){
        case 10:
            //#
            [_dialString appendString:@"#"];
            [self showDialText];
            break;
        case 11:
            //*
            [_dialString appendString:@"*"];
            [self showDialText];
            break;
        case 12:
            //添加到联系人
            if([_dialString length]>0){
                UIActionSheet *sheet = [[UIActionSheet alloc]
                                        initWithTitle:nil
                                        delegate:self
                                        cancelButtonTitle:@"取消"
                                        destructiveButtonTitle:@"创建联系人"
                                        otherButtonTitles:nil,nil];
                sheet.tag=1;
                //UIActionSheet与UITabBarController结合使用不能使用[sheet showInView:self.view];
                [sheet showInView:[UIApplication sharedApplication].keyWindow];
            }
            break;
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
        default:
            [_dialString appendString:[[NSString alloc] initWithFormat:@"%d",[sender tag]]];
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
        _dialHttp=[[HttpRequest alloc]init];
        [_dialHttp setDelegate:self];
        [_dialHttp setController:self];
        [_dialHttp setIsShowMessage:YES];
        [_dialHttp loginhandle:@"v4Call" requestParams:requestParams];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@,%@#",PHONENUMBER,phone]]];
    }
}

//显示拨号盘号码
- (void)showDialText{
    int len=[_dialString length];
    if(len>=0){
        if(len<=15){
            _lbl_dial.font=[UIFont fontWithName:_lbl_dial.font.fontName size:37];
            [_lbl_dial setText:_dialString];
        }else if(len==16){
            _lbl_dial.font=[UIFont fontWithName:_lbl_dial.font.fontName size:35];
            [_lbl_dial setText:[_dialString substringWithRange:NSMakeRange(0,16)]];
        }else if(len==17){
            _lbl_dial.font=[UIFont fontWithName:_lbl_dial.font.fontName size:33];
            [_lbl_dial setText:[_dialString substringWithRange:NSMakeRange(0,17)]];
        }else if(len==18){
            _lbl_dial.font=[UIFont fontWithName:_lbl_dial.font.fontName size:31];
            [_lbl_dial setText:[_dialString substringWithRange:NSMakeRange(0,18)]];
        }else{
            int mocount=len-18;
            _lbl_dial.font=[UIFont fontWithName:_lbl_dial.font.fontName size:29];
            [_lbl_dial setText:[NSString stringWithFormat:@"...%@",[_dialString substringWithRange:NSMakeRange(mocount,18)]]];
        }
        [_lbl_name setText:[[[Config Instance]contact] objectForKey:_dialString]];
    }
}

- (void)backDel:(id)sender{
    if([_dialString length]>0){
        [_dialString deleteCharactersInRange:NSMakeRange([_dialString length]-1, 1)];
        [self showDialText];
    }
}

- (void)longPressed{
    if([_dialString length]>0){
        _timerBackDel= [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(backDel:) userInfo:nil repeats:YES];
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
        [self backDel:nil];
    }
    longFlag=NO;
}

- (void)viewDidUnload {
    [self setLbl_name:nil];
    [super viewDidUnload];
}
@end
