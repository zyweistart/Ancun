//
//  JHGridTableView.m
//  GridViewDemo
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import "JHGridTableView.h"

@implementation JHGridTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate   = self;
        [self addSubview:_tableView];
    }
    return self;
}
- (void)reloadData{
    [_tableView reloadData];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    NSLog(@"ceil(%ld , %f) = %f",(long)[_datasource numberOfGrids],numberOfGridsInRow,ceil([_datasource numberOfGrids]/numberOfGridsInRow));
    return ceil([_datasource numberOfGrids]/numberOfGridsInRow);
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdtStr = [NSString stringWithFormat:@"JHGridViewCell-%ld",indexPath.row];
    JHGridTableViewCell *cell = (JHGridTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdtStr];
    if (!cell) {
        
        cell = [[JHGridTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle
                                         reuseIdentifier:reuseIdtStr
                                                delegate:self
                                               rowHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath]
                                               indexPath:indexPath];
        
        
    }
    
    // Configure the cell...
    [self updateCell:cell];
    
    return cell;
    
}
// 更新Cell
- (void)updateCell:(JHGridTableViewCell *)cell{
    
    static int i = 0;
    
    if(i < numberOfGridsInRow){
        
        // 设置图片（更新操作）
        [cell.gridViews[i] setImage:[_datasource imageAtIndex:[cell.gridViews[i]index]]];
        
        // i++
        i++;
        
        // 继续更新
        [self updateCell:cell];
    }
    else{
        
        // 归零
        i =0;
    }
    
}

#pragma mark - JHGridTableViewCellDelegate
- (void)didTapGrid:(JHGridView *)gridView{
    
    [_delegate gridTableView:self didSelectGridView:gridView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
