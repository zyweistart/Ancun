//
//  InsuranceCompanyViewController.m
//  Car
//
//  Created by Start on 10/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "InsuranceCompanyViewController.h"
#import "ReminderViewController.h"
#import "ChineseToPinyin.h"

@interface InsuranceCompanyViewController ()

@end

@implementation InsuranceCompanyViewController{
    int currentType;
}

- (id)initWithType:(int)type
{
    currentType=type;
    self=[super init];
    if(self){
        [self setTitle:@"合作保险公司"];
        self.dataKeys=[[NSMutableArray alloc]init];
        self.dataResults=[[NSMutableDictionary alloc]init];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (void)loadHttp
{
    self.hRequest=[[HttpRequest alloc]initWithRequestCode:501];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setObject:@"getInsurer" forKey:@"act"];
    [self.hRequest setDelegate:self];
    [self.hRequest setIsShowFailedMessage:YES];
    [self.hRequest handleWithParams:params];
}

//右侧添加一个索引表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.dataKeys;
}

//设置每个section显示的Title
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section{
    if ([self.dataKeys count] == 0){
        return nil;
    }
    return [self.dataKeys objectAtIndex:section];
}

//指定有多少个分区(Section)，默认为1
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return ([self.dataKeys count] > 0) ? [self.dataKeys count] : 1;
}

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.dataKeys count] == 0) {
        return 0;
    } else {
        NSString *key = [self.dataKeys objectAtIndex:section];
        NSArray *nameSection = [self.dataResults objectForKey:key];
        return [nameSection count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataResults] count]>0){
        return CGHeight(45);
    }else{
        return self.tableView.bounds.size.height;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataResults] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSString *key = [self.dataKeys objectAtIndex:[indexPath section]];
        NSArray *section = [self.dataResults objectForKey:key];
        NSDictionary *data=[section objectAtIndex:[indexPath row]];
        [cell.textLabel setText:[data objectForKey:@"insurerName"]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self dataResults] count]>0){
        NSString *key = [self.dataKeys objectAtIndex:[indexPath section]];
        NSArray *section = [self.dataResults objectForKey:key];
        NSDictionary *data=[section objectAtIndex:[indexPath row]];
        
        ReminderViewController *mReminderViewController=[[ReminderViewController alloc]init];
        [mReminderViewController setMapData:self.mapData];
        [mReminderViewController setInsuranceData:data];
        if(currentType==2){
            [mReminderViewController setInsuranceOData:@{}];
        }
        [self.navigationController pushViewController:mReminderViewController animated:YES];
    }
}

- (void)requestFinishedByResponse:(Response*)response requestCode:(int)reqCode
{
    if([response successFlag]){
        NSDictionary *rData=[[response resultJSON] objectForKey:@"data"];
        if(rData){
            //获取数据列表
            NSDictionary *tabData=rData;
            if(tabData){
                if([self currentPage]==0){
                    [[self dataResults] removeAllObjects];
                }
                for(id data in tabData){
                    NSString *name=[data objectForKey:@"insurerName"];
                    //首字母
                    NSString *hName=@"#";
                    //获取首字母英文
                    NSString *strName=[ChineseToPinyin pinyinFromChiniseString:name];
                    if(![@"" isEqualToString:strName]&&strName!=nil) {
                        unichar c=[[[strName substringWithRange:NSMakeRange(0,1)] uppercaseString] characterAtIndex:0];
                        hName=[NSString stringWithFormat:@"%c",c];
                    }
                    //获取当前字母前缀下的所有联系人成员
                    NSMutableArray *mutable=[self.dataResults objectForKey:hName];
                    if(mutable==nil){
                        mutable=[[NSMutableArray alloc]init];
                    }
                    [mutable addObject:data];
                    [self.dataResults setObject:mutable forKey:hName];
                }
                self.dataKeys = [[NSMutableArray alloc] initWithArray:[[self.dataResults allKeys]sortedArrayUsingSelector:@selector(compare:)]];
            }
        }
    }
    [self loadDone];
}

@end