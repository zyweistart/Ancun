#import "ACMoreViewController.h"
#import "ACNavigationWebPageViewController.h"
#import "ACAboutUsViewController.h"
#import "ACFeedBacksViewController.h"
#import "ACModifyPasswordViewController.h"
#import "ACNavGesturePasswordViewController.h"
#import "FileUtils.h"
#import "NSString+Utils.h"
#import "WXApi.h"
#import "WeixinSessionActivity.h"
#import "WeixinTimelineActivity.h"

@interface ACMoreViewController () <UIActionSheetDelegate>

@end

@implementation ACMoreViewController{
    UILabel *lblCachName;
    long long cachesize;
    NSString *url;
    BOOL _checkFlag;
}

- (id)init{
    self = [super init];
    if(self){
        self.title=@"更多";
        UIScrollView *container=nil;
        if(IOS7){
            container=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-STATUSHEIGHT-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
        }else{
            container=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-TOPNAVIGATIONHEIGHT-BOTTOMTABBARHEIGHT)];
        }
        int length=9;
        [container setContentSize:CGSizeMake(self.view.frame.size.width, 10+length*69.5+1*(length-1)+10)];
        [container setScrollEnabled:YES];
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"morebg"]]];
        [self.view addSubview:container];
        
        NSArray *names=[[NSArray alloc]initWithObjects:@"小贴士",@"意见反馈",@"关于我们",@"修改密码",@"手势密码",@"检测新版本",@"正在计算缓存大小",@"应用分享",@"重新登录", nil];
        NSArray *bgs=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"5",@"8",@"7",@"4",@"9",@"6", nil];
        
        for(int i=0;i<length;i++){
            UIButton *btnBg=[[UIButton alloc]initWithFrame:CGRectMake(15.75, 10+i*70+1*i,289,70)];
            if(i==6){
                lblCachName=[[UILabel alloc]initWithFrame:CGRectMake(40, 21, 200, 28)];
                [lblCachName setText:[names objectAtIndex:i]];
                [lblCachName setFont:[UIFont systemFontOfSize:22]];
                [lblCachName setTextColor:[UIColor whiteColor]];
                [lblCachName setBackgroundColor:[UIColor clearColor]];
                [btnBg addSubview:lblCachName];
            }else{
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(40, 21, 200, 28)];
                [lbl setText:[names objectAtIndex:i]];
                [lbl setFont:[UIFont systemFontOfSize:22]];
                [lbl setTextColor:[UIColor whiteColor]];
                [lbl setBackgroundColor:[UIColor clearColor]];
                [btnBg addSubview:lbl];
            }
            
            [btnBg setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
            [btnBg setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"more%@",[bgs objectAtIndex:i]]] forState:UIControlStateNormal];
            [btnBg setTag:i];
            [btnBg addTarget:self action:@selector(onClickAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [container addSubview:btnBg];
        }
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if([[Config Instance]isCalculateTotal]){
        [NSThread detachNewThreadSelector:@selector(calculateTotal) toTarget:self withObject:nil];
    }
}

- (void)actionSheet:(UIActionSheet*)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(actionSheet.tag==1){
        if(buttonIndex==0){
            [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_2 requestCode:0 data:nil];
        }
    }else if(actionSheet.tag==2){
        if(buttonIndex==0){
            [FileUtils removeCacheFile];
//            [Common setCache:[Config Instance].cacheKey data:nil];
            cachesize=0;
            [Common alert:@"清除完成"];
            [NSThread detachNewThreadSelector:@selector(calculateTotal) toTarget:self withObject:nil];
        }
    }
}

#pragma mark -
#pragma mark Custom Methods

- (void)onClickAction:(UIButton *)sender
{
    if(sender.tag==0){
        //小贴士
        ACNavigationWebPageViewController *navigationWebPageViewController=[[ACNavigationWebPageViewController alloc]initWithNavigationTitle:@"小贴士" resourcePath:@"TipContent"];
        navigationWebPageViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:navigationWebPageViewController animated:YES];
    }else if(sender.tag==1){
        //意见反馈
        ACFeedBacksViewController *feedBacksViewController=[[ACFeedBacksViewController alloc]init];
        feedBacksViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedBacksViewController animated:YES];
    }else if(sender.tag==2){
        //关于我们
        ACAboutUsViewController *aboutUsViewController=[[ACAboutUsViewController alloc]init];
        aboutUsViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutUsViewController animated:YES];
    }else if(sender.tag==3){
        //修改密码
        ACModifyPasswordViewController *modifyPasswordViewController=[[ACModifyPasswordViewController alloc]init];
        modifyPasswordViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:modifyPasswordViewController animated:YES];
    }else if(sender.tag==4){
        //手势密码
        ACNavGesturePasswordViewController *navGesturePasswordViewController=[[ACNavGesturePasswordViewController alloc]init];
        navGesturePasswordViewController.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:navGesturePasswordViewController animated:YES];
    }else if(sender.tag==5){
        //检测新版本
        [self checkVersion:YES];
    }else if(sender.tag==6){
        //清理缓存
        if([[Config Instance]isCalculateTotal]){
            [Common alert:@"正在计算缓存大小"];
        }else{
            if(cachesize>0){
                [Common actionSheet:self message:@"确定要清除所有缓存文件吗？" tag:2];
            }else{
                [Common alert:@"当前的缓存文件为0KB，无须清除"];
            }
        }
    }else if(sender.tag==7){
        if(IOS6){
            //应用分享
            NSArray *activity=nil;
            //判断微信是否已经安装
            if([WXApi isWXAppInstalled]){
                activity = @[[[WeixinSessionActivity alloc] init],[[WeixinTimelineActivity alloc] init]];
            }
            UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:@[@"安存语录,促使通话录音,严格满足证据的真实性、合法性要求,以公证的法定证明力为依托,是真正可成为被司法机关认可的呈堂证供的通话录音",[NSURL URLWithString:@"https://itunes.apple.com/cn/app/an-cun-yu-lu-ge-ren-ban/id638597148?mt=8"]] applicationActivities:activity];
            
            if(IOS7){
                activityView.excludedActivityTypes = @[UIActivityTypePostToFacebook,
                                                       UIActivityTypePostToTwitter,
                                                       UIActivityTypePrint,
                                                       UIActivityTypeCopyToPasteboard,
                                                       UIActivityTypeAssignToContact,
                                                       UIActivityTypeSaveToCameraRoll,
                                                       UIActivityTypeAddToReadingList,
                                                       UIActivityTypePostToFlickr,
                                                       UIActivityTypePostToVimeo,
                                                       UIActivityTypeAirDrop];
            }else if(IOS6){
                activityView.excludedActivityTypes = @[UIActivityTypePostToFacebook,
                                                       UIActivityTypePostToTwitter,
                                                       UIActivityTypePrint,
                                                       UIActivityTypeCopyToPasteboard,
                                                       UIActivityTypeAssignToContact,
                                                       UIActivityTypeSaveToCameraRoll];
            }
            [self presentViewController:activityView animated:YES completion:nil];
        }else{
            [Common alert:@"当前系统不支持应用分享，请升级系统"];
        }
    }else if(sender.tag==8){
        //重新登录
        [Common actionSheet:self message:@"确定要重新登录吗？" tag:1];
    }
}

- (void)checkVersion:(BOOL)flag
{
    _checkFlag=flag;
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    [requestParams setObject:@"6" forKey:@"type"];
    [requestParams setObject:@"5" forKey:@"termtype"];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setIsShowMessage:_checkFlag];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setRequestCode:REQUESTCODE_CHECK_VERSION];
    [self.hRequest handle:@"versioninfoGet" signKey:nil requestParams:requestParams];
}

//计算空间大小
- (void)calculateTotal{
    NSString *cacheName=nil;
    cachesize=[FileUtils getCacheSize];
    if(cachesize/1024/1024>1024){//GB
        float totla=(float)cachesize/1024/1024;
        cacheName=[NSString stringWithFormat:@"%.2fGB",totla/1024];
    }else if(cachesize/1024>1024){//MB
        float totla=(float)cachesize/1024;
        cacheName=[NSString stringWithFormat:@"%.2fMB",totla/1024];
    }else{//KB
        cacheName=[NSString stringWithFormat:@"%lldKB",cachesize/1024];
    }
    [lblCachName setText:[NSString stringWithFormat:@"缓存大小:%@",cacheName]];
    [[Config Instance]setIsCalculateTotal:NO];
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode{
    if(reqCode==REQUESTCODE_CHECK_VERSION){
        if([response successFlag]){
            NSDictionary *versioninfo=[[response mainData] objectForKey:@"versioninfo"];
            if(versioninfo!=nil){
                NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
                int currentVersion=[[infoDict objectForKey:@"CFBundleVersion"] intValue];
                NSString *remark=[versioninfo objectForKey:@"remark"];
                url=[versioninfo objectForKey:@"url"];
                int minverno=[[versioninfo objectForKey:@"minverno"]intValue];
                if(minverno>currentVersion){
                    [[Config Instance]setLock:YES];
                    //强制升级
                    [Common alert:remark cancel:nil ok:@"立即更新" delegate:self tag:11];
                }else{
                    int maxverno=[[versioninfo objectForKey:@"maxverno"]intValue];
                    if(maxverno>currentVersion){
                        if(!_checkFlag){
                            NSString *checkTime=[Common getCache:DEFAULTDATA_CHECKVERSIONTIME];
                            if([checkTime isNotEmpty]){
                                NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
                                [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
                                NSDate *startDate=[NSDate date];
                                NSTimeInterval secondsPerDay = 86400*1;
                                NSDate *endDate = [startDate dateByAddingTimeInterval:-secondsPerDay];
                                NSString *endDateStr = [dateFormatter stringFromDate:endDate];
                                if([endDateStr intValue]<=[checkTime intValue]){
                                    //每天提醒一次
                                    return;
                                }
                            }
                        }
                        //升级
                        [Common alert:remark cancel:@"下次再说" ok:@"立即更新" delegate:self tag:22];
                    }else{
                        if(_checkFlag){
                            [Common alert:@"当前版本为最新版本"];
                        }
                    }
                }
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int tag=alertView.tag;
    if(tag==11){
        [[Config Instance]setLock:NO];
        //强制升级
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        [Common resultLoginViewController:self resultCode:RESULTCODE_ACLoginViewController_1 requestCode:0 data:nil];
    }else if(tag==22){
        //升级
        if(buttonIndex==1){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        }else if(buttonIndex==0){
            if(!_checkFlag){
                NSDateFormatter *dateFormatter =[[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
                [Common setCache:DEFAULTDATA_CHECKVERSIONTIME data:[dateFormatter stringFromDate:[NSDate date]]];
            }
        }
    }
}

@end
