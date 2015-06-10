//
//  JHGridView.m
//  GridViewDemo
//
//  Created by 流星 on 14-5-14.
//  Copyright (c) 2014年 流星. All rights reserved.
//

#import "JHGridView.h"

@implementation JHGridView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.alpha = 0.0f;  // 默认隐藏
        
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 1;
        
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
        
        [self addSubview:_imageView];
        
    }
    return self;
}
- (void)setIndexPath:(NSIndexPath *)indexPath{
    
    _indexPath = indexPath;
    _index = indexPath.section*numberOfGridsInRow + indexPath.row;
    
}
- (void)setImage:(UIImage *)image{
    
    // 有图片就显示
    if (image != nil) {
        
        self.alpha = 1.0f;
        
        _image = image;
        _imageView.image = image;
        
    }
    // 没图片就隐藏
    else
    {
        
        self.alpha = 0.0f;
    }
    
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
