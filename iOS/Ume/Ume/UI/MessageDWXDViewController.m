//
//  MessageDWXDViewController.m
//  Ume
//  对我心动
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageDWXDViewController.h"
#import "MessageDWXDCell.h"

@interface MessageDWXDViewController ()

@end

@implementation MessageDWXDViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"对我心动"];
        self.isFirstRefresh=NO;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(200);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    MessageDWXDCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[MessageDWXDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
