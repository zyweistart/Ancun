//
//  InsuranceCompanyViewController.m
//  Car
//
//  Created by Start on 10/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "InsuranceCompanyViewController.h"
#import "ReminderViewController.h"

@interface InsuranceCompanyViewController ()

@end

@implementation InsuranceCompanyViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"合作保险公司"];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSInteger row=[indexPath row];
        NSDictionary *data=[self.dataItemArray objectAtIndex:row];
        [cell.textLabel setText:[data objectForKey:@"insurerName"]];
        return cell;
    }else{
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[[ReminderViewController alloc]init] animated:YES];
}

@end