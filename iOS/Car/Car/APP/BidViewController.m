//
//  BidViewController.m
//  Car
//
//  Created by Start on 10/15/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "BidViewController.h"

@interface BidViewController ()

@end

@implementation BidViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"我的"];
        self.dataItemArray=[NSMutableArray arrayWithArray:@[@"去电录音",@"现场录音",@"录像存证",@"随手拍"]];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"player_s"]];
    cell.textLabel.text = [self.dataItemArray objectAtIndex:indexPath.row];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

@end
