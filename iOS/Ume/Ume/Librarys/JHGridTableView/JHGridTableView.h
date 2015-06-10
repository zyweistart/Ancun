//
//  JHGridTableView.h
//  GridViewDemo
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHGridTableViewControllerConstants.h"
#import "JHGridTableViewCell.h"
@class JHGridTableView;
@class JHGridView;

@protocol JHGridTableViewDatasource <NSObject>

- (NSInteger)numberOfGrids;                 // 总共有多少grids
- (UIImage *)imageAtIndex:(NSInteger)index; // 对应位置的grid的图片

@end

@protocol JHGridTableViewDelegate <NSObject>

@optional
- (void)gridTableView:(JHGridTableView *)gridTableView didSelectGridView:(JHGridView *)gridView;// 点击了某个grid

@end

@interface JHGridTableView : UIView<UITableViewDataSource,UITableViewDelegate,JHGridTableViewCellDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) id <JHGridTableViewDatasource> datasource;
@property (nonatomic,assign) id <JHGridTableViewDelegate>   delegate;

- (void)reloadData;
@end
