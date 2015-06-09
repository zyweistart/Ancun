//
//  MessageZDWDViewController.m
//  Ume
//  最懂我的
//  Created by Start on 15/6/3.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "MessageZDWDViewController.h"
#import "MessageZDWDCell.h"

@interface MessageZDWDViewController ()

@end

@implementation MessageZDWDViewController

- (id)init{
    self=[super init];
    if(self){
        self.title=@"最懂我的";
        self.isFirstRefresh=NO;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return CGHeight(200);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"SAMPLECell";
    MessageZDWDCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[MessageZDWDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

@end
