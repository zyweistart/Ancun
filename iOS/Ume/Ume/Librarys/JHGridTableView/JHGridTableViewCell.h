//
//  JHGridTableViewCell.h
//  GridViewDemo
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHGridView.h"
#import "JHGridTableViewControllerConstants.h"

@protocol JHGridTableViewCellDelegate <NSObject>

- (void)didTapGrid:(JHGridView *)gridView;

@end

@interface JHGridTableViewCell : UITableViewCell
@property (nonatomic,strong)NSIndexPath     *indexPath;
@property (nonatomic,strong)NSMutableArray  *gridViews;
@property (nonatomic,assign)id <JHGridTableViewCellDelegate> delegate;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier delegate:(id <JHGridTableViewCellDelegate>)delegate rowHeight:(float)height indexPath:(NSIndexPath *)indexPath;
@end
