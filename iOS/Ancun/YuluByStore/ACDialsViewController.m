#import "ACDialsViewController.h"
#import "LongPressButton.h"
#import "ChineseToPinyin.h"
#import "ACContactCell.h"
#import "ACContactSingleCell.h"
#define DIALBGINBG [UIColor colorWithRed:(101/255.0) green:(175/255.0) blue:(236/255.0) alpha:1]
#define DIALVIEWBG [UIColor colorWithRed:(26/255.0) green:(124/255.0) blue:(205/255.0) alpha:1]

@interface ACDialsViewController ()

@end

@implementation ACDialsViewController{
    //长按标记
    Boolean longFlag;
    //退格定时器
    NSTimer *_timerBackDel;
    UILabel *lblDisplayPhone;
    NSMutableString *_dialString;
    NSMutableDictionary *mapping;
    UIView *headDisplay;
    UIView *dialView;
    UIView *tabBGView;
    UIButton *showHidden;
    BOOL isAddTabBar;
    CGFloat mDialWidth,mDialHeight;
    int currentType;
}

- (id)init
{
    self=[super init];
    if(self){
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshed:) name:Notification_TabClick_ACDialsViewController object:nil];
        
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
        CGFloat width=self.view.bounds.size.width;
        UIView *container=[[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:container];
        //头部
        headDisplay=[[UIView alloc]initWithFrame:CGRectMake1(0, 20, width, 60)];
        [container addSubview:headDisplay];
        //添加到通讯录
        UIButton *leftBtn=[[UIButton alloc]initWithFrame:CGRectMake1(0,10,40,40)];
        [leftBtn setImage:[UIImage imageNamed:@"dialadd"] forState:UIControlStateNormal];
        [leftBtn setTag:14];
        [leftBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        [headDisplay addSubview:leftBtn];
        //号码显示区域
        lblDisplayPhone=[[UILabel alloc]initWithFrame:CGRectMake1(40, 0, headDisplay.frame.size.width-80, headDisplay.frame.size.height)];
        [lblDisplayPhone setTextColor:[UIColor whiteColor]];
        [lblDisplayPhone setBackgroundColor:[UIColor clearColor]];
        [lblDisplayPhone setTextAlignment:NSTextAlignmentCenter];
        [headDisplay addSubview:lblDisplayPhone];
        //清除号码
        LongPressButton *rightBtn=[[LongPressButton alloc]initWithFrame:CGRectMake1(280,10,40,40)];
        [rightBtn setImage:[UIImage imageNamed:@"dialdel"] forState:UIControlStateNormal];
        [rightBtn setTag:15];
        [rightBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [rightBtn addTarget:self action:@selector(longPressed) forControlEvents:ControlEventTouchLongPress];
        [rightBtn addTarget:self action:@selector(cancelLongPress) forControlEvents:ControlEventTouchCancel];
//        [headDisplay addSubview:rightBtn];
        self.message=[[UIView alloc]init];
        [self.message setBackgroundColor:[UIColor whiteColor]];
        UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake1(20, 10, 280, 300)];
        [lbl setText:@"系统因权限限制\n需要进入系统设置->隐私->通讯录,开启通讯录权限许可后才能使用"];
        [lbl setTextColor:[UIColor grayColor]];
        [lbl setNumberOfLines:0];
        [lbl setFont:[UIFont systemFontOfSize:14]];
        [self.message addSubview:lbl];
        [self.message setHidden:YES];
        [container addSubview:self.message];
        //表视图
        self.tableView=[[UITableView alloc]init];
        [self.tableView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableView setDelegate:self];
        [self.tableView setDataSource:self];
        [container addSubview:self.tableView];
        self.tableViewData=[[UITableView alloc]init];
        [self.tableViewData setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self.tableViewData setDelegate:self];
        [self.tableViewData setDataSource:self];
        [container addSubview:self.tableViewData];
//        [self.tableViewData setHidden:YES];
        //搜索
        self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
        [self.searchBar setPlaceholder:@"姓名/号码"];
        [self.searchBar setDelegate:self];
        [self.searchBar setShowsCancelButton:YES];
        [self.searchBar setKeyboardType:UIKeyboardTypeDefault];
        [self.tableView setTableHeaderView:self.searchBar];
        //拨号盘
        mDialWidth=107;
        mDialHeight=55;
        dialView=[[UIView alloc]initWithFrame:CGRectMake1(0, self.view.bounds.size.height-4*mDialHeight-49, 320, 4*mDialHeight)];
        [dialView setBackgroundColor:DIALVIEWBG];
        [container addSubview:dialView];
        for(int i=0;i<4;i++){
            for(int j=0;j<3;j++){
                int value=(i*3)+(j+1);
                CGFloat height=mDialHeight-0.5;
                if(i==3){
                    height=mDialHeight;
                }
                CGFloat width=mDialWidth-0.5;
                if(j==2){
                    width=mDialWidth;
                }
//                NSLog(@"%lf,,,,%lf------%lf,,,,%lf",mDialWidth*j, mDialHeight*i,width,height);
                UIButton *dial=[[UIButton alloc]initWithFrame:CGRectMake1(mDialWidth*j, mDialHeight*i, width, height)];
                [dial setImage:[UIImage imageNamed:[NSString stringWithFormat:@"dial%d",value]] forState:UIControlStateNormal];
                [dial setBackgroundColor:DIALBGINBG];
                [dial setTag:value];
                [dial addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                [dialView addSubview:dial];
            }
        }
        isAddTabBar=NO;
        //初始化加载通讯录
        [self loadContact];
        [self showDialText];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(!isAddTabBar){
        isAddTabBar=YES;
        [self.message setFrame:CGRectMake1(0, 80, 320, self.view.bounds.size.height-80)];
        [self.tableView setFrame:CGRectMake1(0, 80, 320, self.view.bounds.size.height-80)];
        [self.tableViewData setFrame:CGRectMake1(0, 80, 320, self.view.bounds.size.height-80)];
        CGFloat tabHeight=[self.tabBarController tabBar].bounds.size.height;
        tabBGView=[[UIView alloc]initWithFrame:CGRectMake1(0, self.tabBarController.view.bounds.size.height-tabHeight, 320, tabHeight)];
        [tabBGView setBackgroundColor:MAINBG];
        showHidden=[[UIButton alloc]initWithFrame:CGRectMake1(5, 0, 50, tabHeight)];
        [showHidden addTarget:self action:@selector(hidden:) forControlEvents:UIControlEventTouchUpInside];
        [tabBGView addSubview:showHidden];
        UIButton *dial1=[[UIButton alloc]initWithFrame:CGRectMake1(60, 2, 200, tabHeight-4)];
        [dial1 setTag:13];
        [dial1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [dial1 setBackgroundImage:[UIImage imageNamed:@"call4"] forState:UIControlStateNormal];
        [tabBGView addSubview:dial1];
        LongPressButton *btnDel=[[LongPressButton alloc]initWithFrame:CGRectMake1(265,0,50,tabHeight)];
        [btnDel setImage:[UIImage imageNamed:@"dialdel"] forState:UIControlStateNormal];
        [btnDel setTag:15];
        [btnDel addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [btnDel addTarget:self action:@selector(longPressed) forControlEvents:ControlEventTouchLongPress];
        [btnDel addTarget:self action:@selector(cancelLongPress) forControlEvents:ControlEventTouchCancel];
        [tabBGView addSubview:btnDel];
        [tabBGView setHidden:YES];
//        [self.tabBarController.view addSubview:tabBGView];
        NSArray* windows = [UIApplication sharedApplication].windows;
        [[windows objectAtIndex:0] addSubview:tabBGView];
        
        [self dialViewShow];
        currentType=1;
        [self showHiddenTableView];
    }
}

#pragma mark -
#pragma mark Delegate Methods

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode{
    if([response successFlag]){
        if(reqCode==5001){
            NSDictionary *res=[[response resultJSON]objectForKey:@"response"];
            if(res){
                NSDictionary *content=[res objectForKey:@"content"];
                if(content){
                    NSArray *array=[content objectForKey:@"combolist"];
                    if(array){
                        for (NSMutableDictionary *data in array) {
                            int ctype=[[data objectForKey:@"ctype"]intValue];
                            if(ctype==9){
                                [[Config Instance]setIsPayUser:NO];
                            }else{
                                [[Config Instance]setIsPayUser:YES];
                            }
                        }
                    }
                }
            }
        }else{
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
    [self.searchBar resignFirstResponder];
    int len=[_dialString length];
    
    if(len>0){
        currentType=2;
//        [self.tableView setHidden:YES];
//        [self.tableViewData setHidden:NO];
        [headDisplay setHidden:NO];
        [tabBGView setHidden:NO];
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
        //搜索联系人
    }else{
        [lblDisplayPhone setFont:[UIFont systemFontOfSize:20]];
        [lblDisplayPhone setText:@"拨号"];
        currentType=1;
//        [self.tableView setHidden:NO];
//        [self.tableViewData setHidden:YES];
//        [headDisplay setHidden:YES];
        [tabBGView setHidden:YES];
        if([dialView isHidden]){
            [self dialViewShow];
        }
    }
    [self showItemView];
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

- (void)hidden:(id)sender
{
    if([dialView isHidden]){
        [self dialViewShow];
    }else{
        [self dialViewHidden];
    }
}
//拨号盘隐藏
- (void)dialViewHidden
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromTop;
    animation.duration = 0.6;
    [dialView.layer addAnimation:animation forKey:nil];
    dialView.hidden = YES;
    [showHidden setImage:[UIImage imageNamed:@"nav_icon_dial"] forState:UIControlStateNormal];
}
//拨号盘显示
- (void)dialViewShow
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromBottom;
    animation.duration = 0.6;
    [dialView.layer addAnimation:animation forKey:nil];
    dialView.hidden = NO;
    [showHidden setImage:[UIImage imageNamed:@"nav_icon_dial_hover"] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([Common getAbAddressBook]) {
        self.tableView.hidden=NO;
        self.message.hidden=YES;
        [self.tableView reloadData];
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]
                                                initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                target:self
                                                action:@selector(refresh:)];
    } else {
        self.message.hidden=NO;
        self.tableView.hidden=YES;
    }
    [self loadUserPay];
}

- (void)loadContact
{
    BOOL ISCREATEACYULUPHONENUMBER=YES;
    //自iOS6.0后获取通讯录列表需要询问用户，经过用户同意后才可以获取通讯录用户列表。而且ABAddressBookRef的初始化工作也由ABAddressBookCreate函数转变为ABAddressBookCreateWithOptions函数。下面代码是兼容之前版本的获取通讯录用户列表方法。
    ABAddressBookRef addressBook=[Common getAbAddressBook];
    [[[Config Instance]contact]removeAllObjects];
    if(_dataResults==nil){
        _dataResults=[[NSMutableDictionary alloc]init];
    }else{
        [_dataResults removeAllObjects];
    }
    if (addressBook) {
        NSMutableDictionary *refreshFlag=[[NSMutableDictionary alloc]init];
        CFArrayRef results =ABAddressBookCopyArrayOfAllPeople(addressBook);
        for(int i = 0; i < CFArrayGetCount(results); i++) {
            ABRecordRef person = CFArrayGetValueAtIndex(results, i);
            
            NSString *firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            if(firstName==nil) {
                firstName=@"";
            }
            
            NSString *lastname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
            if(lastname==nil) {
                lastname=@"";
            }
            
            NSString *name=[[NSString alloc]initWithFormat:@"%@%@",lastname,firstName];
            if([@""isEqualToString:name]){
                NSString *organizationName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
                if(![@""isEqualToString:organizationName]){
                    name=organizationName;
                }
            }
            
            NSString *hName=nil;
            NSMutableArray *mutable=nil;
            BOOL flag=YES;
            NSString* nameFlag=@"0";
            ABMultiValueRef phoneRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
            
            for (int k = 0; k<ABMultiValueGetCount(phoneRef); k++) {
                //的电话值
                NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneRef, k);
                if(flag) {
                    if([name isEqualToString:@""]) {
                        name=personPhone;
                        nameFlag=@"1";
                    }
                    NSString *strName=[ChineseToPinyin pinyinFromChiniseString:name];
                    if([@"" isEqualToString:strName]) {
                        hName=@"#";
                    } else {
                        unichar c=[[[strName substringWithRange:NSMakeRange(0,1)] lowercaseString] characterAtIndex:0];
                        if(c>=97&&c<=122){
                            hName=[NSString stringWithFormat:@"%c",c];
                        }else{
                            hName=@"#";
                        }
                    }
                    mutable=[_dataResults objectForKey:hName];
                    if(!mutable){
                        mutable=[[NSMutableArray alloc]init];
                    }
                    flag=NO;
                }
                if([@"1" isEqualToString:nameFlag]){
                    name=personPhone;
                }
                NSArray *nameDic=[[NSArray alloc]initWithObjects:name,personPhone,nameFlag,nil];
                
                NSString *personName=nil;
                NSString *phoneNumber=[Common formatPhone:personPhone];
                
                //跑过不能拨打的号码
                if([[[Config Instance]noDialPhoneNumber] containsObject:phoneNumber]) {
                    if([phoneNumber isEqualToString:PHONENUMBER]) {
                        ISCREATEACYULUPHONENUMBER=NO;
                    }
                    continue;
                }
//                //长度不够的电话则绕过
//                if([phoneNumber length]<=7||[phoneNumber length]>=20) {
//                    continue;
//                }
                //是否已经创建了安存语录音电话号码
                if(ISCREATEACYULUPHONENUMBER) {
                    if([name isEqualToString:APPNAME]) {
                        ISCREATEACYULUPHONENUMBER=NO;
                    }
                }
                
                NSMutableDictionary* contact=[[Config Instance]contact];
                if(contact==nil) {
                    contact=[[NSMutableDictionary alloc]init];
                } else {
                    if([refreshFlag objectForKey:personPhone]==nil) {
                        personName=[contact objectForKey:phoneNumber];
                        if(personName) {
                            [contact setObject:@"" forKey:phoneNumber];
                            [refreshFlag setObject:@"1" forKey:personPhone];
                        }
                    }
                }
                if(personName) {
                    [contact setObject:[NSString stringWithFormat:@"%@,%@",personName,name] forKey:phoneNumber];
                } else {
                    if([nameFlag isEqualToString:@"1"]) {
                        [contact setObject:phoneNumber forKey:phoneNumber];
                    } else {
                        if(name==nil){
                            name=phoneNumber;
                        }
                        [contact setObject:name forKey:phoneNumber];
                    }
                }
                [[Config Instance]setContact:contact];
                
                [mutable addObject:nameDic];
//                name=@"";
            }
            if(!flag) {
                if([mutable count]>0) {
                    [_dataResults setObject:mutable forKey:hName];
                }
            }
        }
        CFRelease(results);
        if(ISCREATEACYULUPHONENUMBER) {
            //添加安存语录官方电话
            ABRecordRef newPerson = ABPersonCreate();
            CFErrorRef error = NULL;
            ABRecordSetValue(newPerson, kABPersonFirstNameProperty, APPNAME, &error);
            //phone number
            ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
            ABMultiValueAddValueAndLabel(multiPhone, PHONENUMBER, kABPersonPhoneIPhoneLabel, NULL);
            ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone, &error);
            CFRelease(multiPhone);
            
            ABAddressBookAddRecord(addressBook, newPerson, &error);
            ABAddressBookSave(addressBook, &error);
            CFRelease(newPerson);
        }
        CFRelease(addressBook);
        
        _dataKeys = [[NSMutableArray alloc] initWithArray:[[_dataResults allKeys]
                                                           sortedArrayUsingSelector:@selector(compare:)]];
        
        _searchKeys = [[NSMutableArray alloc]initWithCapacity:[_dataKeys count]];
        _searchResults = [[NSMutableDictionary alloc]initWithCapacity:[_dataResults count]];
    }
    [self search:@""];
    [self.tableView reloadData];
}

#pragma mark Delegate

//右侧添加一个索引表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return _searchKeys;
}

//设置每个section显示的Title
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    if ([_searchKeys count] == 0){
        return nil;
    }
    return [_searchKeys objectAtIndex:section];
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    return ([_searchKeys count] > 0) ? [_searchKeys count] : 1;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if ([_searchKeys count] == 0) {
        return 2;
    } else {
        NSString *key = [_searchKeys objectAtIndex:section];
        NSArray *nameSection = [_searchResults objectForKey:key];
        return [nameSection count];
    }
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    if ([_searchKeys count] == 0) {
        return CGHeight(45);
    }else{
        NSString *key = [_searchKeys objectAtIndex:[indexPath section]];
        NSArray *nameSection = [_searchResults objectForKey:key];
        
        NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
        if([[namePhones objectAtIndex:2] isEqualToString:@"1"]){
            //单无姓名
            return CGHeight(40);
        }else{
            //有姓名的号码
            return CGHeight(60);
        }
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    static NSString *SectionsTableIdentifier1 = @"SectionsTableIdentifier1";
    static NSString *SectionsTableIdentifier2 = @"ACContactCell";
    static NSString *SectionsTableIdentifier3 = @"SectionsTableIdentifier3";
    
    if ([_searchKeys count] == 0) {
        int row=[indexPath row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 SectionsTableIdentifier3];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:SectionsTableIdentifier3];
        }
        if(row==0){
            [cell.textLabel setText:@"添加联系人"];
        }else{
            [cell.textLabel setText:@"发送短信息"];
        }
        return cell;
    }else{
        NSString *key = [_searchKeys objectAtIndex:[indexPath section]];
        NSArray *nameSection = [_searchResults objectForKey:key];
        
        NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
        if([[namePhones objectAtIndex:2] isEqualToString:@"1"]){
            //单无姓名
            ACContactSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                         SectionsTableIdentifier1];
            if (cell == nil) {
                cell = [[ACContactSingleCell alloc]
                        initWithStyle:UITableViewCellStyleDefault
                        reuseIdentifier:SectionsTableIdentifier1];
            }
            NSString *phone=[Common formatPhone:[namePhones objectAtIndex:1]];
            int nLength=[phone length];
            [cell.lblPhone setText:phone];
            [cell.lblPhone setFont:[UIFont systemFontOfSize:19] fromIndex:0 length:nLength];
            [cell.lblPhone setColor:[UIColor blackColor] fromIndex:0 length:nLength];
            
            NSString *content=_dialString;
            if([@""isEqualToString:content]){
                content=[self.searchBar text];
            }
            if(![@""isEqualToString:content]){
                
                if([phone containsString:content]){
                    NSRange range=[phone rangeOfString:content];
                    [cell.lblPhone setColor:[UIColor redColor] fromIndex:range.location length:range.length];
                }
            }
            [cell.lblPhone setNeedsDisplay];
            return cell;
        }else{
            //双
            ACContactCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier2];
            if(cell==nil){
                cell = [[ACContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier2];
            }
            //姓名
            NSString *name=[namePhones objectAtIndex:0];
            cell.lblName.text=name;
            int nLength=[name length];
            [cell.lblName setFont:[UIFont systemFontOfSize:19] fromIndex:0 length:nLength];
            [cell.lblName setColor:[UIColor blackColor] fromIndex:0 length:nLength];
            //电话
            NSString *phone=[Common formatPhone:[namePhones objectAtIndex:1]];
            int pLength=[phone length];
            cell.lblPhone.text=phone;
            [cell.lblPhone setFont:[UIFont systemFontOfSize:15] fromIndex:0 length:pLength];
            [cell.lblPhone setColor:FONTCOLOR2 fromIndex:0 length:pLength];
            
            NSString *content=_dialString;
            if([@""isEqualToString:content]){
                content=[self.searchBar text];
            }
            if(![@""isEqualToString:content]){
                if([name containsString:content]){
                    NSRange range=[name rangeOfString:content];
                    [cell.lblName setColor:[UIColor redColor] fromIndex:range.location length:range.length];
                }
                if([phone containsString:content]){
                    NSRange range=[phone rangeOfString:content];
                    [cell.lblPhone setColor:[UIColor redColor] fromIndex:range.location length:range.length];
                }
            }
            [cell.lblName setNeedsDisplay];
            [cell.lblPhone setNeedsDisplay];
            return cell;
        }

    }
}

//设置选中的行所执行的动作
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    if ([_searchKeys count] == 0) {
        //添加到联系人
        if([_dialString length]>0){
            int row=[indexPath row];
            if(row==0){
                [Common actionSheet:self message:nil ok:@"添加联系人" tag:1];
            }else if(row==1){
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",_dialString]]];
            }
        }
    }else{
        NSString *key = [_searchKeys objectAtIndex:[indexPath section]];
        NSArray *nameSection = [_searchResults objectForKey:key];
        NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
        [self dial:[namePhones objectAtIndex:1]];
    }
}

- (void)search:(NSString*)searchString
{
    if([@"" isEqualToString:searchString]){
        _searchKeys=[[NSMutableArray alloc]initWithArray:_dataKeys];
        _searchResults=[[NSMutableDictionary alloc]initWithDictionary:_dataResults];
        return;
    }else{
        [_searchKeys removeAllObjects];
        [_searchResults removeAllObjects];
    }
    
    if(searchString) {
        for (NSString *key in _dataKeys) {
            
            for (NSMutableArray *name in [_dataResults valueForKey:key]) {
                BOOL flag=NO;
                if ([[name objectAtIndex:0] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    //原文查找
                    flag=YES;
                } else if ([[ChineseToPinyin pinyinFromChiniseString:[name objectAtIndex:0]] rangeOfString:[searchString uppercaseString] options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    //拼音查找
                    flag=YES;
                } else if ([[Common formatPhone:[name objectAtIndex:1]] rangeOfString:[searchString uppercaseString] options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    //号码查找
                    flag=YES;
                }
                if(flag) {
                    NSMutableArray *mutable=[_searchResults objectForKey:key];
                    if(mutable==nil) {
                        mutable=[[NSMutableArray alloc]init];
                    }
                    [mutable addObject:name];
                    
                    [_searchResults setObject:mutable forKey:key];
                }
            }
            
            if([[_searchResults objectForKey:key] count]>0) {
                [_searchKeys addObject:key];
            }
            
        }
    }

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //滚动就隐藏
    if(![dialView isHidden]){
        [self dialViewHidden];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self search:searchText];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self search:[searchBar text]];
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

- (void)showHiddenTableView
{
    if ([Common getAbAddressBook]){
        [self.message setHidden:YES];
        if(currentType==1){
            [self.tableViewData setHidden:YES];
            [self.tableView setHidden:NO];
            [self search:[self.searchBar text]];
            [self.tableView reloadData];
        }else{
            [self.tableViewData setHidden:NO];
            [self.tableView setHidden:YES];
            [self search:_dialString];
            [self.tableViewData reloadData];
        }
    } else {
        [self.message setHidden:NO];
        [self.tableView setHidden:YES];
        [self.tableViewData setHidden:YES];
    }
}

- (void)showItemView{
    if([self.message isHidden]){
        if(currentType==1){
            [self.tableViewData setHidden:YES];
            [self.tableView setHidden:NO];
            [self search:[self.searchBar text]];
            [self.tableView reloadData];
        }else{
            [self.tableViewData setHidden:NO];
            [self.tableView setHidden:YES];
            [self search:_dialString];
            [self.tableViewData reloadData];
        }
    }
}

- (void)refreshed:(NSNotification *)notification {
    if (notification.object){
        if ([(NSString *)notification.object isEqualToString:@"load"]) {
            if([dialView isHidden]){
                [self dialViewShow];
            }else{
                [self dialViewHidden];
            }
        }
    }
}

//加载用户套餐信息
- (void)loadUserPay
{
    NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
    self.hRequest=[[HttpRequest alloc]init];
    [self.hRequest setDelegate:self];
    [self.hRequest setController:self];
    [self.hRequest setIsShowMessage:YES];
    [self.hRequest setRequestCode:5001];
    [self.hRequest loginhandle:@"v4combinfoGet" requestParams:requestParams];
}

@end