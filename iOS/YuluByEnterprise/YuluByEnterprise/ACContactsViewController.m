#import "ACContactsViewController.h"
#import "ChineseToPinyin.h"
#import "ACContactCell.h"

@interface ACContactsViewController ()

- (void)dial:(NSString *)phone;

@end

@implementation ACContactsViewController {
    
    HttpRequest *_contactHttp;
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.tabBarItem.image = [UIImage imageNamed:@"nav_icon_contact"];
        self.tabBarItem.title = @"通讯录";
        self.navigationItem.title=@"通讯录";
        
        //初始化加载通讯录
        [self loadContact];
        
    }
    return self;
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
}

- (void)refresh:(id)sender{
    
    if ([Common getAbAddressBook]) {
        [self loadContact];
        self.tableView.hidden=NO;
        self.message.hidden=YES;
        [self.tableView reloadData];
    } else {
        self.message.hidden=NO;
        self.tableView.hidden=YES;
    }
    
}

- (void)loadContact {
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
                        [contact setObject:name forKey:phoneNumber];
                    }
                }
                [[Config Instance]setContact:contact];
                
                [mutable addObject:nameDic];
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
}

#pragma mark Delegate

//右侧添加一个索引表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return _searchKeys;
    } else {
        return _dataKeys;
    }
}

//设置每个section显示的Title
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if ([_searchKeys count] == 0){
            return nil;
        }
        return [_searchKeys objectAtIndex:section];
    } else {
        if ([_dataKeys count] == 0){
            return nil;
        }
        return [_dataKeys objectAtIndex:section];
    }
}

//指定有多少个分区(Section)，默认为1 
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return ([_searchKeys count] > 0) ? [_searchKeys count] : 1;
    } else {
        return ([_dataKeys count] > 0) ? [_dataKeys count] : 1;
    }
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        if ([_searchKeys count] == 0) {
            return 0;
        } else {
            NSString *key = [_searchKeys objectAtIndex:section];
            NSArray *nameSection = [_searchResults objectForKey:key];
            return [nameSection count];
        }
    } else {
        if ([_dataKeys count] == 0) {
            return 0;
        } else {
            NSString *key = [_dataKeys objectAtIndex:section];
            NSArray *nameSection = [_dataResults objectForKey:key];
            return [nameSection count];
        }
    }
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    NSString *key = nil;
    NSArray *nameSection = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        key = [_searchKeys objectAtIndex:[indexPath section]];
        nameSection = [_searchResults objectForKey:key];
    } else {
        key = [_dataKeys objectAtIndex:[indexPath section]];
        nameSection = [_dataResults objectForKey:key];
    }
    
    NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
    if([[namePhones objectAtIndex:2] isEqualToString:@"1"]){
        //单无姓名
        return 40;
    }else{
        //有姓名的号码
        return 60;
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath{
    
    static NSString *SectionsTableIdentifier1 = @"SectionsTableIdentifier1";
    static NSString *SectionsTableIdentifier2 = @"ACContactCell";
    
    NSString *key = nil;
    NSArray *nameSection = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        key = [_searchKeys objectAtIndex:[indexPath section]];
        nameSection = [_searchResults objectForKey:key];
    } else {
        key = [_dataKeys objectAtIndex:[indexPath section]];
        nameSection = [_dataResults objectForKey:key];
    }
    
    NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
    if([[namePhones objectAtIndex:2] isEqualToString:@"1"]){
        //单无姓名
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 SectionsTableIdentifier1];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:SectionsTableIdentifier1];
        }
        cell.textLabel.text=[Common formatPhone:[namePhones objectAtIndex:1]];
        return cell;
    }else{
        //双
        ACContactCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier2];
        if(!cell){
            cell = [[ACContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier2];
        }
        cell.lblName.text=[namePhones objectAtIndex:0];
        cell.lblPhone.text=[Common formatPhone:[namePhones objectAtIndex:1]];
        return cell;
    }
}

//设置选中的行所执行的动作
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    NSString *key = nil;
    NSArray *nameSection = nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        key = [_searchKeys objectAtIndex:[indexPath section]];
        nameSection = [_searchResults objectForKey:key];
    } else {
        key = [_dataKeys objectAtIndex:[indexPath section]];
        nameSection = [_dataResults objectForKey:key];
    }
    NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
    [self dial:[namePhones objectAtIndex:1]];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    
    [_searchKeys removeAllObjects];
    [_searchResults removeAllObjects];

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
    
    return YES;
}

- (void)requestFinishedByResponse:(Response *)response requestCode:(int)reqCode {
    if([response successFlag]) {
#ifdef TEST
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",PHONENUMBER]]];
#else
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@",[[[response mainData] objectForKey:@"serverinfo"] objectForKey:@"serverno"]]]];
#endif
        //拨打完电话刷新用户信息
        [[Config Instance]setIsRefreshUserInfo:YES];
        //拨打完电话刷新录音列表
        [[Config Instance]setIsRefreshRecordingList:YES];
        //拨打完电话刷新使用记录
        [[Config Instance]setIsRefreshUseRecordList:YES];
    }
}

#pragma mark Custom Method

- (void)dial:(NSString*)phone {
    if([[[Config Instance]noDialPhoneNumber] containsObject:[Common formatPhone:phone]]) {
        [Common alert:@"禁止通过安存语录拨打该号码"];
    } else if([HttpRequest isNetworkConnection]) {
        //网络连接时用网络拔号
        NSMutableDictionary *requestParams = [[NSMutableDictionary alloc] init];
        [requestParams setObject:@"1" forKey:@"calltype"];
        [requestParams setObject:[Common formatPhone:phone] forKey:@"oppno"];
        _contactHttp=[[HttpRequest alloc]init];
        [_contactHttp setDelegate:self];
        [_contactHttp setController:self];
        [_contactHttp setIsShowMessage:YES];
        [_contactHttp loginhandle:@"v4Call" requestParams:requestParams];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"tel://%@,%@#",PHONENUMBER,phone]]];
    }
}

@end
