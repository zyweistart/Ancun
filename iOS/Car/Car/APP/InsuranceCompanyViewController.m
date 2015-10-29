//
//  InsuranceCompanyViewController.m
//  Car
//
//  Created by Start on 10/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "InsuranceCompanyViewController.h"

@interface InsuranceCompanyViewController ()

@end

@implementation InsuranceCompanyViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"合作保险公司"];
        [self.dataItemArray addObjectsFromArray:@[@"去电录音",@"录音笔",@"随手拍",@"录像存证",@"设置"]];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        [cell.textLabel setText:@"合作医院"];
        return cell;
    }else{
        return [tableView cellForRowAtIndexPath:indexPath];
    }
}

@end