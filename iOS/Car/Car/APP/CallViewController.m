//
//  CallViewController.m
//  Car
//
//  Created by Start on 10/13/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "CallViewController.h"
#import "LongPressButton.h"
#import "ChineseToPinyin.h"
#import "ACContactCell.h"
#import "ACContactSingleCell.h"
#import "Common.h"

@interface CallViewController ()

@end

@implementation CallViewController{
    //长按标记
    Boolean longFlag;
    //退格定时器
    NSTimer *_timerBackDel;
    UILabel *lblDisplayPhone;
    NSMutableString *_dialString;
    NSMutableDictionary *mapping;
    UIView *headDisplay;
    UIView *tabBGView;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"通讯录"];
        [self.view setBackgroundColor:BGCOLOR];
        _dialString=[[NSMutableString alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self buildTableViewWithView:self.view];
    //搜索框
    self.searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake1(0, 0, 320, 40)];
    [self.searchBar setPlaceholder:@"姓名/拼音/号码"];
    [self.searchBar setDelegate:self];
    [self.searchBar setShowsCancelButton:YES];
    [self.searchBar setKeyboardType:UIKeyboardTypeDefault];
    [self.tableView setTableHeaderView:self.searchBar];
    //拨号盘
    self.callViewFrame=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height-CGHeight(200), CGWidth(320), CGHeight(200))];
    [self.callViewFrame setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.callViewFrame];
    //
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"拨号盘" style:UIBarButtonItemStylePlain target:self action:@selector(callViewHiddenShow:)];
    
    [self loadContact];
}

#pragma mark TableView Delegate

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
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return ([_searchKeys count] > 0) ? [_searchKeys count] : 1;
}

//指定每个分区中有多少行，默认为1
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_searchKeys count] == 0) {
        return 0;
    } else {
        NSString *key = [_searchKeys objectAtIndex:section];
        NSArray *nameSection = [_searchResults objectForKey:key];
        return [nameSection count];
    }
}

//设置cell每行间隔的高度
- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath{
    NSString *key = [_searchKeys objectAtIndex:[indexPath section]];
    NSArray *nameSection = [_searchResults objectForKey:key];
    NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
    if([@"" isEqualToString:[namePhones objectAtIndex:0]]){
        //单无姓名
        return CGHeight(40);
    }else{
        //有姓名的号码
        return CGHeight(60);
    }
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{    
    static NSString *SectionsTableIdentifier1 = @"SectionsTableIdentifier1";
    static NSString *SectionsTableIdentifier2 = @"ACContactCell";
    
    NSString *key = [_searchKeys objectAtIndex:[indexPath section]];
    NSArray *nameSection = [_searchResults objectForKey:key];
    
    NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
    if([@"" isEqualToString:[namePhones objectAtIndex:0]]){
        //单无姓名
        ACContactSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                     SectionsTableIdentifier1];
        if (cell == nil) {
            cell = [[ACContactSingleCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:SectionsTableIdentifier1];
        }
        NSString *phone=[namePhones objectAtIndex:1];
        NSInteger nLength=[phone length];
        [cell.lblPhone setText:phone];
        [cell.lblPhone setFont:[UIFont systemFontOfSize:19] fromIndex:0 length:nLength];
        [cell.lblPhone setColor:[UIColor blackColor] fromIndex:0 length:nLength];
        
        NSString *content=_dialString;
        if([@""isEqualToString:content]){
            content=[self.searchBar text];
        }
        if(![@""isEqualToString:content]){
            
            if([phone rangeOfString:content].location != NSNotFound){
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
        NSInteger nLength=[name length];
        [cell.lblName setFont:[UIFont systemFontOfSize:19] fromIndex:0 length:nLength];
        [cell.lblName setColor:[UIColor blackColor] fromIndex:0 length:nLength];
        //电话
        NSString *phone=[namePhones objectAtIndex:1];
        NSInteger pLength=[phone length];
        cell.lblPhone.text=phone;
        [cell.lblPhone setFont:[UIFont systemFontOfSize:15] fromIndex:0 length:pLength];
        [cell.lblPhone setColor:RGBCOLOR(150, 150, 150) fromIndex:0 length:pLength];
        
        NSString *content=_dialString;
        if([@""isEqualToString:content]){
            content=[self.searchBar text];
        }
        if(![@""isEqualToString:content]){
            if([name rangeOfString:content].location != NSNotFound){
                NSRange range=[name rangeOfString:content];
                [cell.lblName setColor:[UIColor redColor] fromIndex:range.location length:range.length];
            }
            if([phone rangeOfString:content].location != NSNotFound){
                NSRange range=[phone rangeOfString:content];
                [cell.lblPhone setColor:[UIColor redColor] fromIndex:range.location length:range.length];
            }
        }
        [cell.lblName setNeedsDisplay];
        [cell.lblPhone setNeedsDisplay];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [_searchKeys objectAtIndex:[indexPath section]];
    NSArray *nameSection = [_searchResults objectForKey:key];
    NSArray *namePhones=[nameSection objectAtIndex:[indexPath row]];
    NSLog(@"%@",namePhones);
}

#pragma mark SearchBar Delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self search:searchText];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self search:[searchBar text]];
    [self.tableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //滚动就隐藏
    if(![self.callViewFrame isHidden]){
        [self dialViewHidden];
    }
}

- (ABAddressBookRef)getAbAddressBook
{
    ABAddressBookRef addressBook = nil;
    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    //等待同意后向下执行
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    return addressBook;
}

- (void)loadContact
{
    _dataResults=[[NSMutableDictionary alloc]init];
    _searchKeys=[[NSMutableArray alloc]init];
    _searchResults=[[NSMutableDictionary alloc]init];
    NSMutableDictionary *contact=[[NSMutableDictionary alloc]init];
    ABAddressBookRef addressBook=[self getAbAddressBook];
    if (addressBook) {
        CFArrayRef results =ABAddressBookCopyArrayOfAllPeople(addressBook);
        for(int i = 0; i < CFArrayGetCount(results); i++) {
            ABRecordRef person = CFArrayGetValueAtIndex(results, i);
            //姓
            NSString *firstName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonFirstNameProperty);
            if(firstName==nil) {
                firstName=@"";
            }
            //名
            NSString *lastname = (__bridge NSString*)ABRecordCopyValue(person, kABPersonLastNameProperty);
            if(lastname==nil) {
                lastname=@"";
            }
            NSString *name=[[NSString alloc]initWithFormat:@"%@%@",lastname,firstName];
            if([@""isEqualToString:name]){
                //姓名如果为空则取企业名
                NSString *organizationName = (__bridge NSString*)ABRecordCopyValue(person, kABPersonOrganizationProperty);
                if(![@""isEqualToString:organizationName]&&organizationName!=nil){
                    name=organizationName;
                }
            }
            
            ABMultiValueRef phoneRef = ABRecordCopyValue(person, kABPersonPhoneProperty);
            for (int k = 0; k<ABMultiValueGetCount(phoneRef); k++) {
                NSString * personPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneRef, k);
                personPhone=[Common formatPhone:personPhone];
                //过滤不能拨打的号码
                if([personPhone length]!=11){
                    continue;
                }
                [contact setObject:name forKey:personPhone];
            }
        }
        CFRelease(results);
        CFRelease(addressBook);
        for(id phone in contact){
            //姓名
            NSString *name=[contact objectForKey:phone];
            //首字母
            NSString *hName=@"#";
            //获取首字母英文
            NSString *strName=[ChineseToPinyin pinyinFromChiniseString:name];
            if(![@"" isEqualToString:strName]&&strName!=nil) {
                unichar c=[[[strName substringWithRange:NSMakeRange(0,1)] lowercaseString] characterAtIndex:0];
                if(c>=97&&c<=122){
                    hName=[NSString stringWithFormat:@"%c",c];
                }
            }
            //获取当前字母前缀下的所有联系人成员
            NSMutableArray *mutable=[_dataResults objectForKey:hName];
            if(mutable==nil){
                mutable=[[NSMutableArray alloc]init];
            }
            [mutable addObject:@[name,phone]];
            [_dataResults setObject:mutable forKey:hName];
        }
        _dataKeys = [[NSMutableArray alloc] initWithArray:[[_dataResults allKeys]sortedArrayUsingSelector:@selector(compare:)]];
        _searchKeys=[[NSMutableArray alloc]initWithArray:_dataKeys];
        _searchResults=[[NSMutableDictionary alloc]initWithDictionary:_dataResults];
        [self.tableView reloadData];
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
                NSString *n=[name objectAtIndex:0];
                if(![@"" isEqualToString:n]){
                    if ([n rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
                        //原文查找
                        flag=YES;
                    } else if ([[ChineseToPinyin pinyinFromChiniseString:n] rangeOfString:[searchString uppercaseString] options:NSCaseInsensitiveSearch].location != NSNotFound) {
                        //拼音查找
                        flag=YES;
                    }
                }
                NSString *p=[name objectAtIndex:1];
                if ([[Common formatPhone:p] rangeOfString:[searchString uppercaseString] options:NSCaseInsensitiveSearch].location != NSNotFound) {
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
//拨号盘显示
- (void)dialViewShow
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromBottom;
    animation.duration = 0.6;
    [self.callViewFrame.layer addAnimation:animation forKey:nil];
    self.callViewFrame.hidden = NO;
}
//拨号盘隐藏
- (void)dialViewHidden
{
    CATransition *animation = [CATransition animation];
    animation.type = kCATransitionFromTop;
    animation.duration = 0.6;
    [self.callViewFrame.layer addAnimation:animation forKey:nil];
    self.callViewFrame.hidden = YES;
}

- (void)callViewHiddenShow:(id)sender
{
    if([self.callViewFrame isHidden]){
        [self dialViewShow];
    }else{
        [self dialViewHidden];
    }
}

@end