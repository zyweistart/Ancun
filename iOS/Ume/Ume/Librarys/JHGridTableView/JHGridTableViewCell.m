//
//  JHGridTableViewCell.m
//  GridViewDemo
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import "JHGridTableViewCell.h"


@implementation JHGridTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  delegate:(id<JHGridTableViewCellDelegate>)delegate rowHeight:(float)height indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        // Initialization code
        self.indexPath = indexPath;
        self.delegate  = delegate;
        
        self.gridViews = [[NSMutableArray alloc]init];
        
        // 布局gridview
        [self addGridViews:height];
        
    }
    return self;
}
- (void)addGridViews:(float)rowHeight{
    
    float width     = self.bounds.size.width  - 2*kPaddingX;
    float height    = rowHeight - kSpaceY;
    float fitWidth  = (width - kSpaceX*(numberOfGridsInRow-1))/numberOfGridsInRow;
    float fitHeight = height;
    
    @autoreleasepool {
        
        for(int i=0;i<numberOfGridsInRow;i++){

            JHGridView *grid =(JHGridView *)[self viewWithTag:i+kGridBtnTag];
            if(grid == nil){
               
                // 计算坐标
                CGRect frame = CGRectMake(kPaddingX+(i%(int)numberOfGridsInRow)*(fitWidth+kSpaceX),kSpaceY, fitWidth, fitHeight);
                
                grid =[[JHGridView alloc]initWithFrame:frame];
                
                // 位置
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:self.indexPath.row];
                [grid setIndexPath:indexPath];
                [grid setTag:i+kGridBtnTag];
                [self addSubview:grid];
                
                // 保存grid
                [_gridViews addObject:grid];
                
                // 给Grid添加单击手势
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
                tapGes.numberOfTapsRequired = 1;
                [grid addGestureRecognizer:tapGes];
            }
            
        }

    }
}
- (void)awakeFromNib
{
    // Initialization code
}
- (void)handleTap:(UITapGestureRecognizer *)tapGes{
    
    [_delegate didTapGrid:(JHGridView *)tapGes.view];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
