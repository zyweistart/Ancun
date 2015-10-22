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
    UIView *dialView;
    UIView *tabBGView;
    UIButton *showHidden;
    CGFloat mDialWidth,mDialHeight;
    int currentType;
    BOOL isFirstAddView;
}

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"通讯录"];
        [self.view setBackgroundColor:BGCOLOR];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{    
    static NSString *SectionsTableIdentifier1 = @"SectionsTableIdentifier1";
    static NSString *SectionsTableIdentifier2 = @"ACContactCell";
    static NSString *SectionsTableIdentifier3 = @"SectionsTableIdentifier3";
    
    if ([_searchKeys count] == 0) {
        NSInteger row=[indexPath row];
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
}

@end
