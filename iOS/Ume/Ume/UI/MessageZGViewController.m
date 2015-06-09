//
//  MessageZGViewController.m
//  Ume
//  赞过
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageZGViewController.h"
#import "MessageZGCell.h"

@interface MessageZGViewController ()

@end

@implementation MessageZGViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"赞过";
        self.isFirstRefresh=NO;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(200);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    MessageZGCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[MessageZGCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
