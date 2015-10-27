//
//  VideoListViewController.m
//  Car
//
//  Created by Start on 10/20/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoCell.h"

@interface VideoListViewController ()

@end

@implementation VideoListViewController

- (id)init
{
    self=[super init];
    if(self){
        [self setTitle:@"录像存证"];
        [self.dataItemArray addObjectsFromArray:@[@"去电录音",@"录音笔",@"随手拍",@"录像存证",@"设置"]];
        [self buildTableViewWithView:self.view];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if([[self dataItemArray] count]>0){
        static NSString *cellIdentifier = @"SAMPLECell";
        VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(!cell) {
            cell = [[VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        return cell;
    }else{
        return [tableView cellForRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"删除了");
}

@end