//
//  AboutUsViewController.m
//  Ume
//
//  Created by Start on 15/7/21.
//  Copyright (c) 2015年 Ancun. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (id)init{
    self=[super init];
    if(self){
        [self cTitle:@"关于懂我"];
        [self.dataItemArray addObject:@"使用帮助"];
        [self.dataItemArray addObject:@"联系我们"];
        [self.dataItemArray addObject:@"用户协议"];
        [self.dataItemArray addObject:@"去评分"];
        [self buildTableViewWithView:self.view style:UITableViewStyleGrouped];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataItemArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CGHeight(45);
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row=[indexPath row];
    static NSString *cellIdentifier = @"SWITCHCELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *content=[self.dataItemArray objectAtIndex:row];
    [cell.textLabel setText:content];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}


@end
