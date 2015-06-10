//
//  JHGridTableViewController.h
//  GridTableView
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHGridTableViewControllerConstants.h"
#import "JHGridTableViewCell.h"
#import "JHGridView.h"

@protocol JHGridTableViewControllerDatasource <NSObject>

- (NSInteger)numberOfGrids;                 // 总共有多少grids
- (UIImage *)imageAtIndex:(NSInteger)index; // 对应位置的grid的图片

@end

@protocol JHGridTableViewControllerDelegate <NSObject>

@optional
    - (void)tableView:(UITableView *)tableView didSelectGridView:(JHGridView *)gridView;// 点击了某个grid

@end

@interface JHGridTableViewController : UITableViewController
@property (nonatomic,assign)id <JHGridTableViewControllerDatasource> datasource;
@property (nonatomic,assign)id <JHGridTableViewControllerDelegate>   delegate;
@end
