//
//  BaseTableViewCell.h
//  AncunFramework
//
//  Created by Start on 12/29/15.
//  Copyright © 2015 Ancun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseEntity.h"

@interface BaseTableViewCell : UITableViewCell

//布局
- (void)layoutCell;
//设置Cell数据
- (void)setCellData:(BaseEntity*)entity;
//动态计算高度
- (CGFloat)layoutHeight;

@end
