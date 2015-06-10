//
//  JHGridView.h
//  GridViewDemo
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHGridTableViewControllerConstants.h"
@interface JHGridView : UIView

@property (nonatomic,strong)NSIndexPath *indexPath; // 坐标INDEXPATH型
@property (nonatomic,assign)NSInteger    index;     // 位置INT型
@property (nonatomic,strong)UIImageView *imageView; // 图片
@property (nonatomic,strong)UIImage     *image;     // 图片

@end
